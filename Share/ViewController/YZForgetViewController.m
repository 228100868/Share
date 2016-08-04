//
//  YZForgetViewController.m
//  Share
//
//  Created by 禾家木 on 16/8/3.
//  Copyright © 2016年 hejiamu. All rights reserved.
//

#import "YZForgetViewController.h"
#import <Masonry.h>
#import "UIButton+BackgroundColor.h"
#import "UIControl+ActionBlocks.h"
#import "SMS_SDK/SMSSDK.h"

@interface YZForgetViewController ()

@end

@implementation YZForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"重置密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}

- (void)setupViews {
    UITextField *phoneText = [[UITextField alloc] init];
    phoneText.placeholder = @"输入邮箱或者手机密码";
    phoneText.font = [UIFont systemFontOfSize:15 weight:-0.15];
    [self.view addSubview:phoneText];
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@120);
        make.height.equalTo(@64);
    }];

    UIView *phoneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 48, 48)];
    UIImageView *phoneLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"手机邮箱图标"]];
    [phoneView addSubview:phoneLeftImage];
    [phoneLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    phoneText.leftView = phoneView;
    phoneText.leftViewMode = UITextFieldViewModeAlways;
    phoneText.layer.borderColor = [UIColor grayColor].CGColor;
    phoneText.layer.borderWidth = 0.5;



    UITextField *passWord = [[UITextField alloc] init];
    passWord.placeholder = @"输入验证码";
    passWord.font = [UIFont systemFontOfSize:15 weight:-0.15];
    [self.view addSubview:passWord];
    [passWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(phoneText.mas_bottom);
        make.height.equalTo(@64);
    }];

    UIView *passWordView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 48, 48)];
    UIImageView *passWordleftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"验证信息图标"]];
    [passWordView addSubview:passWordleftImage];
    [passWordleftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    passWord.leftView = passWordView;
    passWord.leftViewMode = UITextFieldViewModeAlways;
    passWord.layer.borderColor = [UIColor grayColor].CGColor;
    passWord.layer.borderWidth = 0.5;

    //自定义button 一定要用这个工厂方法

    UIButton *getCode = [UIButton buttonWithType:UIButtonTypeCustom];
//    [getCode setTitle:@"忘记密码" forState:UIControlStateNormal];
//    [getCode setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [getCode setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"验证码按钮"]] forState:UIControlStateNormal];
    [getCode titleLabel].font = [UIFont systemFontOfSize:14];
    //80 64
    //自动布局 auotLayout ，就不能再以某个视图的frame当做
    [getCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCode setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [getCode titleLabel].font = [UIFont systemFontOfSize:15 weight:-0.15 ];
    UIView *rightView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 108, 48)];
    [getCode setBackgroundColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [rightView addSubview:getCode];
    [getCode layer].cornerRadius = 4.0f;
    [getCode layer].borderWidth = 1.0f;
    passWord.rightView = rightView ;
    passWord.rightViewMode = UITextFieldViewModeAlways;
    [getCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.top.equalTo(@8);
        make.left.equalTo(@4);
    }];

   //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(gotoRegister)];

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
