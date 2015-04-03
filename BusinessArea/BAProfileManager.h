//
//  BAProfileManager.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-20.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BACircleModel.h"
#import "BAShopType.h"
#import "BASendUp.h"
@interface BAProfileManager : NSObject
@property (nonatomic,strong) NSArray *circleList;
@property (nonatomic,strong) NSArray *circleList_n;
@property (nonatomic,strong) NSArray *shop_types;
@property (nonatomic,strong) NSArray *sendUps;
+ (instancetype)shared;
-(void)insertCityToDb;
-(NSArray *)hotCities;
-(NSArray *)allCities;
@end
