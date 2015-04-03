//
//  BACircleModel.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-23.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BACircleModel.h"

@implementation BACircleModel

+(NSArray *)circleListWitharray:(NSArray *)array{
    NSMutableArray *marray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in array) {
        [marray addObject:[[BACircleModel alloc] initWithDic:dic]];
    }
    return marray;
}

-(id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.cityId = dic[@"cityid"];
        self.cityName = dic[@"cityName"];
        self.circleId = dic[@"id"];
        self.name = dic[@"name"];
    }
    return self;
}

@end
