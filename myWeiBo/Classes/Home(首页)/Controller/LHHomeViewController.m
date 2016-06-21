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
#import "UIImageView+WebCache.h"

@interface LHHomeViewController ()

@property (nonatomic, strong) NSMutableArray *statues;

@end

@implementation LHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    
    [self setupUserInfo];

    [self loadStatues];
    

    
}

#pragma mark 加载微博数据
-(void)loadStatues{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //拼接参数
    NSString *url = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    LHAccount *account = [LHAccountTool account];
    params[@"access_token"] = account.access_token;
//        params[@"count"] = @1;
    
    //发送请求
    [manager GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LHLog(@"%@",responseObject);
        
        NSArray *statuesArr = responseObject[@"statuses"];
        
        for (NSDictionary *dict in statuesArr) {
            LHLog(@"%@",dict);
            LHStatus *status = [LHStatus mj_objectWithKeyValues:dict];
            [self.statues addObject:status];
        }
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LHLog(@"%@",error);
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
//    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//    
//    UIView *coverView = [[UIView alloc] init];
//    coverView.frame = self.view.bounds;
//    coverView.backgroundColor = [UIColor clearColor];
//    
//    [window addSubview:coverView];
//    
//    UIImageView *dropDownMenu = [[UIImageView alloc] init];
//    dropDownMenu.image = [UIImage imageNamed:@"popover_background"];
//    dropDownMenu.width = 200;
//    dropDownMenu.height = 200;
//    
//    [window addSubview:dropDownMenu];
}

-(void)friendsearch{

    LHLog(@"friendsearch");
}

-(void)pop{
    LHLog(@"pop");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statues.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"myWeiBo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    LHStatus *status = self.statues[indexPath.row];
    LHUser *user = status.user;
    
    cell.detailTextLabel.text = status.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:nil] ;
    
    return cell;
}

#pragma mark -懒加载
-(NSMutableArray *)statues{
    if (_statues == nil) {
        _statues = [NSMutableArray array];
    }
    return _statues;
}


@end
