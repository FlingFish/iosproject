//
//  RegisterViewController3.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/30.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#define kBorder 10

#import "RegisterViewController3.h"
#import "RegisterViewController4.h"
#import "QRadioButton.h"
#import "NSString+Helper.h"
#import "MBProgressHUD.h"

@interface RegisterViewController3 ()<QRadioButtonDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSString * nickName; // 昵称
@property (nonatomic, strong) NSString * sexStr;   // 性别
@property (nonatomic, assign) int age;             // 年龄
@property (nonatomic, strong) NSString * constellation; // 星座

@property (nonatomic, strong) UITextField * nickFiled; // 昵称
@property (nonatomic, strong) UIDatePicker * datePicker; // 日期选择器

@property (nonatomic, strong) UILabel * ageInfoLabel; // 年龄显示
@property (nonatomic, strong) UILabel * contellationInfoLabel; // 星座显示

@end

@implementation RegisterViewController3

/**
 *  初始化UI
 */
- (void)setupUI
{
    self.view.backgroundColor = RGB(236, 235, 241, 1.0);
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    titleView.text = @"填写个人信息(3/4)";
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
    
    // 昵称+性别
    UIView * filedView = [[UIView alloc] initWithFrame:CGRectMake(0, kBorder * 2, SCREEN_SIZE.width, 256)];
    filedView.backgroundColor = [UIColor whiteColor];
    
    UILabel * nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBorder, kBorder, 60, 44)];
    nickLabel.text = @"昵称";
    nickLabel.textAlignment = NSTextAlignmentCenter;
    nickLabel.font = [UIFont systemFontOfSize:16];
    [filedView addSubview:nickLabel];
    
    [filedView addSubview:self.nickFiled];
    
    UILabel * sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBorder, CGRectGetMaxY(nickLabel.frame) + kBorder, 60, 44)];
    sexLabel.text = @"性别";
    sexLabel.textAlignment = NSTextAlignmentCenter;
    sexLabel.font = [UIFont systemFontOfSize:16];
    [filedView addSubview:sexLabel];
    
    // 创建RadioButton
    QRadioButton * manButton = [[QRadioButton alloc] initWithDelegate:self groupId:@"sexGroupId"];
    manButton.frame = CGRectMake(80, CGRectGetMaxY(_nickFiled.frame) + kBorder, 80, 44);
    [manButton setTitle:@"男" forState:UIControlStateNormal];
    [manButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [manButton setChecked:YES];
    [filedView addSubview:manButton];
    
    QRadioButton * faleButton = [[QRadioButton alloc] initWithDelegate:self groupId:@"sexGroupId"];
    faleButton.frame = CGRectMake(CGRectGetMaxX(_nickFiled.frame) - 80 - kBorder, manButton.frame.origin.y, 80, 44);
    [faleButton setTitle:@"女" forState:UIControlStateNormal];
    [faleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [filedView addSubview:faleButton];
    
    [self.view addSubview:filedView];
    
    // 年龄
    UILabel * ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBorder, CGRectGetMaxY(sexLabel.frame) + kBorder, 60, 44)];
    ageLabel.text = @"年龄";
    ageLabel.textAlignment = NSTextAlignmentCenter;
    ageLabel.font = [UIFont systemFontOfSize:16];
    [filedView addSubview:ageLabel];
    
    _ageInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, ageLabel.frame.origin.y, SCREEN_SIZE.width - 80 - kBorder * 4, 44)];
    _ageInfoLabel.textAlignment = NSTextAlignmentRight;
    _ageInfoLabel.font = [UIFont systemFontOfSize:16];
    [filedView addSubview:_ageInfoLabel];
    
    // 星座
    UILabel * contellationLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBorder, CGRectGetMaxY(ageLabel.frame) + kBorder, 60, 44)];
    contellationLabel.text = @"星座";
    contellationLabel.textAlignment = NSTextAlignmentCenter;
    contellationLabel.font = [UIFont systemFontOfSize:16];
    [filedView addSubview:contellationLabel];
    
    _contellationInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, contellationLabel.frame.origin.y, SCREEN_SIZE.width - 80 - kBorder * 4, 44)];
    _contellationInfoLabel.text = @"金牛座";
    _contellationInfoLabel.textAlignment = NSTextAlignmentRight;
    _contellationInfoLabel.font = [UIFont systemFontOfSize:16];
    [filedView addSubview:_contellationInfoLabel];
    
    [self.view addSubview:self.datePicker];
    
    // 提示label
    UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBorder, CGRectGetMaxY(filedView.frame) + kBorder, SCREEN_SIZE.width - kBorder * 2, 44)];
    infoLabel.text = @"选择您的出生日期，系统将会自动算出您的年龄和星座。";
    infoLabel.numberOfLines = 0;
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.textColor = [UIColor grayColor];
    infoLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:infoLabel];
}

#pragma mark - getter

- (UITextField *)nickFiled
{
    if (_nickFiled == nil) {
        _nickFiled = [[UITextField alloc] initWithFrame:CGRectMake(80, kBorder, SCREEN_SIZE.width - 80 - kBorder, 44)];
        _nickFiled.placeholder = @"请输入您的昵称（1~8字符）";
        _nickFiled.delegate = self;
        _nickFiled.returnKeyType = UIReturnKeyDone;
    }
    return _nickFiled;
}

// 日期选择
- (UIDatePicker *)datePicker
{
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] init]; // 设置datePicker的大小必须单独设置其frame
        _datePicker.frame = CGRectMake(0, SCREEN_SIZE.height - 216, SCREEN_SIZE.width, 162);
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
        // 设定默认值
        NSString * defaultDateStr = @"1990-01-01";
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd +0800"; // 修改为东八区
        // 转换为日期
        NSDate * defaultDate = [formatter dateFromString:defaultDateStr];
        [_datePicker setDate:defaultDate];
        // 计算年龄
        NSTimeInterval dateInterval = [defaultDate timeIntervalSinceNow];
        _age = -trunc(dateInterval / (60 * 60 * 24) / 365);
        _ageInfoLabel.text = [NSString stringWithFormat:@"%i", _age];
        
        // 计算星座
        _contellationInfoLabel.text = [self toConvertContellationWithDate:defaultDate];
        _constellation = _contellationInfoLabel.text;
        
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _datePicker;
}

// 计算星座
- (NSString *)toConvertContellationWithDate:(NSDate *)date
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString * str = [formatter stringFromDate:date];
    
    NSArray * arr = [str componentsSeparatedByString:@"-"]; // 以-进行分割
    int month = [[arr objectAtIndex:1] intValue];
    int day   = [[arr objectAtIndex:2] intValue];
    
    NSString * contellationStr = nil; // 星座
    switch (month) {
        case 1:
        {
            // 1月
            if (day <= 19 && day >= 1) {
                // 摩羯座
                contellationStr = @"摩羯座";
            }else {
                // 水瓶座
                contellationStr = @"水瓶座";
            }
        }
            break;
        case 2:
        {
            // 2月
            if (day <= 18 && day >= 1) {
                // 水瓶座
                contellationStr = @"水瓶座";
            }else {
                // 双鱼座
                contellationStr = @"双鱼座";
            }
        }
            break;
        case 3:
        {
            // 3月
            if (day <= 20 && day >= 1) {
                // 双鱼座
                contellationStr = @"双鱼座";
            }else {
                // 白羊座
                contellationStr = @"白羊座";
            }
        }
            break;

        case 4:
        {
            // 4月
            if (day <= 20 && day >= 1) {
                // 白羊座
                contellationStr = @"白羊座";
            }else {
                // 金牛座
                contellationStr = @"金牛座";
            }
        }
            break;

        case 5:
        {
            // 5月
            if (day <= 20 && day >= 1) {
                // 金牛座
                contellationStr = @"金牛座";
            }else {
                // 双子座
                contellationStr = @"双子座";
            }
        }
            break;

        case 6:
        {
            // 6月
            if (day <= 21 && day >= 1) {
                // 双子座
                contellationStr = @"双子座";
            }else {
                // 巨蟹座
                contellationStr = @"巨蟹座";
            }
        }
            break;

        case 7:
        {
            // 7月
            if (day <= 22 && day >= 1) {
                // 巨蟹座
                contellationStr = @"巨蟹座";
            }else {
                // 狮子座
                contellationStr = @"狮子座";
            }
        }
            break;

        case 8:
        {
            // 8月
            if (day <= 22 && day >= 1) {
                // 狮子座
                contellationStr = @"狮子座";
            }else {
                // 处女座
                contellationStr = @"处女座";
            }
        }
            break;

        case 9:
        {
            // 9月
            if (day <= 22 && day >= 1) {
                // 处女座
                contellationStr = @"处女座";
            }else {
                // 天秤座
                contellationStr = @"天秤座";
            }
        }
            break;

        case 10:
        {
            // 10月
            if (day <= 22 && day >= 1) {
                // 天秤座
                contellationStr = @"天秤座";
            }else {
                // 天蝎座
                contellationStr = @"天蝎座";
            }
        }
            break;

        case 11:
        {
            // 11月
            if (day <= 21 && day >= 1) {
                // 天蝎座
                contellationStr = @"天蝎座";
            }else {
                // 射手座
                contellationStr = @"射手座";
            }
        }
            break;
        case 12:
        {
            // 12月
            if (day <= 21 && day >= 1) {
                // 射手座
                contellationStr = @"射手座";
            }else {
                // 摩羯座
                contellationStr = @"摩羯座";
            }
        }
            break;
        default:
            break;
    }
    
    return contellationStr;
}

// datePicker的值改变
- (void)datePickerValueChanged:(UIDatePicker *)datePicker
{
    NSDate * date = datePicker.date; // 取出日期

    // 计算年龄
    NSTimeInterval dateInterval = [date timeIntervalSinceNow];
    _age = -trunc(dateInterval / (60 * 60 * 24) / 365);
    _ageInfoLabel.text = [NSString stringWithFormat:@"%i", _age];
    
    // 计算星座
    _constellation = [self toConvertContellationWithDate:date];
    _contellationInfoLabel.text = _constellation;
}

/**
 *  返回
 */
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  下一步
 */
- (void)nextStepAction
{
    [_nickFiled resignFirstResponder];
    _nickName = _nickFiled.text; // 得到昵称
    
    // 判断昵称是否为空
    if ([self.nickName isEmptyString]) {
        __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200) / 2.0, (self.view.frame.size.height - 150) / 2.0, 200, 150)];
        progress.labelText = @"请输入昵称";
        progress.labelFont = [UIFont systemFontOfSize:18];
        progress.mode = MBProgressHUDModeText;
        progress.animationType = MBProgressHUDAnimationFade;
        [self.view addSubview:progress];
        
        [progress showAnimated:YES whileExecutingBlock:^{
            sleep(1.0);
        } completionBlock:^{
            [progress removeFromSuperview];
            progress = nil;
            [_nickFiled becomeFirstResponder];
            return;
        }];
    }else {
        // 验证年龄是否正确
        if (_age > 0 && _age <= 100) {
#warning 上传数据到服务器
            
            RegisterViewController4 * registerVc4 = [[RegisterViewController4 alloc] init];
            [self.navigationController pushViewController:registerVc4 animated:YES];
        }else {
            __block MBProgressHUD * progress = [[MBProgressHUD alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200) / 2.0, (self.view.frame.size.height - 150) / 2.0, 200, 150)];
            progress.labelText = @"这不像是您的年龄哦";
            progress.labelFont = [UIFont systemFontOfSize:18];
            progress.mode = MBProgressHUDModeText;
            progress.animationType = MBProgressHUDAnimationFade;
            [self.view addSubview:progress];
            
            [progress showAnimated:YES whileExecutingBlock:^{
                sleep(1.0);
            } completionBlock:^{
                [progress removeFromSuperview];
                progress = nil;
                return;
            }];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

// touch收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_nickFiled resignFirstResponder];
}

#pragma mark - QRadioButtonDelegate

- (void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId
{
    _sexStr = radio.titleLabel.text; // 设置用户选择的性别
}

#pragma mark - UITextFiledDelegate

// 限制昵称长度为8个字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 8) {
        return NO;
    }else {
        return YES;
    }
}

// 回车
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
