//
//  AddFriendViewController.m
//  FunCourse
//
//  Created by 寒竹子 on 14/12/25.
//  Copyright (c) 2014年 XuRan. All rights reserved.
//  添加好友

#define kBorder 10

#import "AddFriendViewController.h"
#import "AddFriendCell.h"
#import "NSString+Helper.h"
#import "ApplyEntity.h"
#import "EMSearchBar.h"
#import "ApplyViewController.h"

@interface AddFriendViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, addFriendCellDetegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) EMSearchBar * searchBar;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSIndexPath * selectedIndexPath;

@end

@implementation AddFriendViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 *  初始化搜索条
 */
- (void)setupSearchBar
{
    _searchBar = [[EMSearchBar alloc] initWithFrame:CGRectMake(kBorder, kBorder, SCREEN_SIZE.width - kBorder * 2, 44)];
    _searchBar.barStyle = UIBarStyleDefault;
    _searchBar.keyboardType = UIKeyboardTypeNumberPad;
    _searchBar.placeholder = @"请输入您要查找的账号";
    _searchBar.delegate = self;
}

/**
 *  初始化tableView
 */
- (void)setupTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - 44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.tableHeaderView = _searchBar;
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 70, 0, 0)];
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 70, 0, 0)];
    }
    [self.view addSubview:_tableView];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_searchBar resignFirstResponder];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    titleView.text = @"添加好友";
    titleView.textColor = [UIColor whiteColor];
    titleView.font = [UIFont systemFontOfSize:18];
    titleView.textAlignment = NSTextAlignmentCenter;
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIButton * searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchFriend) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    [self addNavigationWithTitle:nil leftItem:backItem rightItem:searchItem titleView:titleView];
}

/**
 *  返回
 */
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  搜索好友
 */
- (void)searchFriend
{
    [self.searchBar resignFirstResponder];
    NSString * searchName = self.searchBar.text;
    
    if (searchName.length == 0) {
        URBAlertView * alertView = [[URBAlertView alloc] initWithTitle:@"提示" subtitle:@"好友账号不能为空"];
        [alertView addButtonWithTitle:@"确定"];
        [alertView showWithAnimation:URBAlertAnimationTumble];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
        return;
    }else {
        // 判断用户是否输入了除了数字之外的字符
        BOOL isValid = [self validateNumberic:searchName];
#warning 此处要加上 searchName.length < 11
        if (isValid) {
            URBAlertView * alertView = [URBAlertView dialogWithTitle:@"请输入合法的好友账号" subtitle:nil];
            [alertView addButtonWithTitle:@"确定"];
            [alertView showWithAnimation:URBAlertAnimationTumble];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                [alertView hideWithAnimation:URBAlertAnimationTumble];
            }];
            return;
        }
        
#warning 从自己服务器搜索好友
        
        NSDictionary * loginInfo = [[EaseMob sharedInstance].chatManager loginInfo];
        NSString * userName = [loginInfo objectForKey:kSDKUsername];
        if ([searchName isEqualToString:userName]) {
            URBAlertView * alertView = [[URBAlertView alloc] initWithTitle:@"提示" subtitle:@"不能添加自己为好友"];
            [alertView addButtonWithTitle:@"确定"];
            [alertView showWithAnimation:URBAlertAnimationTumble];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                [alertView hideWithAnimation:URBAlertAnimationTumble];
            }];
            
            return;
        }
    }
    
    // 判断对方是否已经发来了申请
    NSArray * applyArray = [[ApplyViewController shareController] dataSource];
    if (applyArray && [applyArray count] > 0) {
        for (ApplyEntity * entity in applyArray) {
            ApplyStyle style = [entity.style intValue];
            BOOL isGroup = style == ApplyStyleFriend? NO : YES;
            if (!isGroup && [entity.applicantUsername isEqualToString:searchName]) {
                NSString * message = [NSString stringWithFormat:@"'%@'已经向您发来了好友申请", searchName];
                
                URBAlertView * alertView = [[URBAlertView alloc] initWithTitle:@"提示" subtitle:message];
                [alertView addButtonWithTitle:@"确定"];
                [alertView showWithAnimation:URBAlertAnimationTumble];
                [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                    [alertView hideWithAnimation:URBAlertAnimationTumble];
                }];
                return;
            }
        }
    }
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObject:searchName];
    [self.tableView reloadData];
}

- (BOOL)validateNumberic:(NSString *)numberStr
{
    NSCharacterSet * charSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSRange range = [numberStr rangeOfCharacterFromSet:charSet];
    
    return (range.location == NSNotFound) ? NO : YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearchBar];
    [self setupUI];
    [self setupTableView];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    NSString * searchName = self.searchBar.text;
    
    if (searchName.length == 0) {
        URBAlertView * alertView = [[URBAlertView alloc] initWithTitle:@"提示" subtitle:@"好友账号不能为空"];
        [alertView addButtonWithTitle:@"确定"];
        [alertView showWithAnimation:URBAlertAnimationTumble];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
    }else {
        // 判断用户是否输入了除了数字之外的字符
        BOOL isValid = [self validateNumberic:searchName];
#warning 测试中，此处要加上 searchName.length < 11
        if (isValid) {
            URBAlertView * alertView = [URBAlertView dialogWithTitle:@"请输入合法的好友账号" subtitle:nil];
            [alertView addButtonWithTitle:@"确定"];
            [alertView showWithAnimation:URBAlertAnimationTumble];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                [alertView hideWithAnimation:URBAlertAnimationTumble];
            }];
            return;
        }
        
#warning 从自己服务器搜索好友
        
        NSDictionary * loginInfo = [[EaseMob sharedInstance].chatManager loginInfo];
        NSString * userName = [loginInfo objectForKey:kSDKUsername];
        if ([searchName isEqualToString:userName]) {
            URBAlertView * alertView = [[URBAlertView alloc] initWithTitle:@"提示" subtitle:@"不能添加自己为好友"];
            [alertView addButtonWithTitle:@"确定"];
            [alertView showWithAnimation:URBAlertAnimationTumble];
            [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                [alertView hideWithAnimation:URBAlertAnimationTumble];
            }];
            return;
        }
    }
    
    // 判断对方是否已经发来了申请
    NSArray * applyArray = [[ApplyViewController shareController] dataSource];
    if (applyArray && [applyArray count] > 0) {
        for (ApplyEntity * entity in applyArray) {
            ApplyStyle style = [entity.style intValue];
            BOOL isGroup = style == ApplyStyleFriend? NO : YES;
            if (!isGroup && [entity.applicantUsername isEqualToString:searchName]) {
                NSString * message = [NSString stringWithFormat:@"'%@'已经向您发来了好友申请", searchName];
                
                URBAlertView * alertView = [[URBAlertView alloc] initWithTitle:@"提示" subtitle:message];
                [alertView addButtonWithTitle:@"确定"];
                [alertView showWithAnimation:URBAlertAnimationTumble];
                [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
                    [alertView hideWithAnimation:URBAlertAnimationTumble];
                }];
                return;
            }
        }
    }
    
    [self.dataArray removeAllObjects];
    [self.dataArray addObject:searchName];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 70, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 70, 0, 0)];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddFriendCell * cell = [AddFriendCell cellWithTableView:tableView];
    cell.delegate = self; // 设置代理
    // 传递indexPath
    cell.indexPath = indexPath;
    
    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/pic/item/08f790529822720e0625e5fd78cb0a46f31fabc9.jpg"] placeholderImage:[UIImage imageNamed:@"11-085132_876"]];
    NSString * name = self.dataArray[indexPath.row];
    cell.nameLabel.text = name;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

// 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/**
 *  判断是否已经发送了申请
 */
- (BOOL)readlySendBuddyRequest:(NSString *)buddyName
{
    NSArray * buddyList = [[EaseMob sharedInstance].chatManager buddyList];
    for (EMBuddy * buddy in buddyList) {
        if ([buddy.username isEqualToString:buddyName] && buddy.followState == eEMBuddyFollowState_NotFollowed && buddy.isPendingApproval) {
            return YES;
        }
    }
    
    return NO;
}

/**
 *  双方是否已经是好友
 */
- (BOOL)didBuddyExist:(NSString *)buddyName
{
    NSArray * buddyList = [[EaseMob sharedInstance].chatManager buddyList];
    for (EMBuddy * buddy in buddyList) {
        if ([buddy.username isEqualToString:buddyName] && buddy.followState != eEMBuddyFollowState_NotFollowed) {
            // 是好友
            return YES;
        }
    }
    
    return NO;
}

/**
 *  发送验证消息
 */
- (void)showMessageAlert
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"验证信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    
    [alert show];
}

#pragma mark - UIAlertVieDelegate

/**
 *  发送申请
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 点击了确定
    if (alertView.cancelButtonIndex != buttonIndex) {
        // 取出要验证的消息
        UITextField *  messageTextFeild = [alertView textFieldAtIndex:0];
        NSString * securryStr = messageTextFeild.text;
        NSString * message = nil; // 消息
        NSDictionary * loginInfo = [[EaseMob sharedInstance].chatManager loginInfo];
        NSString * loginName = [loginInfo objectForKey:kSDKUsername];
        if (![securryStr isEmptyString]) {
            message = [NSString stringWithFormat:@"%@: %@", loginName, securryStr];
        }else {
            message = [NSString stringWithFormat:@"%@ 邀请您为好友", loginName];
        }
        // 发送好友申请
        [self sendFriendApplyAtIndexPath:self.selectedIndexPath message:message];
    }
}

/**
 *  Action  发送好友请求
 */
- (void)sendFriendApplyAtIndexPath:(NSIndexPath *)indexPath message:(NSString *)message
{
    // 取出name
    NSString * buddyName = [self.dataArray objectAtIndex:indexPath.row];
    if (![buddyName isEmptyString]) {
        [self showHudInView:self.view hint:@"正在发送申请..."];
        EMError * error  = nil;
        // 向环信发送好友申请
        [[EaseMob sharedInstance].chatManager addBuddy:buddyName message:message error:&error];
        [self hideHud];
        
        if (error) {
            [self showHint:@"发送申请失败, 请稍后重试"];
        }else {
            [self showHint:@"发送申请成功!"];
            // 返回上一个页面
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

/**
 *  添加好友
 */
- (void)addButtonClickWithIndex:(NSIndexPath *)indexPath
{
    // 选中的索引
    self.selectedIndexPath = indexPath;
    
    NSString * buddyName = [self.dataArray objectAtIndex:indexPath.row];
    // 判断是否已经是好友
    if ([self didBuddyExist:buddyName]) {
        NSString * message = [NSString stringWithFormat:@"'%@' 已经是您的好友了", buddyName];
        URBAlertView * alertView = [[URBAlertView alloc] initWithTitle:message subtitle:nil];
        [alertView addButtonWithTitle:@"确定"];
        [alertView showWithAnimation:URBAlertAnimationTumble];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
    }else if ([self readlySendBuddyRequest:buddyName]) {
        NSString * message = [NSString stringWithFormat:@"您已经向'%@'发送好友申请了!", buddyName];
        URBAlertView * alertView = [[URBAlertView alloc] initWithTitle:message subtitle:nil];
        [alertView addButtonWithTitle:@"确定"];
        [alertView showWithAnimation:URBAlertAnimationTumble];
        [alertView setHandlerBlock:^(NSInteger buttonIndex, URBAlertView *alertView) {
            [alertView hideWithAnimation:URBAlertAnimationTumble];
        }];
    }else {
        [self showMessageAlert]; // 发送验证申请
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
