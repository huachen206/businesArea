//
//  BAActiveModel.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-9.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAActiveModel.h"

@implementation BAActiveModel
+(NSArray *)activeListWithDic:(NSDictionary *)dic{
    NSMutableArray *list = [NSMutableArray array];
    NSArray *array = dic[@"activities"];
    for (NSDictionary *tmpDic in array) {
        BAActiveModel *model = [[BAActiveModel alloc] initWithDictionary:tmpDic error:nil];
        [list addObject:model];
    }
    return list;
}

@end
