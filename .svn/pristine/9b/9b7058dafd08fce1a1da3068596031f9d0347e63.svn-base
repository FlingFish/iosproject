//
//  RegisterViewController2.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/30.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#define kBorder 10

#import "RegisterViewController2.h"
#import "RegisterViewController3.h"
#import "LoginViewController.h"
#import <SMS_SDK/SMS_SDK.h>
#import "MBProgressHUD.h"
#import "NSString+Helper.h"

static int count = 60; // 计数器

@interface RegisterViewController2 ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * codeField;  // 验证码
@property (nonatomic, strong) UITextField * passwdField; // 密码
@property (nonatomic, strong) UIButton *    reSendButton; // 重发验证码按钮
@property (nonatomic, strong) NSString * countMessage;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) URBAlertView * alertView;
@property (nonatomic, assign) BOOL doRegisterSuccessful; // 是否注册成功

@end

@implementation RegisterViewController2

- (void)dealloc
{
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

// 起定时器
- (NSTimer *)timer
{
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateCount) userInfo:nil repeats:YES];
    }
    
    return _timer;
}

// 更新count
- (void)updateCount
{
    self.countMessage = [NSString stringWithFormat:@"%@(%i)", @"重新发送验证码", count];
    [_reSendButton setTitle:_countMessage forState:UIControlStateNormal];
    count--;
    if (count < 0) {
        count = 60;
        _reSendButton.backgroundColor = RGB(98, 159, 254, 1.0);
        _reSendButton.enabled = YES;
        [_reSendButton setTitle:@"重发验证码" forState:UIControlStateNormal];
        if ([_timer isValid]) {
            [_timer invalidate]; // 删除并停止timer
            _timer = nil;
        }
    }
}

/**
 *  初始化UI
 */
- (void)setupUI
{
    self.view.backgroundColor = RGB(236, 235, 241, 1.0);
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    titleView.text = @"手机号验证(2/4)";
    titleView.font = [UIFont boldSystemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.textColor = [UIColor whiteColor];
    
    // 下一步按钮
    UIButton * stepButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    stepButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [stepButton setTitle:@"下一步" forState:UIControlStateNormal];
    stepButton.titleLabel.textColor = [UIColor whiteColor];
    stepButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [stepButton addTarget:self action:@selector(nextStepAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * stepItem = [[UIBarButtonItem alloc] initWithCustomView:stepButton];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:stepItem titleView:titleView];
    
    // info
    NSString * message = @"验证短信已经发送至";
    CGSize messageSize = [message sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    
    UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBorder * 2, kBorder * 2, messageSize.width, messageSize.height)];
    infoLabel.text = message;
    infoLabel.textColor = [UIColor grayColor];
    infoLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:infoLabel];
    
    NSString * phoneInfo = [NSString stringWithFormat:@"+%@ %@", _areaCode, _phoneNumber];
    CGSize phoneInfoSize = [phoneInfo sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    UILabel * phoneInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(infoLabel.frame), kBorder * 2, phoneInfoSize.width, phoneInfoSize.height)];
    phoneInfoLabel.text = phoneInfo;
    phoneInfoLabel.textColor = RGB(98, 159, 254, 1.0);
    phoneInfoLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:phoneInfoLabel];
    
    // 验证码+密码
    UIView * filedView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(infoLabel.frame) + kBorder, SCREEN_SIZE.width, 128)];
    filedView.backgroundColor = [UIColor whiteColor];
    [filedView addSubview:self.codeField];
    [filedView addSubview:self.passwdField];
    
    [self.view addSubview:filedView];
    
    [self.view addSubview:self.reSendButton];
}

// 验证码
- (UITextField *)codeField
{
    if (_codeField == nil) {
        _codeField = [[UITextField alloc] initWithFrame:CGRectMake(kBorder * 2, kBorder, SCREEN_SIZE.width - kBorder * 4, 44)];
        _codeField.placeholder = @"输入验证码";
        _codeField.keyboardType = UIKeyboardTypeNumberPad;
        _codeField.delegate = self;
        _codeField.returnKeyType = UIReturnKeyDone;
    }
    
    return _codeField;
}

// 密码
- (UITextField *)passwdField
{
    if (_passwdField == nil) {
        _passwdField = [[UITextField alloc] initWithFrame:CGRectMake(kBorder * 2, CGRectGetMaxY(_codeField.frame) + kBorder, SCREEN_SIZE.width - kBorder * 4, 44)];
        _passwdField.placeholder = @"设置登录密码，不少于6位";
        _passwdField.secureTextEntry = YES; // 设置密文输入
        _passwdField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwdField.delegate = self;
        _passwdField.returnKeyType = UIReturnKeyDone;
    }
    return _passwdField;
}

// 重发验证码按钮
- (UIButton *)reSendButton
{
    self.countMessage = [NSString stringWithFormat:@"%@(%i)", @"重新发送验证码", count];
    if (_reSendButton == nil) {
        _reSendButton = [[UIButton alloc] initWithFrame:CGRectMake(kBorder * 2, 200, SCREEN_SIZE.width - kBorder * 4, 44)];
        _reSendButton.backgroundColor = [UIColor grayColor];
        [_reSendButton setTitle:_countMessage forState:UIControlStateNormal];
        [_reSendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _reSendButton.enabled = NO;
        _reSendButton.layer.masksToBounds = YES;
        _reSendButton.layer.cornerRadius = 4;
        [_reSendButton addTarget:self action:@selector(reSendAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _reSendButton;
}

// 收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_codeField resignFirstResponder];
    [_passwdField resignFirstResponder];
}

// 重发验证码
- (void)reSendAction
{
    [self.timer setFireDate:[NSDate distantPast]]; // 开启定时器
    _reSendButton.backgroundColor = [UIColor grayColor];
    _reSendButton.enabled = NO; // 禁止点击
    __weak typeof(self) weakSelf = self;
    // 获取验证码
    [SMS_SDK getVerifyCodeByPhoneNumber:_phoneNumber AndZone:_areaCode result:^(enum SMS_GetVerifyCodeResponseState state) {
        if (state == SMS_ResponseStateGetVerifyCodeSuccess) {
            __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 44.0)];
            progress.labelText = @"获取验证码成功";
            progress.labelFont = [UIFont boldSystemFontOfSize:17];
            progress.mode = MBProgressHUDModeText;
            progress.animationType = MBProgressHUDAnimationFade;
            [weakSelf.view addSubview:progress];
            
            [progress showAnimated:YES whileExecutingBlock:^{
                sleep(2.0);
            } completionBlock:^{
                [progress removeFromSuperview];
                progress = nil;
            }];
        }else if (state == SMS_ResponseStateGetVerifyCodeFail) {
            __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 44.0)];
            progress.labelText = @"获取验证码失败，请重新获取";
            progress.labelFont = [UIFont boldSystemFontOfSize:17];
            progress.mode = MBProgressHUDModeText;
            progress.animationType = MBProgressHUDAnimationFade;
            [weakSelf.view addSubview:progress];
            
            [progress showAnimated:YES whileExecutingBlock:^{
                sleep(2.0);
            } completionBlock:^{
                [progress removeFromSuperview];
                progress = nil;
            }];
        }
    }];
}

/**
 *  返回
 */
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

/**
 *  用户注册
 */
- (void)doRegister
{
    // 取用户名和密码
    NSString * phoneNum = self.phoneNumber;
    NSString * passWord = _passwdField.text;
    
    __weak typeof(self) weakSelf = self;
    // 环信异步注册
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:phoneNum password:passWord withCompletion:^(NSString *username, NSString *password, EMError *error) {
        NSString * message = nil;
        // 环信注册成功 再向子曰服务器进行注册
        if (!error) {
            weakSelf.doRegisterSuccessful = YES;
        }else {
            // 环信注册失败 则不再向子曰服务器注册
            weakSelf.doRegisterSuccessful = NO;
            // 注册失败
            switch (error.errorCode) {
                case EMErrorServerNotReachable:
                    message = @"连接服务器失败";
                    break;
                case EMErrorServerDuplicatedAccount:
                    message = @"您注册的用户已经存在";
                    break;
                case EMErrorServerTimeout:
                    message = @"连接服务器超时";
                    break;
                default:
                    message = @"注册失败";
                    break;
            }
        }
        // 环信注册成功  向自己的服务器注册用户
        if (weakSelf.doRegisterSuccessful) {
            NSString * url = [NSString stringWithFormat:FunRegister_URL, phoneNum, passWord];
            [XRHttpRequest PostWithUrl:url successful:^(NSMutableData *downloadData) {
                NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:downloadData options:NSJSONReadingMutableContainers error:nil];
                int status = [dict[@"status"] intValue];
                if (status == 0) {
                    // 注册成功
                    
                }else if (status == 1) {
                    // 注册失败
                    weakSelf.doRegisterSuccessful = NO;
                }
            } faild:^(NSError *error) {
                NSLog(@"%@", error.description);
            }];
        }
        
        // 弹出提示框
        _alertView = [URBAlertView dialogWithTitle:message subtitle:nil];
        [_alertView addButtonWithTitle:@"确定"];
        [_alertView showWithAnimation:URBAlertAnimationTumble];
        [_alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            
            if (0 == buttonIndex && weakSelf.doRegisterSuccessful) {
                // 注册成功
                NSString * message = @"恭喜您，注册成功!";
                __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 44.0)];
                progress.labelText = message;
                progress.labelFont = [UIFont boldSystemFontOfSize:17];
                progress.mode = MBProgressHUDModeText;
                progress.animationType = MBProgressHUDAnimationFade;
                [weakSelf.view addSubview:progress];
                
                [progress showAnimated:YES whileExecutingBlock:^{
                    sleep(2.0);
                } completionBlock:^{
                    [progress removeFromSuperview];
                    progress = nil;
                    RegisterViewController3 * registerVc3 = [[RegisterViewController3 alloc] init];
                    [weakSelf.navigationController pushViewController:registerVc3 animated:YES];
                }];
            }else {
                // 注册失败
                weakSelf.codeField.text = @"";
                weakSelf.passwdField.text = @"";
                __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 44.0)];
                progress.labelText = @"注册失败，请重新注册";
                progress.labelFont = [UIFont boldSystemFontOfSize:17];
                progress.mode = MBProgressHUDModeText;
                progress.animationType = MBProgressHUDAnimationFade;
                [weakSelf.view addSubview:progress];
                
                [progress showAnimated:YES whileExecutingBlock:^{
                    sleep(2.0);
                } completionBlock:^{
                    [progress removeFromSuperview];
                    progress = nil;
                }];
            }
            
            [weakSelf.alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
        return;
        
    } onQueue:nil];
}

/**
 *  下一步
 */
- (void)nextStepAction
{
    // 收键盘
    [_codeField resignFirstResponder];
    [_passwdField resignFirstResponder];
    
    __weak typeof(self) weakSelf = self;
 
    if ([_codeField.text isEmptyString]) {
        __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 150)];
        progress.labelText = @"请输入验证码";
        progress.labelFont = [UIFont boldSystemFontOfSize:17];
        progress.mode = MBProgressHUDModeText;
        progress.animationType = MBProgressHUDAnimationFade;
        [weakSelf.view addSubview:progress];
        
        [progress showAnimated:YES whileExecutingBlock:^{
            sleep(2.0);
        } completionBlock:^{
            [progress removeFromSuperview];
            progress = nil;
            [_codeField becomeFirstResponder];
            return;
        }];
    }else if (_codeField.text.length < 4) {
        // 输入的验证码少于4位
        __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 150)];
        progress.labelText = @"验证码为4位有效数字";
        progress.labelFont = [UIFont boldSystemFontOfSize:17];
        progress.mode = MBProgressHUDModeText;
        progress.animationType = MBProgressHUDAnimationFade;
        [weakSelf.view addSubview:progress];
        
        [progress showAnimated:YES whileExecutingBlock:^{
            sleep(2.0);
        } completionBlock:^{
            [progress removeFromSuperview];
            progress = nil;
            [_codeField becomeFirstResponder];
            return;
        }];
    }else {
        // 验证用户设置的密码是否符合要求
        if ([_passwdField.text isEmptyString]) {
            __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200) / 2.0, (self.view.frame.size.height - 150) / 2.0, 200, 150)];
            progress.labelText = @"请设置登录密码";
            progress.labelFont = [UIFont boldSystemFontOfSize:17];
            progress.mode = MBProgressHUDModeText;
            progress.animationType = MBProgressHUDAnimationFade;
            [self.view addSubview:progress];
            
            [progress showAnimated:YES whileExecutingBlock:^{
                sleep(2.0);
            } completionBlock:^{
                [progress removeFromSuperview];
                progress = nil;
                [_passwdField becomeFirstResponder];
                return;
            }];
        }else if (_passwdField.text.length < 6) {
            __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 150)];
            progress.labelText = @"登录密码不能少于6位";
            progress.labelFont = [UIFont boldSystemFontOfSize:17];
            progress.mode = MBProgressHUDModeText;
            progress.animationType = MBProgressHUDAnimationFade;
            [weakSelf.view addSubview:progress];
            
            [progress showAnimated:YES whileExecutingBlock:^{
                sleep(2.0);
            } completionBlock:^{
                [progress removeFromSuperview];
                progress = nil;
                [_passwdField becomeFirstResponder];
                return;
            }];
        }else {
            // 设置的密码符合要求 则开始验证验证码
            [SMS_SDK commitVerifyCode:_codeField.text result:^(enum SMS_ResponseState state) {
                if (state == SMS_ResponseStateSuccess) {
                    // 验证通过 且登录密码设置正确 跳转到下一步
                    
                    // 注册用户
                    [weakSelf doRegister];

                }else if (state == SMS_ResponseStateFail){
                    // 验证失败  提示用户验证失败 需要重新获取验证码
                    __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((weakSelf.view.frame.size.width - 200) / 2.0, (weakSelf.view.frame.size.height - 150) / 2.0, 200, 150)];
                    progress.labelText = @"验证失败，请重新获取验证码";
                    progress.labelFont = [UIFont boldSystemFontOfSize:17];
                    progress.mode = MBProgressHUDModeText;
                    progress.animationType = MBProgressHUDAnimationFade;
                    [weakSelf.view addSubview:progress];
                    
                    [progress showAnimated:YES whileExecutingBlock:^{
                        sleep(2.0);
                    } completionBlock:^{
                        [progress removeFromSuperview];
                        progress = nil;
                    }];
                }
            }];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.timer setFireDate:[NSDate distantPast]];
    _reSendButton.backgroundColor = [UIColor grayColor];
    _reSendButton.enabled = NO; // 禁止点击
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    count = 60;
    _reSendButton.backgroundColor = RGB(98, 159, 254, 1.0);
    _reSendButton.enabled = YES;
    [_reSendButton setTitle:@"重发验证码" forState:UIControlStateNormal];
    if ([_timer isValid]) {
        [_timer invalidate]; // 删除并停止timer
        _timer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UITextFiledDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _codeField) {
        // 输入验证码
        if (range.location >= 4) {
            return NO;
        }else {
            return YES;
        }
    }else {
        // 输入密码
        if (range.location >= 16) {
            return NO;
        }else {
            return YES;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
