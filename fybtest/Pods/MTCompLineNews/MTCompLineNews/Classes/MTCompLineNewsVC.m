//
//  MTCompLineNewsVC.m
//  AFNetworking
//
//  Created by Jason Li on 2018/4/11.
//

#import "MTCompLineNewsVC.h"
#import "MTNewsVM.h"

@interface MTCompLineNewsVC ()

@property (nonatomic, strong) MTNewsVM *viewModel; // 视图模型

@end

@implementation MTCompLineNewsVC
- (void)toReloadComponent {
    // 刷新业务数据
    [self.viewModel toReloadDataSourceWithServiceData:self.compServiceData];
    
    if (self.viewModel.dataSource.count > 1) [self toOperSetAutoScroll];
    [self.viewSwipe reloadData];
    
}

- (NSTimeInterval)swipeViewAutoScrollTimeInterval {
    return 4.f;
}

/**
 默认组件大小，宽度：通屏，高度是宽度的0.618倍（黄金分割），子类可以覆盖自定义
 
 @return 组件Size
*/
- (CGSize)componentSize {
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = self.rowHeight;
    return CGSizeMake(width, ceilf(height));
}

- (void)componentDidChangedServiceData {
    [self toReloadComponent];
}

//MARK: - Action
- (void)toOperSetAutoScroll {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(toOperAutoScroll) object:nil];
    [self performSelector:@selector(toOperAutoScroll) withObject:nil afterDelay:[self swipeViewAutoScrollTimeInterval]];
}

- (void)toOperAutoScroll {
    [self.viewSwipe scrollByNumberOfItems:1 duration:.5f];
}

//MARK: - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.contentInsets = self.edgeInsets;
    
    [self.view addSubview:self.titleImageView];
    [self.view addSubview:self.viewSwipe];
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

//MARK: - Layout
- (void)setupLayoutConstraint {
    __weak typeof(self) weakSelf = self;
    UIImage *image = [self lineNewsTitleImage];
    if (image) {
        CGFloat width = (image.size.width/image.size.height)*(self.view.view_height - self.view.contentInsets.top - self.view.contentInsets.bottom);
        [self.titleImageView setImage:image];
        [self.titleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.view.contentInsets.left);
            make.top.mas_equalTo(weakSelf.view.contentInsets.top);
            make.bottom.mas_equalTo(-weakSelf.view.contentInsets.bottom);
            make.width.mas_equalTo(width);
        }];
        
        [self.viewSwipe mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(weakSelf.view);
            make.left.mas_equalTo(weakSelf.titleImageView.mas_right).mas_offset(self.controlInterval);
        }];
    } else {
        [self.viewSwipe mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.view);
        }];
    }
    
}

//MARK: - Getter And Setter
- (MTNewsVM *)viewModel {
    if (_viewModel) return _viewModel;
    _viewModel = [[MTNewsVM alloc] init];
    
    return _viewModel;
}

- (SwipeView *)viewSwipe {
    if (_viewSwipe) return _viewSwipe;
    _viewSwipe = [[SwipeView alloc] init];
    _viewSwipe.pagingEnabled = YES;
    _viewSwipe.dataSource = self;
    _viewSwipe.delegate = self;
    
    _viewSwipe.wrapEnabled = YES;
    _viewSwipe.vertical = YES;
    
    return _viewSwipe;
}

- (UIImageView *)titleImageView {
    if (_titleImageView) return _titleImageView;
    _titleImageView = [[UIImageView alloc] init];
    _titleImageView.backgroundColor = [UIColor clearColor];
    
    return _titleImageView;
}


- (MTNews *)newsWithIndexPath:(NSInteger)index {
    return (MTNews *)self.viewModel.dataSource[index];
}

- (UIImage *)lineNewsTitleImage {
    return nil;
}

//MARK: - SwipeView DataSource And Delegate
- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView {
    return self.viewModel.dataSource.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    UILabel *label = (UILabel *)view;
    
    if (!view) {
        label = [[UILabel alloc] initTitle];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.font = [UIFont descFont];
        label.textColor = [UIColor dataColor];
        
    }
    
    MTNews *news = [self newsWithIndexPath:index];
    label.text = news.title;
    
    return label;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView {
    return swipeView.bounds.size;
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView {
    [self toOperSetAutoScroll];
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
    MTNews *news = [self newsWithIndexPath:index];
    if (news.isNativeLanding) {
        UIViewController<MTComponentProtocol> *vc = [news instanceLandingVC];
        [vc setupComponentServiceData:self.compServiceData];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        if (news.landingURL.length > 0) {
            MTWebViewController *webView = [[MTWebViewController alloc] init];
            webView.title = news.title;
            [webView toLoadRequest:[news requestPageLandingURl]];
            [self.navigationController pushViewController:webView animated:YES];
        }
    }
    
}

@end
