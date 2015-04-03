//
//  BAShopType.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-5.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAShopType.h"

@implementation BAShopType
+(NSArray *)shopTypeListWithArray:(NSArray *)array{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [list addObject:[[BAShopType alloc] initWithDictionary:dic]];
    }
    return list;
}
-(id)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        self.typeId = dic[@"id"];
        self.name = dic[@"name"];
    }
    return self;
}


@end
