//
//  MTCompCollectionViewVC.m
//  MTCompCollectionView
//
//  Created by Jason Li on 2018/3/21.
//

#import "MTCompCollectionViewVC.h"
#import "MTCompCollectionViewLayout.h"
#import "MTCollectionItemVM.h"
#import "MTCollectionItem.h"

@import SDWebImage;

@import MTFramework;

static NSString *MTCompCollectionViewVCCellIdentifier = @"MTCompCollectionViewVCCellIdentifier";

@import MTBaseObjects;

@interface MTCompCollectionViewVC ()
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) MTCompCollectionViewLayout *layout; // 布局对象

@property (nonatomic, strong) MTCollectionItemVM *viewModel; // 视图模型

@end

@implementation MTCompCollectionViewVC

- (void)toReloadComponent {
    // 刷新业务数据
    [self.viewModel toReloadDataSourceWithServiceData:self.compServiceData];
    
    [self.collectionView reloadData];
    
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

- (Class)registerCollectionViewCellClass {
    return [MTBaseCollectionViewCell class];
}

- (void)componentDidChangedServiceData {
    [self toReloadComponent];
}

- (void)toPerpareLayout:(MTCompCollectionViewLayout *)layout {
    layout.rowCount = 2;
    layout.itemCountRow = 3;
    
    layout.sectionInset = UIEdgeInsetsZero;//self.edgeInsets;
    layout.minimumLineSpacing = 0.f;
    layout.minimumInteritemSpacing = 0.f;
    
}

//MARK: - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[self registerCollectionViewCellClass] forCellWithReuseIdentifier:MTCompCollectionViewVCCellIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - Layout
- (void)setupLayoutConstraint {
    __weak typeof(self) weakSelf = self;
    if (!self.collectionView.superview) [self.view addSubview:self.collectionView];
        
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
}

//MARK: - Getter And Setter
- (UICollectionView *)collectionView {
    if (_collectionView) return _collectionView;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    
    _collectionView.bounces = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    return _collectionView;
}

- (MTCompCollectionViewLayout *)layout {
    if (_layout) return _layout;
    _layout = [[MTCompCollectionViewLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    [self toPerpareLayout:_layout];
    
    return _layout;
}

- (MTCollectionItemVM *)viewModel {
    if (_viewModel) return _viewModel;
    _viewModel = [[MTCollectionItemVM alloc] init];
    
    return _viewModel;
}

//MARK: Collection View DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTBaseCollectionViewCell *cell = (MTBaseCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:MTCompCollectionViewVCCellIdentifier forIndexPath:indexPath];
    
    cell.layoutType = MTTitleLayoutBottom;
    
    NSString *imageName = [self.viewModel imageNameAtIndexPath:indexPath];
    if (imageName.length > 0) {
        cell.imageName = imageName;
    } else {
        cell.imageURL = [self.viewModel imageURLAtIndexPath:indexPath];
    }
    
    cell.title = [self.viewModel itemTitleAtIndexPath:indexPath];
    
    return cell;
}

//MARK: Collection view Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(self.navigationController, @"The self.navigationController is nil.");
    
    MTCollectionItem *item = [self.viewModel collectionItemAtIndexPath:indexPath];
    UIViewController *vc = [item instanceLandingVC];
    
    if (vc && item.isNativeLanding) {
        vc.title = item.itemTitle;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSURLRequest * request = [[self.viewModel collectionItemAtIndexPath:indexPath] requestPageLandingURl];
        if (!request) {
            [self showComingSoon];
            return;
        }
        NSAssert(request, @"No more info to landing view controller.");
        
        MTWebViewController *webVC = [[MTWebViewController alloc] init];
        webVC.title = item.itemTitle;
        [webVC toLoadRequest:request];
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellHeight = CGFLOAT_MIN;
    CGFloat cellWidth = CGFLOAT_MIN;
    
    NSInteger count = [self collectionView:collectionView numberOfItemsInSection:indexPath.section];
    
    MTCompCollectionViewLayout *layout = (MTCompCollectionViewLayout *)collectionViewLayout;
    
    CGFloat contentWidth = floorf(CGRectGetWidth(collectionView.bounds) - layout.sectionInset.left - layout.sectionInset.right);
    CGFloat contentHeight = floorf(CGRectGetHeight(collectionView.bounds) - layout.sectionInset.top - layout.sectionInset.bottom);
    
    CGFloat minimumInteritemSpacing = layout.minimumInteritemSpacing;
    CGFloat minimumLineSpacing = layout.minimumLineSpacing;
    if (layout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        minimumInteritemSpacing = layout.minimumLineSpacing;
        minimumLineSpacing = layout.minimumInteritemSpacing;
    }
    
    CGFloat countOfLine = ceilf((CGFloat)count/layout.rowCount);
    
    if (count <= layout.itemCountRow) {
        //横向单行布局
        cellHeight = contentHeight;
        cellWidth = ((contentWidth - ceilf(minimumInteritemSpacing*(count - 1)))/(CGFloat)count);
    } else if (count <= layout.itemCountRow*layout.rowCount) {
        //横向多行布局
        cellHeight = (contentHeight - minimumLineSpacing*(layout.rowCount - 1))/layout.rowCount;
        cellWidth = (contentWidth - ceilf(minimumInteritemSpacing*(countOfLine - 1)))/countOfLine;
    } else {
        //横向双行多页布局
        cellHeight = (contentHeight - minimumLineSpacing*(layout.rowCount - 1))/layout.rowCount;
        cellWidth = (contentWidth - ceilf(minimumInteritemSpacing*(countOfLine - 1)))/layout.itemCountRow;
    }
    
    return CGSizeMake(floorf(cellWidth), floorf(cellHeight));
}

@end
