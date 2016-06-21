//
//  LHOauthViewController.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHOauthViewController.h"
#import "LHAccountTool.h"
#import "LHTabBarController.h"
#import "UIWindow+LHWindow.h"


@interface LHOauthViewController ()<UIWebViewDelegate>

@end

@implementation LHOauthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //加载webView
    [self setupWebView];

    
}

#pragma mark -加载webview
-(void)setupWebView{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.frame;
    
    NSString *urlStr = @"https://api.weibo.com/oauth2/authorize?client_id=3660708147&redirect_uri=https://www.baidu.com";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.delegate = self;
    
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -拦截webview
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //获取url
    NSString *urlStr =  request.URL.absoluteString;



    NSRange range = [urlStr rangeOfString: @"code="];
    if (range.length != 0) {
        NSInteger integer = range.location + range.length;
        NSString *codeStr = [urlStr substringFromIndex:integer];
        LHLog(@"%@",codeStr);
        
        //根据codestr获取accesstkoen
        [self accessTokenWith:codeStr];
        return NO;
        
    }
    return YES;
}

//根据codestr获取accesstkoen
-(void)accessTokenWith:(NSString *)str{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.拼接参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"3660708147";
    params[@"client_secret"] = @"8733144f0534fb53b892a9e8c03f6e61";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = str;
    params[@"redirect_uri"] = @"https://www.baidu.com";
    
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LHLog(@"%@",responseObject);
        
        LHAccount *account = [LHAccount accountWith:responseObject];
        [LHAccountTool saveAccotunWith:account];
        
        //切换控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LHLog(@"%@",error);
    }];

}


@end
