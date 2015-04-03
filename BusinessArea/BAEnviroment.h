//
//  BAEnviroment.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-17.
//  Copyright (c) 2014年 花晨. All rights reserved.
//
#import "HCUtilityMacro.h"
#import "HCUtilityFuc.h"
#import "CommonCategory.h"
#import <libextobjc/EXTScope.h>
#import <SIAlertView/SIAlertView.h>
#import "BARequestApi.h"
#import "HCHTTPRequest.h"
#import "HCBaseDAO.h"
#import "HCDiskCache.h"
#import "PAUserDiskCache.h"
#import <BlocksKit/BlocksKit.h>
#import <BlocksKit/BlocksKit+UIKit.h>
#import "ViewUtils.h"
#import "BAImageDownLoad.h"
#import "BAUserInfoManager.h"
#import "TSMessage.h"
#import "UIImageView+WebCache.h"

#define baseUrl @"http://115.28.59.82"
#define prifileUrl [baseUrl stringByAppendingString:@"/dev_business_user/index.php?c=util&m=config&d=util"]

typedef NS_ENUM(NSInteger, PAAlertType) {
    PAAlertTypeInfo = 0,
    PAAlertTypeWarning,
    PAAlertTypeError,
    PAAlertTypeSuccess
};

#define defaultAlert(TITLE, SUBTITLE, TYPE)  \
[TSMessage showNotificationWithTitle:TITLE subtitle:SUBTITLE type:(TSMessageNotificationType)TYPE]

#define alertForPassport(TITLE, SUBTITLE, TYPE) \
[TSMessage showNotificationInViewController:R.navigationController title:TITLE subtitle:SUBTITLE type:(TSMessageNotificationType) TYPE];

//[TSMessage showNotificationInViewController:R.passportNavigationController title:TITLE subtitle:SUBTITLE type:(TSMessageNotificationType) TYPE];

#define alertInViewController(TITLE, SUBTITLE, TYPE) \
[TSMessage showNotificationInViewController:self title:TITLE subtitle:SUBTITLE type:(TSMessageNotificationType) TYPE];


#define HSKEY  @"3ssjawzpwmzexu4t"
#define AUTHKEY @"gx88b7zq5q6kcj2l"

#define CODE @"c903eed9dd1a0bd6"


#pragma mark HCDiskCaheKEY
#define KEY_CITYCHOOSEDNAME @"cityChoosedName"
#define KEY_CITYName @"cityChoosedName"
#define KEY_CITYJsonVercity @"citysVercity"



#pragma mark picture name
#define pBackArrowImageName_new @"back_black"

#pragma mark colors
#define kBarRightButtonTitleColor_new UIColorFromRGB(0x1d1d1d)
#define kLinkButtonTextColor UIColorFromRGB(0x2581c2)//linkButton文字颜色

#pragma mark HUDTITLE
#define k_loading_HUD                    @"努力加载中..."

//#ifndef BusinessArea_BAEnviroment_h
//#define BusinessArea_BAEnviroment_h
//
//
//
//#endif
