//
//  XRSearchBar.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/19.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#define kBorder 5

#import "XRSearchBar.h"

@implementation XRSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        for (UIView * subview in self.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [subview removeFromSuperview]; // 移除背景
            }
            
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                UITextField * textFeild = (UITextField *)subview;
                [textFeild setBorderStyle:UITextBorderStyleNone];
                textFeild.background = nil;
                textFeild.frame = CGRectMake(kBorder, kBorder, self.bounds.size.width - kBorder * 2, self.bounds.size.height - kBorder * 2);
                textFeild.layer.masksToBounds = YES;
                textFeild.layer.cornerRadius = 5;
                textFeild.backgroundColor = [UIColor whiteColor];
            }
        }
    }
    
    return self;
}

@end
