//
//  UIImage+Extension.m
//
//  Created by pc on 14/12/11.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

/**
 *  返回一张可以随意拉伸不变形的图片
 */
+ (UIImage *)resizeableImage:(NSString *)name
{
    UIImage * normal = [UIImage imageNamed:name];
    
    CGFloat w = normal.size.width * 0.5;
    CGFloat h = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
}

@end
