//
//  MainViewController.m
//  Douyu
//
//  Created by Shui on 2017/9/10.
//  Copyright © 2017年 Shui. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard * storyboard1 = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
    UINavigationController *homeChild = [storyboard1 instantiateInitialViewController];
    
    UIStoryboard * storyboard2 = [UIStoryboard storyboardWithName:@"Live" bundle:nil];
    UINavigationController *liveChild = [storyboard2 instantiateInitialViewController];
    
    UIStoryboard * storyboard3 = [UIStoryboard storyboardWithName:@"Follow" bundle:nil];
    UINavigationController *followChild = [storyboard3 instantiateInitialViewController];
    
    UIStoryboard * storyboard4 = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    UINavigationController *profileChild = [storyboard4 instantiateInitialViewController];
    
    [self addChildViewController:homeChild];
    [self addChildViewController:liveChild];
    [self addChildViewController:followChild];
    [self addChildViewController:profileChild];
    
//    [[UINavigationBar appearance] setTintColor:[UIColor orangeColor]];
//    self.tabBar.tintColor = [UIColor orangeColor];
    
    for (int i = 0; i < 19; i++) {
        NSLog(@"%d >> 2=%d", i, (i>>2));
    }
    
    for (int i = 0; i < 19; i++) {
        NSLog(@"============%d << 1=%d", i, (i<<1));
    }
    
    [MainViewController transform:@"你好去掉音标？"];
}

+ (NSString *)transform:(NSString *)chinese
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    NSLog(@"%@", pinyin);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    //返回最近结果
    return pinyin;
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
