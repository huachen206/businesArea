//
//  BAShopModel.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-5.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 address = "\U6c88\U9633\U5e02\U94c1\U897f\U533a\U5317\U4e8c\U8def\U91d1\U660a\U5927\U53a6";
 "cir_id" = 1;
 cname = "\U5927\U5b66\U57ce1";
 distance = 0;
 etime = 0;
 lat = 0;
 lng = 0;
 money = "\U65e0\U914d\U9001\U4ef7";
 note = "";
 portrait = "7c26effcu.jpg";
 "send_id" = 1;
 sid = 4;
 sname = "\U4fbf\U5229\U5e97";
 status = 2;
 stime = 0;
 tel = 13478104186;
 type = 1;
 uname = test1;

 */
@interface BAShopModel : NSObject
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *cir_id;
@property (nonatomic,strong) NSString *cname;
@property (nonatomic,strong) NSString *distance;
@property (nonatomic,strong) NSString *etime;
@property (nonatomic,strong) NSString *lat;
@property (nonatomic,strong) NSString *lng;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *note;
@property (nonatomic,strong) NSString *portrait;
@property (nonatomic,strong) NSString *send_id;
@property (nonatomic,strong) NSString *sid;
@property (nonatomic,strong) NSString *sname;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *stime;
@property (nonatomic,strong) NSString *tel;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *uname;

+(NSArray *)shopModelsWithArray:(NSArray *)array;

-(id)initWithDictionary:(NSDictionary *)dic;

@end
