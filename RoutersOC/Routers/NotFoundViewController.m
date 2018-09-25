//
//  NotFoundViewController.m
//  RoutersOC
//
//  Created by cxz on 2018/9/23.
//  Copyright © 2018年 cxz. All rights reserved.
//

#import "NotFoundViewController.h"

@interface NotFoundViewController ()

@end

@implementation NotFoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];

    UILabel *tip = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    tip.center = self.view.center;
    tip.text = @"404 not found";
    [self.view addSubview: tip];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
