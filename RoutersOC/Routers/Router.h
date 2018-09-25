//
//  Router.h
//  RoutersOC
//
//  Created by cxz on 2018/9/23.
//  Copyright © 2018年 cxz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Router : NSObject

+ (NSError *)router2:(NSURL *)uri params:(NSDictionary *)params;

@end
