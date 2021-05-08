//
//  BaseTableViewController.m
//  TestProject
//
//  Created by chen on 7/6/18.
//  Copyright © 2018 fourye. All rights reserved.
//

#import "FactoryViewController.h"
#import "FactoryCell.h"
#import "UIView+YYAdd.h"

NSString *const arrow = @" →";
const uint rowCount = 2;
@interface CollectionHeader: UICollectionReusableView
@property (nonatomic, strong) UILabel *label;
@end

@implementation CollectionHeader
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.label = [[UILabel alloc] init];
    self.label.font = [UIFont systemFontOfSize:12];
    self.label.textColor = [UIColor blackColor];
    self.label.left = 10;
    self.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    [self addSubview: self.label];
    return self;
}
@end

@interface FactoryViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray<FactorySectionModel *> *datas;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *line;
@end

@implementation FactoryViewController
void empty(void){};
- (instancetype)initWithTitle:(NSString *)title {
    self = [super init];
    self.inCenter = YES;
    self.title = title;
    return self;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.alloc.init;
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(kScreenWidth / rowCount, 50);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//设置其边界
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeader"];
    }
    return _collectionView;
}

- (void)setPartTable:(BOOL)halfTable {
    _partTable = halfTable;
    if (halfTable == YES) {
        self.line.hidden = NO;
        self.collectionView.frame = CGRectMake(0, self.view.height * 0.5 - 64, self.view.width, self.view.height * 0.5);
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.line.bottom = self.collectionView.top;
        self.view.backgroundColor = [UIColor whiteColor];
        self.topHeight = kScreenHeight - self.collectionView.height - 64 - self.line.height;
    } else {
        self.collectionView.frame = self.view.bounds;
        self.line.hidden = YES;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.inCenter = YES;
    if ([self respondsToSelector:@selector(reset)]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"重置" style:(UIBarButtonItemStylePlain) target:self action:@selector(reset)];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    if (self.partTable) {
        self.collectionView.frame = CGRectMake(0, self.view.height * 0.5 - 64, self.view.width, self.view.height * 0.5);
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.view.backgroundColor = [UIColor whiteColor];
        self.line.bottom = self.collectionView.top;
        self.topHeight = kScreenHeight - self.collectionView.height - 64 - self.line.height;
        self.line.hidden = NO;
    } else {
        self.line.hidden = YES;
    }
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.5];
    self.line.height = 0.5;
    self.line.width = self.view.width;
    [self.view addSubview:self.line];
    self.line.bottom = self.collectionView.top;
    
    
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.datas = @[].mutableCopy;
    [self.collectionView registerClass:FactoryCell.class forCellWithReuseIdentifier:@"baseCell"];
//    self.tableView.alwaysBounceVertical = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.parentViewController.title = [NSString stringWithFormat:@"🤠%@",self.tabBarItem.title];
    [self.collectionView reloadData];
//    NSLog(@"%@ => viewWillAppear",self.class);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)removeTopViews {
    [self.view.subviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj != self.line && obj != self.collectionView) {
            [obj removeFromSuperview];
        }
    }];
    [self.view.layer.sublayers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj != self.line.layer && obj != self.collectionView.layer) {
            [obj removeFromSuperlayer];
        }
    }];
}

#pragma mark - ---- 添加 section
- (void)addSectionTitle:(NSString *)title {
    FactorySectionModel *section = [[FactorySectionModel alloc] init];
    section.title = title;
    section.cellModels = @[].mutableCopy;
    [self.datas addObject:section];
}

#pragma mark - ---- 添加cell
- (void)addCellWithTitle:(NSString *)title nextVC:(NSString *)name {
    if (name.length == 0) return;
    FactoryCellModel *model = [FactoryCellModel alloc].init;
    model.title = [NSString stringWithFormat:@"%@%@", title, arrow];
    model.vcClass = NSClassFromString(name);
    if (model.vcClass == nil) {
        NSAssert(model.vcClass, @"class为空");
    }
    if (self.datas.count == 0) {
        [self addSectionTitle:@""];
    }
    [self.datas.lastObject.cellModels addObject:model];
}

- (void)addCellWithTitle:(NSString *)title func:(void(*)(void))func {
    FactoryCellModel *model = [FactoryCellModel alloc].init;
    model.title = title;
    model.func = func;
    if (self.datas.count == 0) {
        [self addSectionTitle:@""];
    }
    [self.datas.lastObject.cellModels addObject:model];
}

- (void)addCellWithTitle:(NSString *)title block:(void(^)(void))block {
    FactoryCellModel *model = [FactoryCellModel alloc].init;
    model.title = title;
    model.block = block;
    if (self.datas.count == 0) {
        [self addSectionTitle:@""];
    }
    [self.datas.lastObject.cellModels addObject:model];
}

- (void)addCellWithTitle:(NSString *)title selector:(SEL)sel {
    FactoryCellModel *model = [FactoryCellModel alloc].init;
    model.title = title;
    model.sel = sel;
    if (self.datas.count == 0) {
        [self addSectionTitle:@""];
    }
    [self.datas.lastObject.cellModels addObject:model];
}


#pragma mark - ---- delegate & dataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.datas.count;
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FactoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"baseCell" forIndexPath:indexPath];
    if (indexPath.row % rowCount == rowCount - 1) {
        cell.hiddenLine = YES;
    } else {
        cell.hiddenLine = NO;
    }
    
    if (indexPath.row == [self.datas[indexPath.section] cellModels].count - 1) {
        cell.longBottomLine = YES;
    } else {
        cell.longBottomLine = NO;
    }
    [cell updateWithModel:[self.datas[indexPath.section] cellModels][indexPath.row] center:self.inCenter];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas[section].cellModels.count;
}

- (double)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return [self.datas[section] title].length ? CGSizeMake(kScreenWidth, 30) : CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeader" forIndexPath:indexPath];
    UILabel *label = header.label;
    label.text = [NSString stringWithFormat:@"• %@", [self.datas[indexPath.section] title]];
    [label sizeToFit];
    label.centerY = header.height * 0.5;
    return header;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FactoryCellModel *model = self.datas[indexPath.section].cellModels[indexPath.row];
    if (model.vcClass) {
        UIViewController *vc;
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        NSDictionary *dict = [sb valueForKey:@"identifierToNibNameMap"];
        NSArray *arr = dict.allKeys;
        if ([arr containsObject:NSStringFromClass(model.vcClass)]) {
            vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(model.vcClass)];
        }
        
        if (!vc) {
            vc = [[model.vcClass alloc] init];
        }
        if ([model.title hasSuffix:(NSString *)arrow]) {
            vc.title = [model.title substringToIndex:model.title.length - arrow.length];
        } else {
            vc.title = model.title;
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (model.block) {
        model.block();
    }
    
    if (model.func) {
        model.func();
    }
    
    if (model.sel) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:model.sel];
#pragma clang diagnostic pop
    }
}

#pragma mark - 显示选择框
- (void)selectValue:(void(^)(int first, int second))block {
    static NSString *string;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入值" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        [textField becomeFirstResponder];
//        [RACObserve(textField, text) subscribeNext:^(id  _Nullable x) {
//            string = x;
//        }];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSArray<NSString *> *strs = [string componentsSeparatedByString:@" "];
        block([strs.firstObject intValue], strs.count > 1 ? [strs[1] intValue] : 0);
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end


