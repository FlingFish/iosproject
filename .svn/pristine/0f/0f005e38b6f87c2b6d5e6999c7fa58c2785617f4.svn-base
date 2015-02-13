//
//  PickAddressViewController.h
//  FunCourse
//
//  Created by 韩刚 on 15/2/2.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import "ParentViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
//#import "BaseMapViewController.h"

@protocol PickAddressDelegate <NSObject>

- (void)sendAddressStr:(NSString *)address;

@end

@interface PickAddressViewController : ParentViewController<MAMapViewDelegate, AMapSearchDelegate>
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, weak ) id <PickAddressDelegate>delegate;

@property (nonatomic, strong) UINavigationController * superNvc; // 导航

- (void)returnAction;

@end
