//
//  AppConstants.h
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/14.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#ifndef AppConstants_h
#define AppConstants_h

#import "OfficalLetters.h"

#define API_SERVER_BASE_URL @"http://www.youdianbus.com/ydbus-api/api"

//线路类型
#define SCHOOL @"school" //学校BUS
#define SHUTTLE @"shuttle" //地铁接驳
#define CITY_BUS @"intercity" //城际
#define COMMUTE @"commute" //通勤
#define EVENTS @"events" //活动线路
//车型
#define QUALITY @"quality" //一人一座
#define EXPRESS @"express" //不限座位
//站点类型
#define STATION_TYPE_GETOFF @"off"
#define STATION_TYPE_GETON @"on"

//全局变量
#define myAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]
/*颜色*/
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define MainTitleRGB     RGBCOLOR(27,27,27)   /*主标题*/
#define SubTitleRGB     RGBCOLOR(150,150,150)   /*副标题*/
#define OrangeColorRGB  RGBCOLOR(252,198,1)   /*橘黄色*/
#define OrangePriceRGB  RGBCOLOR(245,192,123) //价钱的橘黄色
#define OrangePriceRGBAlpha  RGBACOLOR(245,192,123,0.4) //价钱的橘黄色
#define MainThemeGreenRGB RGBCOLOR(51,145, 232) //主题蓝色
#define OrangeRedRGB RGBCOLOR(255, 102, 0) //电子站牌橘红色
#define BlueTitleRgb RGBCOLOR(37, 185, 252) //蓝色字体
#define OrangeBtnRgb RGBCOLOR(243, 122,14) //橙色按钮
#define OrderDetatilOrangeRgb RGBCOLOR(241, 158,58) //订单详情橙色
#define startColorRgb RGBCOLOR(112, 188,20) //上车站等绿色
#define endColorRgb RGBCOLOR(255, 93,60) //下车站等红色
#define BLUEROUTELINECOLOR RGBCOLOR(0,160,233)  //地图上蓝色的线路
#define backGroundRgb RGBCOLOR(241,242,243) //背景色
#define refundTicketrGB RGBCOLOR(242,161,39) //退票黄色、订单详情车票未乘坐
#define orderDetatil_ticket_refund RGBCOLOR(158,146,163) //订单详情车票已退、未支付
#define orderDetatil_ticket_complete RGBCOLOR(150,160,168) //订单详情车票已乘坐
#define title_color_cccccc RGBCOLOR(204,204,204) //日历不可选中时的灰色


#define city_color_rgb RGBCOLOR(252,151,0) //城际颜色
#define bus_color_rgb RGBCOLOR(112,188,20) //班车颜色
#define shuttle_color_rgb RGBCOLOR(244,212,37) //接驳颜色
#define events_color_rgb RGBCOLOR(255,93,60) //活动颜色



#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH  [UIScreen mainScreen].bounds.size.height

//以iphone 6  的屏幕宽度为参考，计算出任意屏幕的10像素
#define widhtFor10 10.0 * [UIScreen mainScreen].bounds.size.width / 375
#define heightFor10  10.0 * [UIScreen mainScreen].bounds.size.height / 667
//高度22
#define heightFor22 22.0 * [UIScreen mainScreen].bounds.size.height / 667
//宽度30 和高度30
#define widhtFor30 30.0 * [UIScreen mainScreen].bounds.size.width / 375
#define heightFor30 30.0 * [UIScreen mainScreen].bounds.size.height / 667
//宽度50 和高度50
#define widhtFor50 50.0 * [UIScreen mainScreen].bounds.size.width / 375
#define heightFor50 50.0 * [UIScreen mainScreen].bounds.size.height / 667
//宽度70 和高度70
#define widhtFor70 70.0 * [UIScreen mainScreen].bounds.size.width / 375
#define heightFor70 70.0 * [UIScreen mainScreen].bounds.size.height / 667
//宽度90 和高度90
#define widhtFor90 90.0 * [UIScreen mainScreen].bounds.size.width / 375
#define heightFor90 90.0 * [UIScreen mainScreen].bounds.size.height / 667
//宽度100 和高度100
#define widhtFor100 100.0 * [UIScreen mainScreen].bounds.size.width / 375
#define heightFor100 100.0 * [UIScreen mainScreen].bounds.size.height / 667


//字体适配

#define ISIPHONE6P_FD (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) ? YES : NO)
#define ISIPHONE6P1 (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) ? YES : NO)
#define ISIPHONE6P ((ISIPHONE6P_FD || ISIPHONE6P1) ? YES : NO)
#define ISIPHONE6 (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) ? YES : NO)
#define ISIPHONE5 (CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) ? YES : NO)
#define ISIPHONE4 (CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) ? YES : NO)


//如果是iphone6Plus使用原数字，如果不是iphone6P，则字体缩小1.5倍
//#define kFont(x) (ISIPHONE6P ? [UIFont systemFontOfSize:x] : return [UIFont systemFontOfSize:x/1.5])

//#define kFont(x) [UIFont systemFontOfSize:([UIScreen mainScreen].bounds.size.height / [UIScreen mainScreen].bounds.size.width *x)/ (736.0/414)]
#define adjustFont(x)(x-(0*ISIPHONE6+x*0.02f)-(2*ISIPHONE5+x*0.02f)-(2*ISIPHONE4+x*0.02f))
#define kFont(x) [UIFont systemFontOfSize:adjustFont(x)]

#endif /* AppConstants_h */
