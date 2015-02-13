//
//  XRSegmentNavigationController.h
//  XRSegmentNavigationController
//
//  Created by qianfeng on 14-9-30.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

/**
  *************************************************************
  *Project: SegmentNavigationController 视图翻页切换控制器
  *Date   : 2015年01月19日17:48:47
  *Version: V2.0
  *Author : by xu ran
  *brief  : 添加了改变index回调的Block
  *************************************************************
  */

#import <UIKit/UIKit.h>

typedef void (^CallBackBlock) (NSInteger index);

@interface XRSegmentNavigationController : UIViewController<UIScrollViewDelegate>

// 设置属性
@property (nonatomic, strong) UIColor * barColor; // bar的背景色
@property (nonatomic, strong) UIColor * lineColor; // line的颜色
@property (nonatomic, strong) UIColor * lineViewColor; // lineView的背景色
@property (nonatomic, strong) UIColor * btnTitleColor; // 按钮的字体颜色
@property (nonatomic, assign) CGFloat barY; // bar的y坐标
@property (nonatomic, assign) CGFloat barHeight; // bar的高度
@property (nonatomic, strong) UIFont * btnTitleFont; // 字体
@property (nonatomic, assign) CGFloat dis_bottomHeight; // ScrollView距离底部的高度
@property (nonatomic, assign) CGFloat buttonHeight; // 按钮的高度

// 定义Block
@property (nonatomic, copy) CallBackBlock myBlock;

// 对外提供的接口
- (id)initWithItems:(NSArray *)controllers titles:(NSArray *)titles;

// 设置颜色
- (void)setColorWithBarColor:(UIColor *)barColor lineColor:(UIColor *)lineColor lineViewColor:(UIColor *)lineViewColor btnTitleColor:(UIColor *)btnTitleColor;

// 设置位置坐标
- (void)setPosition:(CGFloat)barY;

// 设置字体和bar的高度及按钮的高度
- (void)setTitleFont:(UIFont *)font barHeight:(CGFloat)barHeight buttonHeight:(CGFloat)buttonHeight;

// 改变 index的Block回调
- (void)changedIndexWithCallBack:(CallBackBlock)callBlock;

@end
