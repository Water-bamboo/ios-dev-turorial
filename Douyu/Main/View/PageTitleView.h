//
//  PageTitleView.h
//  Douyu
//
//  Created by Shui on 2017/9/10.
//  Copyright © 2017年 Shui. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPageTitleH 40

@protocol PageTitleViewDelegate <NSObject>

- (void) titleSelected:(NSInteger) selectedIndex;

@end

@interface PageTitleView : UIView

@property (nonatomic, weak) id<PageTitleViewDelegate> delegate;

/**
 * If contentpage trigger scroll, will pass event info to PageTitleView;
 */
- (void)syncContentViewProgress:(CGFloat) progress isLeft:(Boolean) isLeft;

- (instancetype) initWithTitle:(NSArray *) labels frame:(CGRect)frame;

@end
