//
//  BACircleModel.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-23.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BACircleModel : NSObject

@property (nonatomic,strong) NSString *cityId;
@property (nonatomic,strong) NSString *cityName;
@property (nonatomic,strong) NSString *circleId;
@property (nonatomic,strong) NSString *name;


+(NSArray *)circleListWitharray:(NSArray *)array;

-(id)initWithDic:(NSDictionary *)dic;
@end
