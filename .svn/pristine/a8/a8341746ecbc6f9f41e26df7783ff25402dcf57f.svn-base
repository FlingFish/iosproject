//
//  MyCATransition.h
//  风行电影
//
//  Created by qianfeng on 14-8-31.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface MyCATransition : CATransition

// 参数说明：

/********************type**************/

// `fade', 渐变
// `moveIn' 进入, 
// `push' 推出 
// `reveal'. 展现 
// cube 立方 
// suckEffect 吸收 
// oglFlip 上下翻转 
// rippleEffect 水滴 
// pageCurl 卷页
// pageUnCurl 后翻页
// cameraIrisHollowOpen 开相机 
// cameraIrisHollowClose 关相机

/********************subtype**************/
// fromLeft', 
// `fromRight', 
// `fromTop'
// `fromBottom'
 /********************timingFunction**************/
// timingFunction:
// linear', 
// `easeIn', 
// `easeOut'
// `easeInEaseOut'
//

// 自定义转场动画
+ (MyCATransition *)catransitionWithType:(NSString *)type subType:(NSString *)subType duration:(double)duration timingFunction:(NSString *)timingName;

@end
