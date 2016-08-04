
//
//  YZRegisterViewController.m
//  Share
//
//  Created by 禾家木 on 16/8/3.
//  Copyright © 2016年 hejiamu. All rights reserved.
//

#import "YZRegisterViewController.h"
#import "Masonry.h"
#import "UIButton+BackgroundColor.h"
#import "UIControl+ActionBlocks.h"
#import "ReactiveCocoa/ReactiveCocoa.h"
#import "SMS_SDK/SMSSDK.h"
#import "NSTimer+Blocks.h"
#import "NSString+MD5.h"
#import "NetworkingTool.h"
#import "UIAlertView+Block.h"
@interface YZRegisterViewController ()
/*  写成属性 方便监控变化 */
@property (nonatomic, strong)NSNumber *waitTime;
/*  定时器作为属性 */
@property (nonatomic, strong)NSTimer *timer;
@end

@implementation YZRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}

-(void)setupViews {
    UITextField *phonetext = [[UITextField alloc ] init];
    [self.view addSubview:phonetext];

    UITextField *password = [[UITextField alloc] init];
    [self.view addSubview:password];
    
    UITextField *getCode = [[UITextField alloc] init];
    [self.view addSubview:getCode];


    phonetext.placeholder = @"请输入邮箱或者手机号";
    password.placeholder = @"请输入密码";
    getCode.placeholder = @"请输入验证码";

    password.secureTextEntry = YES;

    UIImageView *phoneLeftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户图标"]];
    UIImageView *passwordLeftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"新密码图标"]];
    UIImageView *getCodeViewleftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"验证信息图标"]];

    UIView *phoneLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 64)];
    UIView *passwordLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 64)];
    UIView *getCodeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 64)];

    [passwordLeft addSubview:passwordLeftImage];
    [phoneLeft addSubview:phoneLeftImage];
    [getCodeView addSubview:getCodeViewleftImage];


    phonetext.leftView = phoneLeft;
    password.leftView = passwordLeft;
    getCode.leftView = getCodeView;


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
    [getCodeViewleftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@30);
        make.height.equalTo(@40);
    }];
    phonetext.leftViewMode =   UITextFieldViewModeAlways;
    password.leftViewMode  =   UITextFieldViewModeAlways;
    getCode.leftViewMode = UITextFieldViewModeAlways;
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

    [getCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(@0);
        make.height.equalTo(@64);
        make.top.equalTo(@278);
    }];
    //
    phonetext.font = [UIFont systemFontOfSize:15 weight:-0.15];
    password.font = [UIFont systemFontOfSize:15 weight:-0.15];
    getCode.font = [UIFont systemFontOfSize:15 weight:-0.15];

    phonetext.layer.borderColor = [UIColor grayColor].CGColor;
    phonetext.layer.borderWidth = 0.5;
    password.layer.borderColor = [UIColor grayColor].CGColor;
    password.layer.borderWidth = 0.5;
    getCode.layer.borderColor = [UIColor grayColor].CGColor;
    getCode.layer.borderWidth = 0.5;






    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"验证码按钮"]] forState:UIControlStateNormal];
    [rightButton titleLabel].font = [UIFont systemFontOfSize:14];

    [rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [rightButton titleLabel].font = [UIFont systemFontOfSize:15 weight:-0.15 ];
    UIView *rightView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 108, 48)];
    [rightButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [rightView addSubview:rightButton];
    [rightButton layer].cornerRadius = 4.0f;
    [rightButton layer].borderWidth = 1.0f;
    getCode.rightView = rightView ;
    getCode.rightViewMode = UITextFieldViewModeAlways;
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.top.equalTo(@8);
        make.left.equalTo(@4);
    }];
    [getCode handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        NSLog(@"发送验证码");
    }];

    //*判断
    //RAC帮我们实现了 很多系统自带的信号 文本框的变化 按钮点击
//    我们去订阅这些信号 那么这些信号一旦发生变化 就会通知我们
    [phonetext.rac_textSignal subscribeNext:^(NSString *phone) {

        if (phone.length >= 11) {

            [password becomeFirstResponder];
            if (phone.length > 11) {
                phonetext.text = [phone substringToIndex:11];
            }
        }

    }];
    self.waitTime = @-1;
    rightButton.enabled = NO;
    //我们可以直接将某个信号处理的返回结果设置为某个对象的属性值

    //RAC 可以将信号和处理写在一起 方便我们去找
    RAC(rightButton, enabled) = [RACSignal combineLatest:@[phonetext.rac_textSignal, RACObserve(self,waitTime)] reduce:^(NSString *phone, NSNumber *waitTime){
        return @(phone.length >= 11  && waitTime.integerValue < 0);
    }];

    //如果在实际开发中 我们做开发
    //1.为了节省成本
    //一般开发中 用第三方短信提供商做发送验证码功能 一天/6-8分钱，所以成本高
    //2.为了用户体验

    //需求
    /*
     1 点击发送验证码 按钮变为不可用 发送验证码
     2 如果发送成功 按钮不可用 按钮上想害死60秒倒计时
     3 如果失败 将按钮设置为可用 提示发送失败
     4 当倒计时结束时 将按钮设置为可用（还要考虑到手机）
     */

    [rightButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        //直接进入读秒
        rightButton.enabled = NO;
        self.waitTime = @60;
        //	发送验证码
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phonetext.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (error) {
                //如果失败 让等待时间 变为-1
                self.waitTime = @-1;

            }else {
                NSLog(@"获取验证码成功");
                self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f block:^{

                        self.waitTime = [NSNumber numberWithInteger:self.waitTime.integerValue - 1];


                } repeats:YES];
            }
        }];
    }];
    [RACObserve(self, waitTime) subscribeNext:^(NSNumber  *waitTime) {
        if (waitTime.integerValue <= 0) {
            [self.timer invalidate];
            self.timer = nil;
            [rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];

        }else if(waitTime.integerValue > 0) {
            [rightButton setTitle:[NSString stringWithFormat:@"等待%@秒",waitTime] forState:UIControlStateNormal];
        }
    }];

    /**
     *  注册
     *
     *  @return void
     */


    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@50);
        make.top.equalTo(getCode.mas_bottom);
    }];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setBackgroundColor:[UIColor greenColor] forState:UIControlStateNormal];
    [registerButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        RAC(registerButton,enabled) = [RACSignal combineLatest:@[phonetext.rac_textSignal, password.rac_textSignal, getCode.rac_textSignal] reduce:^(NSString *phone, NSString *password, NSString *code){
            return @(phone.length == 11 && password.length>= 6 && code.length == 4);
        }];
//    [registerButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
//
//    }];
    /**
     *  md5 加密  会破坏字符串原来携带的信息
     但对于密码来说 服务器和app交换 并不需要知道密码所携带的信息 无论登录和注册 都必须加密 (服务器也不知道你的密码是多少)
     MD5 加密算法是死的，暴力破解方式来获取你的密码 有时候 会将我们的密码加盐后再进行加密 传给服务器
     *
     *  @return void
     */
    NSString *pass = [password.text md532BitUpper];
        [[registerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSDictionary *paras = @{
                                    @"service" : @"User.Register",
                                    @"phone":phonetext.text,
                                    @"password":pass,
                                    @"verificationCode":getCode.text
                                    };
            
            [NetworkingTool getDataWithParameters:paras completeBlock:^(BOOL success, id result) {
                if (success) {

                }else{
                    [UIAlertView alertWithCallBackBlock:nil title:@"温馨提示" message:result cancelButtonName:@"确定" otherButtonTitles:nil, nil];
                }
            } ];
        }];

}
//需求

//1.账号输入框只可输入数子
//2.当用户输入完11个数字，不能再继续输入
//3.当账号输入框 少于11个数字 获取验证码按钮灰色不可点
//4.11个数字 密码大于6和长度 验证码四个位数字 注册按钮可以按
//ReactiveCocoa github出品的 响应式编程框架
//ReactiveCocoa处理
//ReactiveCocoa 可以代替 delegate/target action\通知\kvo。。。一系列 ios开发里面的数据传递方式
//RAC 使用的是信号流的方式来处理我们的数据 无论是按钮点击事件还是输入框事件 还是网络数据获取。。。都可以当做“信号来看待”
//我们可以 观测 某个信号的改变 来做相应的操作
//RAC 还可以像许多信号合并处理 过滤某些信号 自定义一些信号 所以比较强大

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
