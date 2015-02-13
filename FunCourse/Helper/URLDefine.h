//
//  URLDefine.h
//  FunCourse
//
//  Created by 寒竹子 on 15/2/11.
//  Copyright (c) 2015年 XuRan. All rights reserved.
//  子曰接口定义

#ifndef FunCourse_URLDefine_h
#define FunCourse_URLDefine_h

// 注册接口
#define FunRegister_URL @"http://192.168.0.88:8080/funcourseD/Registration?u_phone=%@&u_password=%@"

// 登录接口
#define FunLogin_URL    @"http://192.168.0.88:8080/funcourseD/Login?u_phone=%@&u_password=%@"


// 首页数据接口

// 教线上列表 onlineURL
#define FunTOnlineList_URL  @"http://192.168.0.88:8080/funcourseD/LoadTCourseOnlineListCardData?per_page=%d&t_changetime=%ld"
// 教线上详情 detailURL
#define FunTOnlineDetail_URL @"http://192.168.0.88:8080/funcourseD/LoadTCourseOnlineDetailData?t_course_id=%d"

// 教线下列表 offlineURL
#define FunTOfflineList_URL @""

// 学线上列表 onlineURL
#define FunLOnlineList_URL  @""
// 学线下列表 offlineURL
#define FunLOfflineList_URL  @"http://192.168.0.88:8080/funcourseD/LoadLCourseOfflineListCardData?per_page=%d&t_changetime=%ld&t_user_x=0&t_user_y=0"

#endif
