//
//  AppDelegate.m
//  GKNavigationBarExample
//
//  Created by QuintGao on 2019/11/2.
//  Copyright © 2019 QuintGao. All rights reserved.
//

#import "AppDelegate.h"
#import "GKMainViewController.h"
#import "GKWYMusicViewController.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "UIView+Extension.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [IQKeyboardManager sharedManager].enable = YES;
    
//    NSLog(@"%@", NSStringFromUIEdgeInsets([GKConfigure gk_safeAreaInsets]));
    // 配置导航栏属性
    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure * _Nonnull configure) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GK_SCREEN_WIDTH, GK_STATUSBAR_NAVBAR_HEIGHT)];
        configure.backgroundImage = [view imageWithColors:@[(__bridge id)[UIColor colorWithRed:127/255.0 green:23/255.0 blue:135/255.0 alpha:1.0].CGColor, (__bridge id)[UIColor colorWithRed:37/255.0 green:26/255.0 blue:188/255.0 alpha:1.0].CGColor]];
        configure.darkBackgroundImage = [UIImage gk_imageWithColor:UIColor.lightGrayColor];
        // 导航栏背景色
        configure.backgroundColor = [UIColor whiteColor];
        // 导航栏标题颜色
        configure.titleColor = [UIColor blackColor];
        // 导航栏标题字体
        configure.titleFont = [UIFont systemFontOfSize:18.0f];
        // 导航栏返回按钮样式
        configure.backStyle = GKNavigationBarBackStyleBlack;
        // 导航栏左右item间距
//        configure.gk_disableFixSpace = YES;
        configure.gk_navItemLeftSpace = 0.0f;
        configure.gk_navItemRightSpace = 10.0f;
        configure.gk_restoreSystemNavBar = YES;
    }];
    
    [GKGestureConfigure setupCustomConfigure:^(GKGestureHandleConfigure * _Nonnull configure) {
        configure.gk_translationX = 15;
        configure.gk_translationY = 20;
        configure.gk_scaleX = 0.90;
        configure.gk_scaleY = 0.92;
        configure.gk_openScrollViewGestureHandle = YES;
    }];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *nav = [UINavigationController rootVC:[GKMainViewController new]];
    nav.gk_openScrollLeftPush = YES;
    nav.gk_openSystemNavHandle = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
//    [UIView appearance].semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
//    [UISearchBar appearance].semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
//    [[UINavigationBar appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    
    return YES;
}

@end
