//
//  CustomTabBar.m
//  TabBarAnimationDemo
//
//  Created by ArJun on 2017/7/15.
//  Copyright © 2017年 ArJun. All rights reserved.
//

#import "CustomTabBar.h"
#import "CustomBarButton.h"

@interface CustomTabBar ()

/** tabBar点击动画风格*/
@property (nonatomic, assign) CustomTabBarAnimation style;

/** buttonItems，有多少控制器就有多少*/
@property (nonatomic, strong) NSMutableArray *buttons;

/** 当前选中的buttonItem*/
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation CustomTabBar

- (instancetype)initWithFrame:(CGRect)frame style:(CustomTabBarAnimation)style
{
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
    }
    return self;
}

#pragma mark - setter&getter
- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

// 设置tabBar对应的Item模型
- (void)setItems:(NSArray *)items
{
    _items = items;
    
    // 根据items的数量创建button
    for (UITabBarItem *item in items) {
        CustomBarButton *button = [CustomBarButton buttonWithType:UIButtonTypeCustom];
        
        if (_style == CustomTabBarAnimationStyleScale) {
            button.isShowTitle = YES;
        }
        
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
        
        button.item = item;
        
        button.tag = self.buttons.count;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (button.tag == 0) {
            [self buttonClick:button];
        }
        
        [self addSubview:button];
        
        [self.buttons addObject:button];
    }
    
    [self layoutSubviewsAnimated:NO];
}

- (void)buttonClick:(UIButton *)button
{
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectedItemFrom:to:)]) {
        [_delegate tabBar:self didSelectedItemFrom:self.selectedButton.tag to:button.tag];
    }
    
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    [self layoutSubviewsAnimated:YES];
}

// 执行布局动画
- (void)layoutSubviewsAnimated:(BOOL)animated
{
    // 计算每个tabBarButton的frame
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnW = w / self.buttons.count;
    
    CustomBarButton *lastView = nil;
    for (CustomBarButton *subView in self.buttons) {
        
        btnX = CGRectGetMaxX(lastView.frame);
        btnX = CGRectGetMaxX(lastView.frame);
        
        if (animated) {
            subView.frame = CGRectMake(btnX, 0, btnW, h);
            [subView layoutSubviewsAnimation];
        } else {
            subView.frame = CGRectMake(btnX, 0, btnW, h);
        }
        
        lastView = subView;
    }
    
}


@end
