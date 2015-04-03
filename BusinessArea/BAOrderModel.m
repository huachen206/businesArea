//
//  BAOrderModel.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-20.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAOrderModel.h"
@implementation BAOrderDetailModel


@end

@implementation BAOrderOverViewModel
@end

@implementation BAOrderModel
+(NSArray *)ordersWithArray:(NSArray*)array{
    NSMutableArray *results = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [results addObject:[[[self class] alloc] initWithDictionary:dic error:nil]];
    }
    return results;
}
@end
