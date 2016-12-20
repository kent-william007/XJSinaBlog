//
//  XJHomeViewController.m
//  XJSinaBlog
//
//  Created by Kent on 15/12/25.
//  Copyright © 2015年 kent. All rights reserved.
//

#import "XJHomeViewController.h"
#import "NextViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "XJTitleButton.h"
#import "XJDropdownMenu.h"
#import "XJOAuthViewController.h"
#import "XJOAuthTool.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "XJUser.h"
#import "XJStatus.h"
#import "XJLoadMoreFooter.h"
#import "XJStatusCell.h"
#import "XJStatusFrame.h"

#import "XJNetWorking.h"

#define Data_Path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"data.plist"]


@interface XJHomeViewController ()<XJDropdownMenuDelegate>
/**
 *微博数据
 */
@property (nonatomic,strong)NSMutableArray *statusFrames;
@end

@implementation XJHomeViewController

-(NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self setupNav];

    [self setupUserInfo];
    
    [self setupRefresh];
    
    [self setDownLoadMore];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    
    
}
- (void)setupUnreadCount
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    XJOAuthModel *account = [XJOAuthTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = @"3";//tabbar右上角的提示
            [UIApplication sharedApplication].applicationIconBadgeNumber = 5;//无效？
        }else{
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.integerValue;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"未读数获取失败");
    }];
}
/**
 *  集成上拉刷新控件
 */
- (void)setupRefresh
{
    UIRefreshControl *control = [[UIRefreshControl alloc]init];
//    [control beginRefreshing];
    NSAttributedString *attributedStr = [[NSAttributedString alloc]initWithString:@"正在刷新..."];
    control.attributedTitle = attributedStr;
    [control addTarget:self action:@selector(setupRefreshChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    // 2.马上进入刷新状态(仅仅是显示刷新状态，并不会触发UIControlEventValueChanged事件)
    [control beginRefreshing];
    
    // 3.马上加载数据
    [self setupRefreshChange:control];
}

/**
 *  下拉加载更多
 */
- (void)setDownLoadMore
{
    XJLoadMoreFooter *footer = [XJLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

- (NSArray *)statusFramesWithStatus:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (XJStatus *status in statuses) {
        XJStatusFrame *f = [[XJStatusFrame alloc]init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

/**
 *  添加文件描述
 */
- (void)click
{
    [self.navigationController pushViewController:[[XJOAuthViewController alloc]init] animated:YES];
}
/**
 * 加载最新数据
 */
- (void)setupRefreshChange:(UIRefreshControl *)control
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    XJOAuthModel *account = [XJOAuthTool account];
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"count"] = @10;
    XJStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    if (firstStatusFrame) {
        params[@"since_id"] = firstStatusFrame.status.idstr;
    }
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSLog(@"最新数据：%@",responseObject);
//        self.statuses = responseObject[@"statuses"];
        NSArray *newStatuses = [XJStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newStatusesFrame = [self statusFramesWithStatus:newStatuses];

//        self.statuses = [XJStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newStatusesFrame atIndexes:set];
        [responseObject writeToFile:Data_Path atomically:YES];
        
        if ([responseObject writeToFile:Data_Path atomically:YES]) {
            NSLog(@"成功写入");
        }else{
            NSLog(@"失败写入");
        }
        // 刷新表格
        [self.tableView reloadData];
        [control endRefreshing];
        
        [self showNewsStatusCount:newStatusesFrame.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        [control endRefreshing];
    }];
    
    
//    [[XJNetWorking sharedInstance]getUrl:@"https://api.weibo.com/2/statuses/friends_timeline.json" actionParams:params method:@"POst" success:^(id responseObj) {
//        NSLog(@"%@",responseObj);
//        [control endRefreshing];
//    } failur:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];

}

- (void)loadMoreStatus
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    XJOAuthModel *account = [XJOAuthTool account];
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;

    XJStatusFrame *lastStatusFrame = [self.statusFrames lastObject];
    if (lastStatusFrame) {
        long long maxId = lastStatusFrame.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *newStatuses = [XJStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newStatusFrame = [self statusFramesWithStatus:newStatuses];
        [self.statusFrames addObjectsFromArray:newStatusFrame];
        [self.tableView reloadData];
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //self.tableView.tableFooterView.hidden = YES;
    }];
    
}

- (void)showNewsStatusCount:(int)count
{
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    if (count == 0) {
        label.text = @"没有新的微博数据，稍后再试";
    }else{
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    label.y = 64 - label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        CGFloat delay = 1.0;
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
}

- (void)setupUserInfo
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    XJOAuthModel *account = [XJOAuthTool account];
    NSMutableDictionary *params  = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        NSLog(@"%@",responseObject);
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        [titleButton setTitle:responseObject[@"name"] forState:UIControlStateNormal];
        
        account.name = responseObject[@"name"];
        [XJOAuthTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
    }];

}

//设置导航控制器标题
- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    XJOAuthModel *account = [XJOAuthTool account];
    XJTitleButton *titleButton = [[XJTitleButton alloc]init];
    [titleButton setTitle:account.name?account.name:@"首页" forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(dropdownClick:) forControlEvents:UIControlEventTouchUpInside];
//    titleButton.selected = YES;
    self.navigationItem.titleView = titleButton;
}

- (void)friendSearch
{
    
}

- (void)pop
{
}

- (void)dropdownClick:(UIButton *)sender
{
    XJDropdownMenu *menu = [XJDropdownMenu menu];
    menu.delegate = self;
    NextViewController *next = [[NextViewController alloc]init];
    next.view.height = 44*3;
    next.view.width = 150;
    menu.containerController = next;
    [menu showFrom:sender];
}
- (void)dropdownMenuDismiss:(XJDropdownMenu *)dropdownMenu
{
    UIButton *bun = (UIButton *)self.navigationItem.titleView;
    bun.selected = YES;
}
- (void)dropdownMenuShow:(XJDropdownMenu *)dropdownMenu
{
    UIButton *bun = (UIButton *)self.navigationItem.titleView;
    bun.selected = NO;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XJStatusCell *cell = [XJStatusCell cellWithTableview:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XJStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if (self.statusFrames.count == 0)return;
//    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
//    if (offsetY >= judgeOffsetY) {
//        self.tableView.tableFooterView.hidden = NO;
//        [self loadMoreStatus];
//    }
    
    
    
    if(self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO)return;
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat judgeoffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
 
    if (offsetY >= judgeoffsetY) {
        self.tableView.tableFooterView.hidden = NO;
        [self loadMoreStatus];
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
