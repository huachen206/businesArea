//
//  BAShopModel.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-5.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAShopModel.h"
#import "objc/runtime.h"

@implementation BAShopModel

+(NSArray *)shopModelsWithArray:(NSArray *)array{
    NSMutableArray *shopmodels = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        [shopmodels addObject:[[BAShopModel alloc] initWithDictionary:dic]];
    }
    return shopmodels;
}

-(id)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        NSArray *pros = [self.class properties];
        for (NSString *key in pros) {
            id value =dic[key];
            if ([value isKindOfClass:[NSNumber class]]) {
                value = [value stringValue];
            }
            [self setValue:value forKey:key];
        }
    }
    return self;
}


+ (NSArray *)properties
{
    NSMutableArray *props = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [props addObject:propertyName];
    }
    free(properties);
    return props;
}

@end
