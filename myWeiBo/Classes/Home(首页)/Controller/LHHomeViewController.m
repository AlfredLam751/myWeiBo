//
//  LHHomeViewController.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/3/18.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHHomeViewController.h"
#import "LHHomeButton.h"
#import "LHAccountTool.h"
#import "LHUser.h"
#import "LHStatus.h"
#import "LHStatusFrame.h"
#import "LHLoadMoreView.h"
#import "LHStatuesCell.h"



@interface LHHomeViewController ()

@property (nonatomic, strong) NSMutableArray *statuesFrames;

@end

@implementation LHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    
    [self setupUserInfo];
    
    //下拉刷新
    [self refreshDown];
    //上拉加载
    [self refreshUp];
    
    //加载未读未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(loadUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

#pragma mark --下拉刷新
-(void)refreshDown{
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    
    [control addTarget:self action:@selector(refreshWith:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:control];
    [control beginRefreshing];
    [self refreshWith:control];
}

#pragma mark --上拉加载
-(void)refreshUp{
    LHLoadMoreView *moreView = [LHLoadMoreView loadMore];
    moreView.hidden = YES;
    self.tableView.tableFooterView = moreView;
}

-(void)refreshWith:(UIRefreshControl *)control{
    // 刷新成功(清空图标数字)
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline.json";

    LHAccount *account = [LHAccountTool account];
    LHStatusFrame *statusF = [self.statuesFrames firstObject];

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    if (statusF) {
        params[@"since_id"] = statusF.status.idstr;
    }
    
    [manager GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *newStatues = [LHStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSMutableArray *newStatusFrames = [NSMutableArray array];
        for (LHStatus *status in newStatues) {
            LHStatusFrame *statusFrame = [[LHStatusFrame alloc] init];
            statusFrame.status = status;
            [newStatusFrames addObject:statusFrame];
        }
        
        
        //新插入的数组的长度
        NSInteger integer = newStatusFrames.count;
        //插入的范围
        NSRange rang = NSMakeRange(0, integer);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:rang];
        //旧数组实现这方法即可插入
        [self.statuesFrames insertObjects:newStatusFrames atIndexes:set];
        
        [control endRefreshing];
        [self.tableView reloadData];
        
        [self setupRefreshLabel:integer];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LHLog(@"%@",error);
    }];
}

#pragma mark 刷新label
-(void)setupRefreshLabel:(NSInteger)count{
    UILabel *label = [[UILabel alloc] init];
    CGFloat height = 44;
    label.frame = CGRectMake(0, 64- 44, self.view.width, height);
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    if (count) {
        label.text = [NSString stringWithFormat:@"更新了%ld条微博",count];
    }else{
        label.text = @"没有微博更新";
    }
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, height);
        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}



#pragma mark 加载更多微博
-(void)loadMoreStatues{
    // 1.请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.拼接请求参数
    LHAccount *account = [LHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    LHStatusFrame *lastStatusF = [self.statuesFrames lastObject];
    if (lastStatusF) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [LHStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSMutableArray *newStatusFrames = [NSMutableArray array];
        for (LHStatus *status in newStatuses) {
            LHStatusFrame *statusFrame = [[LHStatusFrame alloc] init];
            statusFrame.status = status;
            [newStatusFrames addObject:statusFrame];
        }
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statuesFrames addObjectsFromArray:newStatusFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LHLog(@"请求失败-%@", error);
        
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}

#pragma mark 加载未读微博数
-(void)loadUnreadCount{
    // 1.请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    LHLog(@"=============");
    // 2.拼接请求参数
    LHAccount *account = [LHAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSString *status = [responseObject[@"status"] description];


        if (IS_IOS8) {

            UIUserNotificationSettings *mySetting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:mySetting];
        }
        
        if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
            self.tabBarItem.badgeValue = nil;

            
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else { // 非0情况
            
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LHLog(@"请求失败-%@", error);
    }];
}

#pragma mark 加载用户数据
-(void)setupUserInfo{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LHAccount *account = [LHAccountTool account];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [manager GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典转模型
        LHUser *user = [LHUser mj_objectWithKeyValues:responseObject];
        account.name = user.name;
        [LHAccountTool saveAccotunWith:account];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LHLog(@"%@",error);
    }];
}

#pragma mark 设置导航栏
-(void)setupNavigation{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem addItemWithTarget:self with:@selector(friendsearch) withNormalImage:@"navigationbar_friendsearch" withHeightlightImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem addItemWithTarget:self with:@selector(pop) withNormalImage:@"navigationbar_pop" withHeightlightImage:@"navigationbar_pop_highlighted"];
    
    LHHomeButton *titleBtn = [LHHomeButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitleColor:LHRandomColor forState:UIControlStateNormal];
    
    
    LHAccount *account = [LHAccountTool account];
    NSString *nameStr = account.name;
    [titleBtn setTitle:nameStr?nameStr:@"首页"  forState:UIControlStateNormal];

    
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    titleBtn.width = 150;
    titleBtn.height = 30;
    
    self.navigationItem.titleView = titleBtn;
    
    [titleBtn addTarget:self action:@selector(titleBtnClick) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark title按钮点击
-(void)titleBtnClick{

}

-(void)friendsearch{

    LHLog(@"friendsearch");
}

-(void)pop{
    LHLog(@"pop");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuesFrames.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    LHStatuesCell *cell = [LHStatuesCell cellWithTableView:tableView];
    cell.statusFrame = self.statuesFrames[indexPath.row];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LHStatusFrame *statusF = self.statuesFrames[indexPath.row];
    return statusF.cellHeight;
}

#pragma mark -懒加载
-(NSMutableArray *)statuesFrames{
    if (_statuesFrames == nil) {
        _statuesFrames = [NSMutableArray array];
    }
    return _statuesFrames;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.statuesFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) {
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatues];
    }

    
}




@end
