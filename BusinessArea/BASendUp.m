//
//  BASendUp.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-5.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BASendUp.h"

@implementation BASendUp
+(NSArray *)sendUpListWithArray:(NSArray *)array{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [list addObject:[[BASendUp alloc] initWithDictionary:dic]];
    }
    return list;
}
-(id)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        self.sendUpId = dic[@"id"];
        self.money = dic[@"money"];
    }
    return self;
}

@end
