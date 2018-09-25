//
//  AppDelegate.m
//  RoutersOC
//
//  Created by cxz on 2018/9/23.
//  Copyright © 2018年 cxz. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    BOOL isLogin = true;
    
    
    if (isLogin) {
        self.root = [[UINavigationController alloc] initWithRootViewController: [self rootProfile]];
    }
    
    _window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    _window.rootViewController = self.root;
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - setup Root
- (UITabBarController *)rootProfile {
    
    /*
     *
     此处可以返回viewController
     在登录状态条件判断时若未登录，则返回LoginViewController
     在...............若已登录，则返回TabBarViewController
     然后通过 isKindOfClass判断显示页面
     */
    
    //第一个tab的navigationController
    UIViewController *first = [[FirstViewController alloc] init];
    UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
    
    //第二个tab的navigationController
    UIViewController *second = [[SecondViewController alloc] init];
    UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController: second];
    
    //设计tab
    UITabBarController *tab = [[UITabBarController alloc] init];
    tab.viewControllers = @[firstNav, secondNav];
    
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle: @"first" image: nil selectedImage: nil];
    firstNav.tabBarItem = item1;
    
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle: @"second" image: nil selectedImage: nil];
    secondNav.tabBarItem = item2;
    
    return tab;
    
}


@end
