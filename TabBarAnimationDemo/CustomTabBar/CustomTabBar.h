//
//  CustomTabBar.h
//  TabBarAnimationDemo
//
//  Created by ArJun on 2017/7/15.
//  Copyright © 2017年 ArJun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CustomTabBarAnimation)
{
    CustomTabBarAnimationStyleScale,
    CustomTabBarAnimationStyleTranslation
};

@class CustomTabBar;

@protocol CustomTabBarDelegate <NSObject>

@optional
- (void)tabBar:(CustomTabBar *)tabBar didSelectedItemFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface CustomTabBar : UIView

/** 子控制器的tabBarItem数组*/
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<CustomTabBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame style:(CustomTabBarAnimation)style;

@end
