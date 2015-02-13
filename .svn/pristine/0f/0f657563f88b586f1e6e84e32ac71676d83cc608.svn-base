//
//  RegisterViewController4.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/30.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#define kBorder 10
#define kImageWidth 100

#import "RegisterViewController4.h"
#import "AppDelegate.h"
#import "MyImageView.h"

@interface RegisterViewController4 ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) MyImageView * imageView; // 头像

@property (nonatomic, strong) UIImagePickerController * imagePickerController;

@end

@implementation RegisterViewController4

/**
 *  AppDelegate助手方法
 */
- (AppDelegate *)defaultAppdelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

/**
 *  初始化UI
 */
- (void)setupUI
{
    self.view.backgroundColor = RGB(236, 235, 241, 1.0);
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    titleView.text = @"上传头像(4/4)";
    titleView.font = [UIFont boldSystemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.textColor = [UIColor whiteColor];
    
    // 完成按钮
    UIButton * finishButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    finishButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [finishButton setTitle:@"完成" forState:UIControlStateNormal];
    finishButton.titleLabel.textColor = [UIColor whiteColor];
    finishButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [finishButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * finishItem = [[UIBarButtonItem alloc] initWithCustomView:finishButton];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:finishItem titleView:titleView];
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 270)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    [bgView addSubview:self.imageView];
    
    // 按钮
    UIButton * fromBlumButton = [[UIButton alloc] initWithFrame:CGRectMake(kBorder, CGRectGetMaxY(_imageView.frame) + kBorder * 3, SCREEN_SIZE.width - kBorder * 2, 44)];
    [fromBlumButton setTitle:@"从相册选择" forState:UIControlStateNormal];
    [fromBlumButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fromBlumButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [fromBlumButton setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [fromBlumButton setBackgroundColor:RGBACOLOR(76, 172, 225, 1.0)];
    fromBlumButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    fromBlumButton.clipsToBounds = YES;
    fromBlumButton.layer.cornerRadius = 3;
    [fromBlumButton addTarget:self action:@selector(selectImageFromPhotoLibary) forControlEvents:UIControlEventTouchUpInside];
    
    [bgView addSubview:fromBlumButton];
    
    UIButton * fromCamaraButton = [[UIButton alloc] initWithFrame:CGRectMake(kBorder, CGRectGetMaxY(fromBlumButton.frame) + kBorder * 2, SCREEN_SIZE.width - kBorder * 2, 44)];
    [fromCamaraButton setTitle:@"拍照" forState:UIControlStateNormal];
    [fromCamaraButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fromCamaraButton setTitleColor:[UIColor cyanColor] forState:UIControlStateHighlighted];
    [fromCamaraButton setBackgroundColor:RGBACOLOR(76, 172, 225, 1.0)];
    fromCamaraButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    fromCamaraButton.titleLabel.font = [UIFont systemFontOfSize:17];
    fromCamaraButton.clipsToBounds = YES;
    fromCamaraButton.layer.cornerRadius = 3;
    [fromCamaraButton addTarget:self action:@selector(selectImageFromCamara) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:fromCamaraButton];
    
    // 信息
    UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBorder, CGRectGetMaxY(bgView.frame) + kBorder, SCREEN_SIZE.width - kBorder * 2, 44)];
    infoLabel.text = @"上传真实头像会让你得到更多关注。";
    infoLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:infoLabel];
    
    UILabel * infoLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(kBorder, CGRectGetMaxY(infoLabel.frame), SCREEN_SIZE.width - kBorder * 2, 44)];
    infoLabel1.numberOfLines = 0;
    infoLabel1.text = @"上传图片请不要涉及色情等不良信息，否则将会被封号哦!";
    infoLabel1.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:infoLabel1];
}

// 图片选择器
- (UIImagePickerController *)imagePickerController
{
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        [_imagePickerController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_black"] forBarMetrics:UIBarMetricsDefault];
        _imagePickerController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        [_imagePickerController setAllowsEditing:YES]; // 允许编辑
    }
    return _imagePickerController;
}

// 头像
- (MyImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[MyImageView alloc] initWithFrame:CGRectMake((SCREEN_SIZE.width -kImageWidth - kBorder * 2) / 2.0, kBorder * 2, kImageWidth, kImageWidth)];
        _imageView.clipsToBounds = YES;
        _imageView.layer.cornerRadius = kImageWidth / 2.0;
        [_imageView setImage:[UIImage imageNamed:@"DefaultAvatar_L"]];
    }
    return _imageView;
}

/**
 *  返回
 */
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  完成
 */
- (void)finishAction
{
    // 自动登录
    AppDelegate * delegate = [self defaultAppdelegate];
    
    [delegate loginStateChanged:nil];
}

// 从照片选择图片
- (void)selectImageFromPhotoLibary
{
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}

// 拍照
- (void)selectImageFromCamara
{
#if !TARGET_IPHONE_SIMULATOR
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
#endif
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 选择完图片 设置图片
    UIImage * selectImage = info[@"UIImagePickerControllerEditedImage"];
    // 设置头像
    [_imageView setImage:selectImage];
    
    // 关闭图片选择控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
