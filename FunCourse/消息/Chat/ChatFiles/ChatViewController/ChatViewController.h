/************************************************************
  *  * EaseMob CONFIDENTIAL 
  * __________________ 
  * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved. 
  *  
  * NOTICE: All information contained herein is, and remains 
  * the property of EaseMob Technologies.
  * Dissemination of this information or reproduction of this material 
  * is strictly forbidden unless prior written permission is obtained
  * from EaseMob Technologies.
  */

#import "ParentViewController.h"

@interface ChatViewController : ParentViewController

@property (nonatomic, strong) UINavigationController * superNav;
@property (nonatomic, strong) NSString * nickName; // 聊天对方的昵称

- (instancetype)initWithChatter:(NSString *)chatter isGroup:(BOOL)isGroup;

@end
