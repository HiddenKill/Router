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
     scheme://user@host/path?parameterString#fragment
     scheme: 判断页面跳转||alert弹出
     user: 判定跳转时cur控制器跳转还是root控制器跳转
     host: 跳转页面名称
     path: __initWith
     parameterString: 传参
     fragment: 页面生成方式 code/sb/xib
     //详见appleDeveloper官方文档
     https://developer.apple.com/documentation/foundation/nsurl?language=objc
     */
    
    
    NSString *scheme = [uri scheme];
    NSString *createType = [uri fragment];
    NSString *clsString = [uri host];
    
    if ([scheme isEqualToString: @"profile"]) {
        //页面跳转
        if ([createType isEqualToString: @"code"]) {
            //代码生成方式
            
            //从uri中提取query拼接
            NSDictionary *queryParams = [self getQueryParamsFromUrl: uri];
            //判断如果uri中如果已经存在传参，则拼接
            if (queryParams.allKeys.count > 0) {
                [passParams addEntriesFromDictionary: queryParams];
            }
            
            //判断在uri中是否包含^(__initWith).*$方法
            //若有，则直接调用方法生成cls
            //若无，则使用runtime查找cls中所有方法，__initWith生成cls，反之error
            NSString *initMethod = [uri path];
            NSString *regString = @"^(__initWith).*$";
            NSPredicate *predicate = [NSPredicate predicateWithFormat: @"SELF MATCH %@", regString];
            
            if (![predicate evaluateWithObject: initMethod]) {
                //若uri中path未包含init方法，则查找
                if (passParams.count == 0) {
                    //若未传参，则直接调用init方法生成
                    initMethod = @"init";
                } else {
                    Class cls = NSClassFromString(clsString);
                    if (cls) {
                        
                        
                        
                    } else {
                        error = [NSError errorWithDomain: @"route host or path error" code: ROUTER_URI_ERROR userInfo: nil];
                    }
                    
                }
                
                
            }
            
            
            
            
        } else if ([createType isEqualToString: @"xib"]) {
            
        } else {
            // createType == sb
        }
        
     
        
        
        
        
        
        
    } else if ([scheme isEqualToString: @"alert"]) {
        //alert 弹出
        
    } else {
        // else
        
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

+ (NSDictionary *)getQueryParamsFromUrl:(NSURL *)url {
    NSString *query = [url query];
    NSArray *querys = [query componentsSeparatedByString: @"&"];
    NSMutableDictionary *queryParams = [NSMutableDictionary dictionaryWithCapacity: 0];
    for (NSString *query in querys) {
        NSString *key = [query componentsSeparatedByString: @"="].firstObject;
        NSString *value = [query componentsSeparatedByString: @"="].lastObject;
        [queryParams setObject: value forKey: key];
    }
    return queryParams;
}

@end
