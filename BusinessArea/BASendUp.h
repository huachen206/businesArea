//
//  BASendUp.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-5.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BASendUp : NSObject
@property (nonatomic,strong) NSString *sendUpId;
@property (nonatomic,strong) NSString *money;

+(NSArray *)sendUpListWithArray:(NSArray *)array;
-(id)initWithDictionary:(NSDictionary *)dic;

@end
