//
//  LoginViewController.m
//  Share
//
//  Created by 禾家木 on 16/8/3.
//  Copyright © 2016年 hejiamu. All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry/Masonry.h"
#import "UIButton+BackgroundColor.h"
#import "YZForgetViewController.h"
#import "UIControl+ActionBlocks.h"
#import "YZRegisterViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    //
    [self setupViews];

}
- (void)setupViews {
    UITextField *phonetext = [[UITextField alloc ] init];
    [self.view addSubview:phonetext];

    UITextField *password = [[UITextField alloc] init];
    [self.view addSubview:password];

    phonetext.placeholder = @"请输入邮箱或者手机号";
    password.placeholder = @"请输入密码";

    password.secureTextEntry = YES;

    UIImageView *phoneLeftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户图标"]];
    UIImageView *passwordLeftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"密码图标"]];
    UIView *phoneLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 64)];
    UIView *passwordLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 64)];

    [passwordLeft addSubview:passwordLeftImage];
    [phoneLeft addSubview:phoneLeftImage];
//    [password addSubview:passwordLeft];
    phonetext.leftView = phoneLeft;
    password.leftView = passwordLeft;
    [phoneLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@30);
        make.height.equalTo(@40);
    }];
    [passwordLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@30);
        make.height.equalTo(@40);

    }];
    phonetext.leftViewMode =   UITextFieldViewModeAlways;
    password.leftViewMode  =   UITextFieldViewModeAlways;

    //布局
    //手写,添加的约束必须能够唯一确定这个视图的位置和大小
    [phonetext mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@0);
//        make.right.equalTo(@0);
        make.right.left.equalTo(@0);
        make.top.equalTo(@120);
        make.height.equalTo(@64);
        //因为Masonry充分考虑到 我们写约束越简单越好 所以引入了链式写法
    }];
    [password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(@0);
        make.height.equalTo(@64);
        make.top.equalTo(phonetext.mas_bottom);
    }];
    //
    phonetext.font = [UIFont systemFontOfSize:15 weight:-0.15];
    password.font = [UIFont systemFontOfSize:15 weight:-0.15];

    phonetext.layer.borderColor = [UIColor grayColor].CGColor;
    phonetext.layer.borderWidth = 0.5;
    password.layer.borderColor = [UIColor grayColor].CGColor;
    password.layer.borderWidth = 0.5;
    //自定义button 一定要用这个工厂方法

    UIButton *forgetPass = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPass setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPass setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [forgetPass titleLabel].font = [UIFont systemFontOfSize:14];
    //80 64
    //自动布局 auotLayout ，就不能再以某个视图的frame当做
    [forgetPass setFrame:CGRectMake(self.view.frame.size.width - 80, 250, 80, 64)];
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton titleLabel].font = [UIFont systemFontOfSize:14];
    [loginButton setFrame:CGRectMake(0, 320, self.view.frame.size.width, 64)];
    [self.view addSubview:loginButton];
    [self.view addSubview:forgetPass];
    //button 背景颜色设置
    //1.不同状态不同颜色需要做很多图片 比较麻烦 图片太多占用空间 2.不同状态时间下 设置按钮的北背景颜色 我们需要时间很多方法 麻烦3.使用封装好的分类方法 简单方便
//    loginButton
    [loginButton setBackgroundColor:[UIColor greenColor] forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:24 weight:0.15];
//    [forgetPass setBackgroundColor:[UIColor greenColor] forState:UIControlStateNormal];
//    [forgetPass setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    loginButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [forgetPass addTarget:self action:@selector(gotoForget) forControlEvents:UIControlEventTouchUpInside];
    //我们还可以将按钮的事件与按钮写到一块 便于我们在写界面的时候 方便加入控制事件
    [forgetPass handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        YZForgetViewController *VC = [[YZForgetViewController alloc] init];

        [self.navigationController pushViewController:VC animated:YES];
    }];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(gotoRegister)];
}
-(void)gotoRegister {
    YZRegisterViewController *VC = [[YZRegisterViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
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
