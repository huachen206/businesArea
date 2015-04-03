//
//  BAGoodModel.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-6.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAGoodModel.h"
#import "objc/runtime.h"

@implementation BAGoodModel
-(id)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err{
    self = [super initWithDictionary:dict error:err];
    if (self) {
        self.num = @"1";
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        for (NSString *property in [[self class] properties]) {
            [self setValue:[aDecoder decodeObjectForKey:property] forKey:property];
        }
        
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    for (NSString *property in [[self class] properties]) {
        [aCoder encodeObject:[self valueForKey:property] forKey:property];
    }
}


- (NSDictionary *)properties_aps
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
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
