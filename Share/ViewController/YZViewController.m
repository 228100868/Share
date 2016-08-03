//
//  YZViewController.m
//  Share
//
//  Created by 禾家木 on 16/8/3.
//  Copyright © 2016年 hejiamu. All rights reserved.
//

#import "YZViewController.h"
#import "MainViewController.h"
#import "YZUserModel.h"
#import "LoginViewController.h"
@interface YZViewController ()

@end

@implementation YZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //将所有控制器按照mvc的思想配置好 并封装起来
    [self setupViewControllers];
}
-(void)viewDidAppear:(BOOL)animated
{   //生命周期中调用父类方法
    [super viewDidAppear:animated];
    //当用户没有登录的时候 需要弹出的登录界面
    if(![YZUserModel isLogin]){
        [self showLoginViewController];
    }
}
- (void)setupViewControllers {
    //如何使用mvc的思想
    NSArray *controllerInfos = @[
                                 //数组里每一个条目，都是一个字典，里面配置了所有控制器显示的效果和类型
                                 @{
                                     @"class":[MainViewController class],
                                     @"title":@"首页",
                                     @"icon":@"tabbar3",
                                     },
                                 @{
                                     @"class":[UIViewController class],
                                     @"title":@"首页",
                                     @"icon":@"tabbar3",
                                     }


                                 ];
    //控制器数组
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:controllerInfos.count];
    //数组的枚举遍历方法
    [controllerInfos enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //直接拿block传过来的字典 取出其中的控制器类型 然后创建一个控制器

        UIViewController *viewController = [[[obj objectForKey:@"class"] alloc ]init];
        viewController.title = [obj objectForKey:@"title"];
        //在创建一个导航控制器 装入刚才创建的控制器
        UINavigationController *naviVC = [[UINavigationController alloc]initWithRootViewController:viewController];
        [viewControllers addObject:naviVC];

    }];
    //配置控制器数组
    self.viewControllers = viewControllers;

}
- (void)showLoginViewController {
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    UINavigationController *naviVC = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    [self presentViewController:naviVC animated:YES completion:^{

    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
