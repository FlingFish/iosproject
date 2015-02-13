//
//  CountryListViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 15/1/31.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//

#import "CountryListViewController.h"
#import "NSDictionary-DeepMutableCopy.h"
#import <SMS_SDK/SMS_SDK.h>

@protocol CountryListViewControllerDelegate;


@interface CountryListViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    NSMutableArray * _areaArray;
    BOOL _isSearching; // 是否正在搜索
    NSArray * _arr;
}

@end

@implementation CountryListViewController

- (void)setupSearch
{
    NSMutableDictionary * allNameCopy = [self.countryNames mutableDeepCopy];
    self.names = allNameCopy;
    NSMutableArray * keyArray = [[NSMutableArray alloc] init];
    [keyArray addObject:UITableViewIndexSearch];
    [keyArray addObjectsFromArray:[[self.countryNames allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    self.keys = keyArray;
}

- (void)handleSearchWithString:(NSString *)searchTerm
{
    NSMutableArray * sectionsToRemove = [[NSMutableArray alloc] init];
    [self setupSearch];
    
    for (NSString * key in self.keys) {
        NSMutableArray * array = [self.names valueForKey:key];
        NSMutableArray * toRemove = [[NSMutableArray alloc] init];
        for (NSString * name in array) {
            if ([name rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location == NSNotFound) {
                [toRemove addObject:name];
            }
        }
        if ([array count] == [toRemove count]) {
            [sectionsToRemove addObject:key];
        }
        
        [array removeObjectsInArray:toRemove];
    }
    [self.keys removeObjectsInArray:sectionsToRemove];
    [_tableView reloadData];
}

// searchBar
- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, SCREEN_SIZE.width, 44)];
        _searchBar.placeholder = @"搜索";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB(236, 235, 241, 1.0);
        _tableView.tableHeaderView = self.searchBar;
        UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 100)];
        footerView.backgroundColor = RGB(236, 235, 241, 1.0);
        _tableView.tableFooterView = footerView;
    }
    
    return _tableView;
}

/**
 *  初始化UI
 */
- (void)setupUI
{
    self.view.backgroundColor = RGB(236, 235, 241, 1.0);
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    titleView.text = @"选择国家或地区";
    titleView.font = [UIFont boldSystemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.textColor = [UIColor whiteColor];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:nil titleView:titleView];
    [self.view addSubview:self.tableView];
    // 加载数据
    self.countryNames = [self readCountryList];
    [self setupSearch];
    
    [_tableView reloadData];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setAreaArray:(NSMutableArray *)array
{
    _areaArray = [NSMutableArray arrayWithArray:array];
}

/**
 *  读取国家列表数据
 */
- (NSDictionary *)readCountryList
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"country.plist" ofType:nil];
    NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    return dict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_keys count] == 0) {
        return 0;
    }
    
    NSString * key = [_keys objectAtIndex:section];
    NSArray * nameSection = [_names objectForKey:key];
    
    return [nameSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSString * key = [_keys objectAtIndex:indexPath.section];
    NSArray * nameSection = [_names objectForKey:key];
    
    NSString * countryStr = [nameSection objectAtIndex:indexPath.row];
    NSRange range = [countryStr rangeOfString:@"+"];
    NSString * codeStr = [countryStr substringFromIndex:range.location];
    NSString * areaCode = [codeStr stringByReplacingOccurrencesOfString:@"+" withString:@""];
    // 国家
    NSString * countryName = [countryStr substringToIndex:range.location];
    NSString * areaCodeStr = [NSString stringWithFormat:@"%@ +%@", countryName, areaCode];
    cell.textLabel.text = areaCodeStr;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 取出选择的国家和地区码
    NSString * key = [_keys objectAtIndex:indexPath.section];
    NSArray * nameSection = [_names objectForKey:key];
    
    NSString * countryStr = [nameSection objectAtIndex:indexPath.row];
    NSRange range = [countryStr rangeOfString:@"+"];
    NSString * codeStr = [countryStr substringFromIndex:range.location];
    // 地区码
    NSString * areaCode = [codeStr stringByReplacingOccurrencesOfString:@"+" withString:@""];
    // 国家名称
    NSString * countryName = [countryStr substringToIndex:range.location];
    
    // 创建国家对象
    CountryAndAreaCode * country = [[CountryAndAreaCode alloc] init];
    country.countryName = countryName;
    country.areaCode = areaCode;
    
    [self.view endEditing:YES];
    
    // 反向传入country
    if ([self.delegate respondsToSelector:@selector(sendCountryData:)]) {
        [self.delegate sendCountryData:country];
    }
    
    // 返回
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([_keys count] == 0) {
        return nil;
    }
    NSString * key = [_keys objectAtIndex:section];
    if (key == UITableViewIndexSearch) {
        return nil;
    }
    UIView *headerView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, 25.0)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, SCREEN_SIZE.width, 20.0)];
    
    label.backgroundColor = [UIColor colorWithRed:137/255.0 green:154/255.0 blue:168/255.0 alpha:0.8];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = key;
    [headerView addSubview:label];
    
    return headerView;
}

// 必须实现这个方法才能实现header浮动效果 tableView的风格为Plain
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    _isSearching = NO;
    [tableView reloadData];
    
    return indexPath;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSString * key = [_keys objectAtIndex:index];
    if (key == UITableViewIndexSearch) {
        [tableView setContentOffset:CGPointZero animated:NO];
        
        return NSNotFound;
    }else {
        return index;
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString * searchTerm = [searchBar text];
    [self handleSearchWithString:searchTerm];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _isSearching = YES;
    [_tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText length] == 0) {
        [self setupSearch];
        [_tableView reloadData];
        return;
    }
    
    [self handleSearchWithString:searchText];
}

// 搜索
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (_isSearching) {
        return nil;
    }
    
    return self.keys;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _isSearching = NO;
    _searchBar.text = @"";
    
    [self setupSearch];
    [_tableView reloadData];
    
    [searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
