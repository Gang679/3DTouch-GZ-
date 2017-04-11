//
//  ViewController.m
//  3DTouch(GZ)
//
//  Created by xinshijie on 2017/4/10.
//  Copyright © 2017年 Mr.quan. All rights reserved.
//

#import "ViewController.h"
#import "GZBaseViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate,GZBaseViewControllerDelegate>

//  tableView属性：
@property (nonatomic,strong) UITableView *tableViews;
@property (nonatomic,strong)NSMutableArray *items;
@property (nonatomic,weak)UITableViewCell *selectedCell;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"3DTouch(GZ)" ;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableViews.backgroundColor = [UIColor orangeColor];
    //1.该页面必需遵循UIViewControllerPreviewingDelegate代理
    // 重要
    [self registerForPreviewingWithDelegate:self sourceView:self.view];

}

#pragma mark - UIViewControllerPreviewingDelegate（实现代理的方法）
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    self.selectedCell = [self searchCellWithPoint:location];
    previewingContext.sourceRect = self.selectedCell.frame;
    
    GZBaseViewController *GZVC = [[GZBaseViewController alloc] init];
    GZVC.delegate = self;
    GZVC.navTitle = self.selectedCell.textLabel.text;
    return GZVC;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self tableView:self.tableViews didSelectRowAtIndexPath:[self.tableViews indexPathForCell:self.selectedCell]];
}

// 根据一个点寻找对应cell并返回cell
- (UITableViewCell *)searchCellWithPoint:(CGPoint)point {
    UITableViewCell *cell = nil;
    for (UIView *view in self.tableViews.subviews) {
        NSString *class = [NSString stringWithFormat:@"%@",view.class];
        if (![class isEqualToString:@"UITableViewWrapperView"]) continue;
        for (UIView *tempView in view.subviews) {
            if ([tempView isKindOfClass:[UITableViewCell class]] && CGRectContainsPoint(tempView.frame, point)) {
                cell = (UITableViewCell *)tempView;
                break;
            }
        }
        break;
    }
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //.自定义Cell方法
    static NSString *rid= @"cells";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[UITableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.textLabel.text = self.items[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row + 1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160 ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    GZBaseViewController *GZVC = [[GZBaseViewController alloc] init];
    GZVC.navTitle = self.items[indexPath.row];
    
    [self.navigationController pushViewController:GZVC animated:YES];
}


#pragma mark - GZBaseViewControllerDelegate
- (void)GZViewControllerDidSelectedBackItem:(GZBaseViewController *)GZVC {
    NSLog(@"back");
}

- (void)GZViewController:(GZBaseViewController *)GZVC DidSelectedDeleteItem:(NSString *)navTitle {
    [self.items removeObject:navTitle];
    [self.tableViews reloadData];
}
- (NSMutableArray *)items {
    if (!_items) {
        _items = [[NSMutableArray alloc]init];
        for (NSInteger i = 0; i < 20; i++) {
            [_items addObject:[NSString stringWithFormat:@"3DTouch(GZ)--%li",i]];
        }
    }
    return _items;
}

-(UITableView *)tableViews{
    if (!_tableViews) {
        _tableViews = [[UITableView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_tableViews];
        _tableViews.delegate = self ;
        _tableViews.dataSource = self ;
    }
    return _tableViews ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
