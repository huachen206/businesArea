//
//  BAUserInfoManager.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-21.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BAUserInfo.h"
#import "BAGoodModel.h"
@interface BAUserInfoManager : NSObject
@property (nonatomic,strong) NSString *authToken;
@property (nonatomic,strong) BAUserInfo *userInfo;
@property (nonatomic,strong) NSMutableArray *shoppingCartList;

@property (nonatomic,strong) NSMutableArray *shopsForGoodsList;

+(instancetype)share;

-(void)addShopingCartWithGoodModel:(BAGoodModel *)goodModel;

-(void)removeShopingCartWithGoodModel:(BAGoodModel *)goodModel;
-(NSMutableArray *)shopsForGoodsList;

@end
