//
//  BAAddressModel.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAAddressModel.h"

@implementation BAAddressModel
+(NSArray *)addressesWithArray:(NSArray *)array{
    NSMutableArray *addes = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        BAAddressModel *model = [[BAAddressModel alloc] initWithDictionary:dic error:nil];
        [addes addObject:model];
    }
    return addes;
}

@end
