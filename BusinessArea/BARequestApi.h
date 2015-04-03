//
//  BARequestApi.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-21.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "HCRequestBaseApi.h"

#define BaseUrlFormat @"%@/%@/index.php?c=%@&m=%@&d=%@"
//#define BaseUrlFormat @"%@/%@/index.php?"

#define METHOD_login @"login"
#define METHOD_register @"register"
#define METHOD_getsms @"getsms"
#define METHOD_searchad @"searchad"
#define METHOD_searchshop @"searchshop"
#define METHOD_searchcommodity @"searchcommodity"
#define METHOD_searchshopdetail @"searchshopdetail"
#define METHOD_searchcommoditydetail @"searchcommoditydetail"
#define METHOD_getsms @"getsms"
#define METHOD_getsmsbybackpassword @"getsmsbybackpassword"
#define METHOD_getbackpassword @"getbackpassword"
#define METHOD_searchactivities @"searchactivities"
#define METHOD_signup @"signup"
#define METHOD_mysco @"mysco"
#define METHOD_upload @"upload"
#define METHOD_searchaddress @"searchaddress"
#define METHOD_updaddress @"updaddress"
#define METHOD_saveaddress @"saveaddress"
#define METHOD_deladdress @"deladdress"
#define METHOD_searchuseaddress @"searchuseaddress"
#define METHOD_submitorders @"submitorders"
#define METHOD_searchorders @"searchorders"


#define METHOD_cancelorder @"cancelorder"
#define METHOD_returnorder @"returnorder"
#define METHOD_confirmreceipt @"confirmreceipt"
#define METHOD_confirmsinglestep @"confirmsinglestep"









extern NSString * const Business_user;


extern NSString * const C_USER;
extern NSString * const D_USER;





@interface BARequestApi : HCRequestBaseApi
@property (nonatomic,strong) NSString *method;
@property (nonatomic,strong) NSString *someC;
@property (nonatomic,strong) NSString *someD;
@property (nonatomic,strong) NSString *portal;

-(id)initWithMethod:(NSString *)method;

@end
