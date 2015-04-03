//
//  BAShopType.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-5.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAShopType : NSObject
@property(nonatomic,strong) NSString *typeId;
@property(nonatomic,strong) NSString *name;
+(NSArray *)shopTypeListWithArray:(NSArray *)array;
-(id)initWithDictionary:(NSDictionary *)dic;

@end
