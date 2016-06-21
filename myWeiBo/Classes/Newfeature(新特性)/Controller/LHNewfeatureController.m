//
//  LHNewfeatureController.m
//  myWeiBo
//
//  Created by Alfred Lam on 16/4/8.
//  Copyright © 2016年 alfred.cn. All rights reserved.
//

#import "LHNewfeatureController.h"
#define NewfeatureCount 4

@interface LHNewfeatureController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation LHNewfeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    
    CGFloat scrollViewW = scrollView.size.width;
    CGFloat scrollViewH = scrollView.size.height;
    
    for (int i = 0; i < NewfeatureCount; ++i) {
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        
        imageView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        
        [scrollView addSubview:imageView];
        
            UIButton *btn = [[UIButton alloc] init];
            btn.width = 100;
            btn.height = 50;
            btn.y = scrollViewH - 200;
            btn.x = scrollViewW/2 - 50 + (NewfeatureCount - 1) *scrollViewW;
            [btn setBackgroundColor:LHRandomColor];
            [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollView addSubview:btn];
        
    }
    
    scrollView.contentSize = CGSizeMake(NewfeatureCount * scrollViewW, 0);
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    
    scrollView.delegate = self;

    
    [self.view addSubview:scrollView];
    
    UIPageControl *page = [[UIPageControl alloc] init];
    page.numberOfPages = NewfeatureCount;
    page.width = 100;
    page.currentPageIndicatorTintColor = LHRandomColor;
    page.pageIndicatorTintColor = LHRandomColor;
    page.height = 50;
    page.y = scrollViewH - 150;
    page.x = scrollViewW/2 - 50;
    self.pageControl = page;
    
//    page.backgroundColor = [UIColor redColor];
    [self.view addSubview:page];
    // Do any additional setup after loading the view.
}

-(void)clickBtn{
    LHLog(@"点击了我");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (scrollView.contentOffset.x + scrollView.width/2)/scrollView.width;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
