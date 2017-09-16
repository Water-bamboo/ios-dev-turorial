//
//  HomeViewController.m
//  Douyu
//
//  Created by Shui on 2017/9/10.
//  Copyright © 2017年 Shui. All rights reserved.
//

#import "HomeViewController.h"
#import "ConstValues.h"
#import "PageTitleView.h"
#import "PageContentView.h"

@interface HomeViewController () <PageTitleViewDelegate, PageContentViewDelegate>

@property (nonatomic, strong) PageTitleView * pageTitleView;
@property (nonatomic, strong) PageContentView *pageContentView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
}

- (void) setupUI
{
    //1. setNavigationBar title
    UIBarButtonItem *uiLeftBtn = [self genNavigationBarItem:@"logo" hl:nil size:CGRectZero];

    CGRect rect = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *scanBtn1 = [self genNavigationBarItem:@"scanIcon" hl:@"scanIconHL" size:rect];
    UIBarButtonItem *searchBtn2 = [self genNavigationBarItem:@"search_btn" hl:@"search_btnHL" size:rect];
    UIBarButtonItem *historyBtn3 = [self genNavigationBarItem:@"viewHistoryIcon" hl:@"viewHistoryIconHL" size:rect];
    self.navigationItem.leftBarButtonItem = uiLeftBtn;

    //2.  setNav right icons
    self.navigationItem.rightBarButtonItems = @[scanBtn1, searchBtn2, historyBtn3];

    //3.setPageTitle
    _pageTitleView = [[PageTitleView alloc] initWithTitle:@[@"推荐", @"游戏", @"去玩", @"娱乐"] frame:CGRectMake(0, kStatusBarH + kNavigationBarH, kScreenW, kPageTitleH)];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.delegate = self;

    //4. page Content
    NSMutableArray<UIViewController *> *childVCS = [[NSMutableArray alloc] init];
    NSArray *colors = @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor purpleColor]];
    for (int i = 0; i < 4; i++) {
        UIViewController *vc = [[UIViewController alloc] init];

//        int R = (arc4random_uniform(255)) ;
//        int G = (arc4random_uniform(255)) ;
//        int B = (arc4random_uniform(255)) ;
        vc.view.backgroundColor = colors[i];//[UIColor colorWithRed:R/255 green:G/255 blue:B/255 alpha:1];

        [childVCS addObject:vc];
    }

    _pageContentView = [[PageContentView alloc] initWithChildVC:CGRectMake(0, kStatusBarH + kNavigationBarH + kPageTitleH, self.view.bounds.size.width/* * childVCS.count*/, self.view.bounds.size.height-(kStatusBarH + kNavigationBarH + kPageTitleH)) vcArray:childVCS parentViewController:self];
    //5.
    _pageContentView.delegate = self;
    
    
    [self.view addSubview:_pageContentView];
}

#pragma mark - PageTitleViewDelegate
- (void) titleSelected:(NSInteger)selectedIndex
{
//    NSLog(@"titleSelected::%d", selectedIndex);
    [_pageContentView itemSelected:selectedIndex];
}

- (UIBarButtonItem* ) genNavigationBarItem:(NSString *)imageName hl:(NSString *) highlight size: (CGRect) size
{
    UIButton *uiLeftImage = [[UIButton alloc] initWithFrame:size];
    [uiLeftImage setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (highlight) {
        [uiLeftImage setImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    }
    
    if (CGRectEqualToRect(size, CGRectZero)) {
        [uiLeftImage sizeToFit];
    }
    
    UIBarButtonItem *uiLeftBtn = [[UIBarButtonItem alloc] initWithCustomView:uiLeftImage];
    return uiLeftBtn;
}

#pragma Mark PageContentViewDelegate::viewScrolled
- (void)viewScrolled:(CGFloat)progress scrollDirection:(NSInteger)direction
{
    NSLog(@"progress=%f, direction=%ld", progress, (long)direction);
    [_pageTitleView syncContentViewProgress:progress isLeft:(direction == 0)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
