//
//  BAOrderModel.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-20.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "JSONModel.h"
/*
 {
 amount = 1;
 cid = 7;
 des = "";
 "dis_price" = "0.951";
 "general_sco" = 3;
 id = 9;
 name = "\U817e\U8bafQQ\U534e\U590f\U6309\U5143\U5145\U503c";
 oid = 9;
 "picture\U00a0" = "";
 price = "1.000";
 "shop_sco" = 0;
 sid = "-1";
 }

 */
@protocol BAOrderDetailModel
@end

@interface BAOrderDetailModel : JSONModel
@property (nonatomic,strong) NSString *amount;
@property (nonatomic,strong) NSString *cid;
@property (nonatomic,strong) NSString *des;
@property (nonatomic,strong) NSString *dis_price;
@property (nonatomic,strong) NSString *general_sco;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *oid;
@property (nonatomic,strong) NSString<Optional>*picture;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *shop_sco;
@property (nonatomic,strong) NSString *sid;
@end
/*
 {
 address = "\U6c88\U9633\U5e02\U94c1\U897f\U533a\U5317\U4e8c\U8def\U91d1\U660a\U5927\U53a64-7";
 buy = 1;
 cancelorder = 0;
 id = 1;
 ins = 1405095063;
 operation = 0;
 "order_no" = 14050950630471000001;
 otype = 1;
 pid = 2;
 portrait = "f57399d2u.png";
 showstatus = "\U9000\U5355\U786e\U8ba4";
 sid = 2;
 status = 11;
 tel = 13478104186;
 "total_dis_price" = "12.00";
 "total_price" = "12.00";
 type = 2;
 uname = "\U674e\U5e7f\U9f99";
 }
 */
@interface BAOrderOverViewModel : JSONModel
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *buy;
@property (nonatomic,strong) NSString *cancelorder;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *ins;
@property (nonatomic,strong) NSString *operation;
@property (nonatomic,strong) NSString *order_no;
@property (nonatomic,strong) NSString *otype;
@property (nonatomic,strong) NSString *pid;
@property (nonatomic,strong) NSString *portrait;
@property (nonatomic,strong) NSString *showstatus;
@property (nonatomic,strong) NSString *sid;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *tel;
@property (nonatomic,strong) NSString *total_dis_price;
@property (nonatomic,strong) NSString *total_price;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *uname;
@end


@interface BAOrderModel : JSONModel
@property (nonatomic,strong) NSArray <BAOrderDetailModel> *orders_detail;
@property (nonatomic,strong) BAOrderOverViewModel *orders;

+(NSArray *)ordersWithArray:(NSArray*)array;
@end
