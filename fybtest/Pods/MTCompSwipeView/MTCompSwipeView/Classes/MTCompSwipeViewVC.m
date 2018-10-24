//
//  MTCompSwipeViewVC.m
//  MTCompSwipeView
//
//  Created by Jason Li on 2018/3/16.
//

#import "MTCompSwipeViewVC.h"
#import "MTSwipeVM.h"

@import SDWebImage;

@interface MTCompSwipeViewVC ()
@property (nonatomic, strong) UIPageControl *pageControl; // 分页组件

@property (nonatomic, strong) MTSwipeVM *viewModel; // 视图模型

@end

@implementation MTCompSwipeViewVC

- (void)toReloadComponent {
    // 刷新业务数据
    [self.viewModel toReloadDataSourceWithServiceData:self.compServiceData];
    
    // 刷新UI
    self.pageControl.numberOfPages = self.viewModel.dataSource.count;
    
    if (self.viewModel.dataSource.count > 1) [self toOperSetAutoScroll];
    [self.viewSwipe reloadData];
    
}

/**
 默认组件大小，宽度：通屏，高度是宽度的0.618倍（黄金分割），子类可以覆盖自定义

 @return 组件Size
 */
- (CGSize)componentSize {
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = width * 0.618;
    return CGSizeMake(width, ceilf(height));
}

- (void)componentDidChangedServiceData {
    [self toReloadComponent];
}

//MARK: - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.viewSwipe];
    [self.view addSubview:self.pageControl];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.viewModel.dataSource.count > 1) [self toOperSetAutoScroll];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(toOperAutoScroll) object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLayoutConstraint {
    __weak typeof(self) weakSelf = self;
    [self.viewSwipe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf.view);
    }];
}

//MARK: - Getter And Setter
- (MTSwipeVM *)viewModel {
    if (_viewModel) return _viewModel;
    _viewModel = [[MTSwipeVM alloc] init];
    
    return _viewModel;
}

- (SwipeView *)viewSwipe {
    if (_viewSwipe) return _viewSwipe;
    _viewSwipe = [[SwipeView alloc] init];
    _viewSwipe.pagingEnabled = YES;
    _viewSwipe.dataSource = self;
    _viewSwipe.delegate = self;
    
    _viewSwipe.wrapEnabled = YES;
    
    return _viewSwipe;
}

- (UIPageControl *)pageControl {
    if (_pageControl) return _pageControl;
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [[UIColor grayDataColor] colorWithAlphaComponent:0.5f];
    
    return _pageControl;
}

- (MTSwipePage *)swipePageWithIndexPath:(NSInteger)index {
    return (MTSwipePage *)self.viewModel.dataSource[index];
}

- (void)setHiddenPageControl:(BOOL)hiddenPageControl {
    [self.pageControl setHidden:hiddenPageControl];
    
}

- (UIImage *)swipeViewDefaultImage {
    // 默认图片反馈nil
    return nil;
}

- (NSTimeInterval)swipeViewAutoScrollTimeInterval {
    return 4.f;
}

//MARK: - Action
- (void)toOperSetAutoScroll {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(toOperAutoScroll) object:nil];
    [self performSelector:@selector(toOperAutoScroll) withObject:nil afterDelay:[self swipeViewAutoScrollTimeInterval]];
}

- (void)toOperAutoScroll {
    [self.viewSwipe scrollByNumberOfItems:1 duration:.5f];
}

//MARK: - SwipeView DataSource And Delegate
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    return self.viewModel.dataSource.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    UIImageView *imgView = (UIImageView *)view;
    if (!imgView) {
        imgView = [[UIImageView alloc] initWithFrame:swipeView.bounds];
        imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
    }
    [imgView sd_setImageWithURL:[[self swipePageWithIndexPath:index] pagePicURL] placeholderImage:[self swipeViewDefaultImage]];

    return imgView;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView {
    return swipeView.bounds.size;
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView {
    [self toOperSetAutoScroll];
    self.pageControl.currentPage = swipeView.currentPage;
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
    MTSwipePage *page = [self swipePageWithIndexPath:index];
    if (page.isNativeLanding) {
        UIViewController<MTComponentProtocol> *vc = [page instanceLandingVC];
        [vc setupComponentServiceData:self.compServiceData];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        if (page.landingURL.length > 0) {
            MTWebViewController *webView = [[MTWebViewController alloc] init];
            webView.title = page.title;
            [webView toLoadRequest:[page requestPageLandingURl]];
            [self.navigationController pushViewController:webView animated:YES];
        }
    }

}

@end
