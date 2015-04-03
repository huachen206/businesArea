//
//  BAUserInfo.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-21.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ENUM(NSInteger, UserStoreStatus){
    UserStoreStatus_banned = 0,
    UserStoreStatus_sure = 1
};


@interface BAUserInfo : NSObject
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,strong) NSString *portrait;
@property (nonatomic,strong) NSString *phoneNumber;
@property (nonatomic,assign) enum UserStoreStatus storeStatus;//店铺状态0：封号，1：正常

-(id)initWithDic:(NSDictionary *)dic;
@end
