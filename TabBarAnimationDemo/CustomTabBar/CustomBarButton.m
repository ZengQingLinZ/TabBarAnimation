//
//  CustomBarButton.m
//  TabBarAnimationDemo
//
//  Created by ArJun on 2017/7/15.
//  Copyright © 2017年 ArJun. All rights reserved.
//

#import "CustomBarButton.h"
#import "UIView+Extension.h"

@interface CustomBarButton ()

@end

@implementation CustomBarButton

- (void)setHighlighted:(BOOL)highlighted {}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        // 图片，文字居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return self;
}

// 传递UITabBarItem给UITabBarButton进行内容赋值，使用KVO
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
}

// 重写来自定义布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageRatio = 0.7;
    
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = CGRectGetWidth(self.frame);
    CGFloat imgH = (self.isSelected || _isShowTitle) ? CGRectGetHeight(self.frame) * imageRatio : CGRectGetHeight(self.frame);
    self.imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat ttlY = CGRectGetHeight(self.frame) * imageRatio;
    CGFloat ttlW = CGRectGetWidth(self.frame);
    CGFloat ttlH = CGRectGetHeight(self.frame) * 0.2;
    
    if (_isShowTitle) {
        self.titleLabel.frame = CGRectMake(0, 0, ttlW, ttlH);
    }
    
    self.titleLabel.center = CGPointMake(ttlW/2.f, ttlY + ttlH/2.f);
    self.titleLabel.alpha = _isShowTitle || self.isSelected;
}

- (void)layoutSubviewsAnimation {
    CGFloat imageRatio = 0.7;
    
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = CGRectGetWidth(self.frame);
    CGFloat imgH = (self.isSelected || _isShowTitle) ? CGRectGetHeight(self.frame) * imageRatio : CGRectGetHeight(self.frame);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
    }];
}

- (void)setSelected:(BOOL)selected
{
    if (_isShowTitle) {
        [self selectedScaleAnimation:selected];
    } else {
        [self selectedTranslationAnimation:selected];
    }
    
    [super setSelected:selected];
}

- (void)selectedScaleAnimation:(BOOL)selected
{
    [UIView animateWithDuration:0.1 animations:^{
        if (selected) {
            self.imageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } else {
            self.imageView.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        if (selected) {
            [UIView animateWithDuration:0.1 animations:^{
                self.imageView.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    self.imageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
                }];
            }];
        }
    }];
}

- (void)selectedTranslationAnimation:(BOOL)selected
{
    // TODO:
}
@end

