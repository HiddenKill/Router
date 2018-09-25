//
//  Router.m
//  RoutersOC
//
//  Created by cxz on 2018/9/23.
//  Copyright © 2018年 cxz. All rights reserved.
//

#import "Router.h"
#import <objc/message.h>
#import "AppDelegate.h"
#import "NotFoundViewController.h"


#define ROUTER_URI_ERROR -1000

@implementation Router


//      profile://root@ViewController?key=value
+ (NSError *)router2:(NSURL *)uri params:(NSDictionary *)params {
    NSError *error = nil;
    if (uri.absoluteString.length == 0) {
        error = [NSError errorWithDomain: @"router uri error" code: ROUTER_URI_ERROR userInfo: nil];
        return error;
    }
    
    NSMutableDictionary *passParams = [NSMutableDictionary dictionaryWithCapacity: 0];
    if (params) {
        [passParams addEntriesFromDictionary: params];
    }
    
    /**
     * profile://(alert:// or do://)root(cur代表当前显示的profile)@className/initMethod,?p=v&p=v#code(xib/sb)
     */
    
    
    NSString *scheme = [uri scheme];
    
    if ([scheme isEqualToString: @"profile"]) {
        
        
        
        
        
    } else if ([scheme isEqualToString: @"alert"]) {
        
    } else {
        
    }
    
    
    
    
    
    
    
    return nil;
}


+ (NSString *)fetchInitializationMethod4Class:(Class)cls {
    if (!cls) {
        return nil;
    }
    //用于存储当前cls的所有method
    NSMutableArray <NSString *> *allMethods = [NSMutableArray arrayWithCapacity: 0];
    
    unsigned int methodCount = 0;
    //获取cls方法列表
    Method *methodList_f = class_copyMethodList(cls, &methodCount);
    //遍历所有cls中的方法  Method -> method_name_string
    for (int i = 0; i < methodCount; i++) {
        Method cur_method = methodList_f[i];
        const char *method_name = sel_getName(method_getName(cur_method));
        NSString *sel_name = [NSString stringWithUTF8String: method_name];
        [allMethods addObject: sel_name];
    }
    //释放methodList_f指针
    free(methodList_f);
    
    //获取当前的method_name_string
    NSString *initMethod = nil;
    for (NSString *method_name in allMethods) {
        if ([method_name hasPrefix: @"__initWith"]) {
            initMethod = method_name;
            break;
        }
    }
    return initMethod;
}

#pragma mark - util method
+ (UIViewController *)fetchCurrentViewController {
    UIViewController *vc = [self app].window.rootViewController;
    while (true) {
        if ([vc isKindOfClass: [UINavigationController class]]) {
            //单navi页面
            vc = ((UINavigationController *)vc).visibleViewController;
        } else if([vc isKindOfClass: [UITabBarController class]]) {
            //tab页面
            vc = ((UITabBarController *)vc).selectedViewController;
        } else if(vc.presentedViewController) {
            //present页面
            vc = vc.presentedViewController;
        } else {
            break;
        }
    }
    NSLog(@"fetch currentViewController === %@", NSStringFromClass([vc class]));
    return vc;
}

+ (AppDelegate *)app {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (UIViewController *)notFoundViewController {
    return [[NotFoundViewController alloc] init];
}

@end
