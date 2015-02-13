//
//  XRSegmentNavigationController.m
//  XRSegmentNavigationController
//
//  Created by qianfeng on 14-9-30.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "XRSegmentNavigationController.h"

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@interface XRSegmentNavigationController ()
{
    NSArray * _titles;
    NSArray * _controllers;
    
    UIScrollView * _scrollView;
    UIView * _barView;
    
    NSInteger _currentIndex; // 索引
    
    NSMutableArray * _buttons; // 保存button
    
    UIView * _lineView; // 底部下划线
    UIView * _line; // 上部下划线
}

@end

@implementation XRSegmentNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization 默认调用这个初始化方法
        _titles = [[NSArray alloc] init];
        _buttons = [[NSMutableArray alloc] init];
        _currentIndex = 0;
    }
    return self;
}

#pragma mark - 初始化title和ViewController控制器
- (id)initWithItems:(NSArray *)controllers titles:(NSArray *)titles {
    self = [super init];
    
    if (self) {
        _titles = titles;
        _controllers = controllers;
    }
    
    return self;
}

#pragma mark - 初始化设置颜色
- (void)setColorWithBarColor:(UIColor *)barColor lineColor:(UIColor *)lineColor lineViewColor:(UIColor *)lineViewColor btnTitleColor:(UIColor *)btnTitleColor {
    self.barColor = barColor;
    self.lineColor = lineColor;
    self.lineViewColor = lineViewColor;
    self.btnTitleColor = btnTitleColor;
}

#pragma mark - 初始化设置BarView的坐标
- (void)setPosition:(CGFloat)barY{
    self.barY = barY;
}

#pragma mark - 设置title的字体
- (void)setTitleFont:(UIFont *)font barHeight:(CGFloat)barHeight buttonHeight:(CGFloat)buttonHeight{
    self.btnTitleFont = font;
    self.barHeight = barHeight;
    if (barHeight - buttonHeight < 2.5) {
        _buttonHeight = barHeight - 2.5;
    }else {
        self.buttonHeight = buttonHeight;
    }
}

#pragma mark - 创建BarView
- (void)createBarView {
    
    _barView = [[UIView alloc] initWithFrame:CGRectMake(0, self.barY, SCREEN_SIZE.width, self.barHeight)];
    [_barView setBackgroundColor:self.barColor];
    
    // 计算按钮的宽度
    float btnWidth = SCREEN_SIZE.width / _titles.count;
    
    for (int i = 0; i < _titles.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * btnWidth, (self.barHeight - self.buttonHeight - 2.5) / 2.0f,  btnWidth, self.buttonHeight);
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        btn.tag = 101 + i;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:self.btnTitleColor forState:UIControlStateHighlighted];
        [btn setTitleColor:self.btnTitleColor forState:UIControlStateSelected];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter; // 文字居中
        btn.titleLabel.font = self.btnTitleFont;
        
        [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [_buttons addObject:btn];
        [_barView addSubview:btn];
    }
    
    // 设置默认选中第一个按钮
    UIButton * btn = _buttons[0];
    [btn setSelected:YES];
    
    [self.view addSubview:_barView];
}

#pragma mark - 按钮单击事件
- (void)onClick:(UIButton *)btn {
    
    [btn setSelected:YES];
    for (UIButton * b in _buttons) {
        if (b.tag != btn.tag) {
            [b setSelected:NO];
        }
    }
    
    _currentIndex = btn.tag - 101;
    // 通过_currentIndex 改变line的x坐标值
    CGRect lineF = _line.frame;
    lineF.origin.x = _line.frame.size.width * _currentIndex;
    _line.frame = lineF;
    
    // 改变scrollView的偏移量 切换视图控制器
    _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width * _currentIndex, 0);
    
    // 执行block
    if (self.myBlock) {
        self.myBlock(_currentIndex);
    }
}

#pragma mark - 创建底部下划线lineView
- (void)createLineView {
    
    CGFloat lineY = CGRectGetMaxY(((UIButton *)_buttons[0]).frame) + 1;
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, lineY, SCREEN_SIZE.width, 1.0)];
    _lineView.backgroundColor = self.lineViewColor;
    [_barView addSubview:_lineView];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(0, lineY, ((UIButton *)_buttons[0]).frame.size.width, _lineView.frame.size.height)];
    _line.backgroundColor = self.lineColor;
    
    [_barView addSubview:_line];
}

#pragma mark - 创建控制器controllers
- (void)createViewController {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_barView.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(_barView.frame) - self.dis_bottomHeight)];
    
    [self.view addSubview:_scrollView];
    
    // 把视图控制器的view粘到scrollView上
    for (int i = 0; i < _controllers.count; i++) {
        ((UIViewController *)(_controllers[i])).view.frame = CGRectMake(i * SCREEN_SIZE.width, 0, SCREEN_SIZE.width, _scrollView.bounds.size.height);
        [_scrollView addSubview:((UIViewController *)(_controllers[i])).view];
    }
    
    _scrollView.pagingEnabled = YES; // 翻页模式
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.bouncesZoom = NO;
    _scrollView.delegate = self;
    
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * _controllers.count, 0);
}

#pragma mark - scrollView停止滚动时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset; // 获取偏移量
    
    _currentIndex = offset.x / _scrollView.bounds.size.width;
    
    UIButton * selBtn = (UIButton *)[_barView viewWithTag:_currentIndex + 101];
    [selBtn setSelected:YES];
    CGRect lineF = _line.frame;
    lineF.origin.x = _line.frame.size.width * _currentIndex;
    _line.frame = lineF;
    
    for (UIButton * b in _buttons) {
        if (b.tag != _currentIndex + 101) {
            [b setSelected:NO];
        }
    }
    
    // 执行block代码块
    if (self.myBlock) {
        self.myBlock(_currentIndex);
    }
}

/**
 *  从外部传入代码块
 */
- (void)changedIndexWithCallBack:(CallBackBlock)callBlock
{
    // copy Block
    self.myBlock = [callBlock copy];
    
    // 执行block
    if (self.myBlock) {
        self.myBlock(_currentIndex);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置默认的背景颜色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createBarView];
    [self createLineView];
    [self createViewController];
}

@end
