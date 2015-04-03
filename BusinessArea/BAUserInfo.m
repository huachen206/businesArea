//
//  BAUserInfo.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-21.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAUserInfo.h"

@implementation BAUserInfo
/*
 "id":12345  ，              	  				//用户id
 "token":"dO9RbDTjpLx/SJdepizFBz4775IHq8bZm95upBnl3QY="  //token（登录的情况返回）
 "name":"xxxxx"  ，							//用户名
 "uname":"xxxxx"  ，     					            //用户昵称
 "portrait":"0e5a0711fd8844b5c"  ，   						//用户头像          "status " =1，
 */
-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        _userId = dic[@"uid"];
        _userName = dic[@"name"];
        _nickName = dic[@"uname"];
        _portrait = dic[@"portrait"];
        
        NSString *status = dic[@"status"];
        _storeStatus = [status integerValue];
    }
    return self;
}

@end
