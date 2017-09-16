//
//  PageContentView.h
//  Douyu
//
//  Created by Shui on 2017/9/10.
//  Copyright © 2017年 Shui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageContentViewDelegate <NSObject>

//0: drag right, new index = smaller.
//1: drag left, new index = bigger.
- (void) viewScrolled:(CGFloat) progress scrollDirection:(NSInteger)direction;

@end

@interface PageContentView : UIView

//delegate
@property (nonatomic, strong) id<PageContentViewDelegate> delegate;

//
- (instancetype) initWithChildVC:(CGRect) frame
                         vcArray:(NSArray<UIViewController *>*) vcArray
            parentViewController:(UIViewController *) parentVC;

//after title selected, notify to this func.
- (void) itemSelected:(NSInteger) newIndex;

@end

