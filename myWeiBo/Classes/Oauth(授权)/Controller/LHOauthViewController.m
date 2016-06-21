//
//  LHOauthViewController.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/6/21.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHOauthViewController.h"

@interface LHOauthViewController ()<UIWebViewDelegate>

@end

@implementation LHOauthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupWebView];

    
}

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
    // Dispose of any resources that can be recreated.
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}



@end
