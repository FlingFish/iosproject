//
//  TypePickerView.h
//  FunCourse
//
//  Created by 韩刚 on 15/1/15.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypePickerView : UIView

+ (instancetype)typePickerViewWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images;

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images;
-(void)show;
-(void)dismiss;
-(void)dismiss:(BOOL)animated;

@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) void (^selectRowAtIndex)(NSInteger index);

@end
