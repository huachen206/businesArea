//
//  BAGoodModel.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-6.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
/*
 barcode = 9787122168887;
 des = "";
 "dis_price" = "1.00";
 distance = 0;
 "general_sco" = 1;
 id = 68;
 lat = 0;
 lng = 0;
 name = "aa\U770b\U770b\U96f7\U8499\U78e8\U7802\U7cd6";
 picture = "6887a1f0u.png";
 price = "1.00";
 "shop_sco" = 2;
 sid = 5;
 stock = 1;
 type = 0;
 uname = test1;
 */
@interface BAGoodModel :JSONModel<NSCoding>
@property (nonatomic,strong) NSString *barcode;
@property (nonatomic,strong) NSString *des;
@property (nonatomic,strong) NSString *dis_price;
@property (nonatomic,strong) NSString *distance;
@property (nonatomic,strong) NSString *general_sco;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *lat;
@property (nonatomic,strong) NSString *lng;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *picture;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *shop_sco;
@property (nonatomic,strong) NSString *sid;
@property (nonatomic,strong) NSString *stock;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *uname;

@property (nonatomic,strong) NSString <Optional>*num;
@end
