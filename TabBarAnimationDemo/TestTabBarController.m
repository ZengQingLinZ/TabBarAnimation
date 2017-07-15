//
//  TestTabBarController.m
//  TabBarAnimationDemo
//
//  Created by ArJun on 2017/7/15.
//  Copyright © 2017年 ArJun. All rights reserved.
//

#import "TestTabBarController.h"
#import "CustomTabBar.h"

@interface TestTabBarController() <CustomTabBarDelegate>

/** 所有子控制器的tabBarItem*/
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation TestTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = [NSMutableArray array];
    
    // 添加子控制器
    [self setUpAllChildViewController];
    
    // 设置tabBar
    [self setUpTabBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if (![tabBarButton isKindOfClass:[CustomTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
}

- (void)setUpAllChildViewController
{
    UIViewController *news = [[UIViewController alloc] init];
    news.view.backgroundColor = [UIColor redColor];
    [self setOneChildViewController:news withImage:[UIImage imageNamed:@"tab_icon_news_normal"] selectedImage:[UIImage imageNamed:@"tab_icon_news_press"] title:@"新闻"];
    
    UIViewController *friends = [[UIViewController alloc] init];
    friends.view.backgroundColor = [UIColor grayColor];
    [self setOneChildViewController:friends withImage:[UIImage imageNamed:@"tab_icon_friend_normal"] selectedImage:[UIImage imageNamed:@"tab_icon_friend_press"] title:@"好友"];
    
    UIViewController *quiz = [[UIViewController alloc] init];
    quiz.view.backgroundColor = [UIColor purpleColor];
    [self setOneChildViewController:quiz withImage:[UIImage imageNamed:@"tab_icon_quiz_normal"] selectedImage:[UIImage imageNamed:@"tab_icon_quiz_press"] title:@"发现"];
    
    UIViewController *more = [[UIViewController alloc] init];
    more.view.backgroundColor = [UIColor grayColor];
    [self setOneChildViewController:more withImage:[UIImage imageNamed:@"tab_icon_more_normal"] selectedImage:[UIImage imageNamed:@"tab_icon_more_press"] title:@"我"];
}

- (void)setOneChildViewController:(UIViewController *)viewController withImage:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    viewController.title = title;
    
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = image;
    viewController.tabBarItem.selectedImage = selectedImage;
    
    [self.items addObject:viewController.tabBarItem];
    
    UINavigationController *nvg = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self addChildViewController:nvg];
    
}

- (void)setUpTabBar
{
    CustomTabBar *tabBar = [[CustomTabBar alloc] initWithFrame:self.tabBar.bounds style:CustomTabBarAnimationStyleTranslation];
    
    tabBar.delegate = self;
    
    tabBar.items = self.items;
    
    [self.tabBar addSubview:tabBar];
}
- (void)tabBar:(CustomTabBar *)tabBar didSelectedItemFrom:(NSInteger)from to:(NSInteger)to
{
    self.selectedIndex = to;
}

@end
