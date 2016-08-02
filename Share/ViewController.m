//
//  ViewController.m
//  Share
//
//  Created by 禾家木 on 16/8/2.
//  Copyright © 2016年 hejiamu. All rights reserved.
//

#import "ViewController.h"
#import "NetworkingTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NetworkingTool *tool = [[NetworkingTool alloc] init];
        NSDictionary *parameters = @{
                                     @"service":@"UserInfo.GetInfo",
                                     @"uid":@"1",
    
                                     };
    [NetworkingTool getDataWithParameters:parameters completeBlock:^(BOOL success, id result) {
        if (success) {
            NSLog(@"用户信息--%@",result);
        }else{
            NSLog(@"失败原因--%@",result);
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
