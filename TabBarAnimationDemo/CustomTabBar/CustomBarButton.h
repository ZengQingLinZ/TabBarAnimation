//
//  CustomBarButton.h
//  TabBarAnimationDemo
//
//  Created by ArJun on 2017/7/15.
//  Copyright © 2017年 ArJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBarButton : UIButton

@property (nonatomic, assign) BOOL isShowTitle;

@property (nonatomic, strong) UITabBarItem *item;

- (void)layoutSubviewsAnimation;

@end
