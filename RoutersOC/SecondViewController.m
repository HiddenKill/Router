//
//  SecondViewController.m
//  RoutersOC
//
//  Created by cxz on 2018/9/23.
//  Copyright © 2018年 cxz. All rights reserved.
//

#import "SecondViewController.h"
#import <objc/runtime.h>


@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blueColor];
    
    unsigned int outCount = 0;
    Method *method_f = class_copyMethodList(self.class, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = method_f[i];
    }
}


- (void)method1 {
    
}

- (void)method2 {
    
}

- (void)method3 {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
