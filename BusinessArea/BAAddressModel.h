//
//  BAAddressModel.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "JSONModel.h"
/*
 {
 address = 4324234242;
 id = 10;
 name = "\U5927\U5927\U7684";
 tel = 13898189131;
 uid = 1;
 ustatus = 0;
 }

 */
@interface BAAddressModel : JSONModel
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *tel;
@property (nonatomic,strong) NSString *uid;
@property (nonatomic,strong) NSString *ustatus;


+(NSArray *)addressesWithArray:(NSArray *)array;
@end
