//
//  PageTitleView.m
//  Douyu
//
//  Created by Shui on 2017/9/10.
//  Copyright © 2017年 Shui. All rights reserved.
//

#import "PageTitleView.h"
#import "ConstValues.h"



@interface PageTitleView()

@property (nonatomic, strong) NSArray<NSString *> *labelNames;
@property (nonatomic, strong) NSMutableArray<UILabel *> *labelArray;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UIView *scrollLine;

@property (nonatomic, assign) BOOL isSelfClick;

@end


@implementation PageTitleView

- (instancetype) initWithTitle:(NSArray *) labels frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _labelNames = labels;
        _labelArray = [[NSMutableArray alloc] initWithCapacity:labels.count];
        
        [self setupUI];
    }
    
    return self;
}

- (void) setupUI
{
    if (_labelNames.count < 1) return;
    
    int label_width = kScreenW/_labelNames.count;
    
    //0.bottomLine;
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, kPageTitleH-0.5, kScreenW, 0.5)];
    bottomLine.backgroundColor = [UIColor grayColor];
    [self addSubview:bottomLine];
    
    //1.scrollLine;
    _scrollLine = [[UIView alloc] initWithFrame:CGRectMake(0, kPageTitleH-2, label_width, 2)];
    _scrollLine.backgroundColor = [UIColor orangeColor];
    [self addSubview:_scrollLine];
    
    //2. label
    int index = 0;
    for (NSString *labelName in _labelNames) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(index * label_width, 0, label_width, kPageTitleH)];
        label.text = labelName;
        label.userInteractionEnabled = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = index;
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClicked:)];
        
        [label addGestureRecognizer: tapGes];

        _labelArray[index] = label;
        [self addSubview:label];
        index++;
    }

    //3.
    _currentIndex = 0;
    _labelArray[_currentIndex].textColor = [UIColor orangeColor];
}

- (BOOL) isSelfClick
{
    if (!_isSelfClick) {
        _isSelfClick = false;
    }
    return _isSelfClick;
}

- (void) labelClicked:(UITapGestureRecognizer *) sender
{
    //1.old
    UILabel * oldLabel = _labelArray[_currentIndex];
    oldLabel.textColor = [UIColor grayColor];
    
    //2.new
    _currentIndex = sender.view.tag;
    UILabel * label = (UILabel*)sender.view;
    label.textColor = [UIColor orangeColor];
    
    //scroll
    [UIView animateWithDuration:0.25 animations:^{
        int label_width = kScreenW/_labelNames.count;;
        NSInteger newX = label_width * _currentIndex;
        _scrollLine.frame = CGRectMake(newX, _scrollLine.frame.origin.y, _scrollLine.frame.size.width, _scrollLine.frame.size.height);
    }];

    //delegate
    if ([self.delegate respondsToSelector:@selector(titleSelected:)]) {
        [self.delegate titleSelected:_currentIndex];
    }
    
    _isSelfClick = true;
}

- (void)syncContentViewProgress:(CGFloat)progress isLeft:(Boolean)isLeft
{
    if (_isSelfClick) {
        _isSelfClick = false;
        return;
    }
//    if (isLeft) {
        _scrollLine.frame = CGRectMake(_scrollLine.frame.origin.x + progress * _scrollLine.frame.size.width,
                                       _scrollLine.frame.origin.y,
                                       _scrollLine.frame.size.width,
                                       _scrollLine.frame.size.height);
//    }
//    else
//    {
//        _scrollLine.frame = CGRectMake(_scrollLine.frame.origin.x + progress * _scrollLine.frame.size.width,
//                                       _scrollLine.frame.origin.y,
//                                       _scrollLine.frame.size.width,
//                                       _scrollLine.frame.size.height);
//    }
}

@end
