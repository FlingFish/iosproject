//
//  CountryListViewController.h
//  FunCourse
//
//  Created by 寒竹子 on 15/1/31.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//  国家列表

#import "ParentViewController.h"
#import "SMS_SDK/CountryAndAreaCode.h"

@protocol CountryListViewControllerDelegate <NSObject>

// 发送数据
- (void)sendCountryData:(CountryAndAreaCode *)countryData;

@end

@interface CountryListViewController : ParentViewController

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) NSDictionary * countryNames;
@property (nonatomic, strong) NSMutableDictionary * names;
@property (nonatomic, strong) NSMutableArray * keys;

// 初始化搜索
- (void)setupSearch;
// 搜索
- (void)handleSearchWithString:(NSString *)searchTerm;

// 代理
@property (nonatomic, weak) id <CountryListViewControllerDelegate> delegate;

// 设置地区列表
- (void)setAreaArray:(NSMutableArray *)array;

@end
