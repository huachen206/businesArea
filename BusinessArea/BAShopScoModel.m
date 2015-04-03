//
//  BAShopScoModel.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAShopScoModel.h"

@implementation BAShopScoModel
+(NSArray *)shop_scoWithArray:(NSArray *)array{
    NSMutableArray *scolist = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        BAShopScoModel *model = [[BAShopScoModel alloc] initWithDictionary:dic error:nil];
        [scolist addObject:model];
    }
    return scolist;
}
@end
