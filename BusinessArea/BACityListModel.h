//
//  BACityListModel.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-30.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "SQLBaseModel.h"

@interface BACityListModel : SQLBaseModel
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *adcode;
@property (nonatomic,strong) NSString *initials;
@property (nonatomic,strong) NSString *big_initials;

@end
