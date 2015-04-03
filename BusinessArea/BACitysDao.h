//
//  BACitysDao.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-30.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "HCBaseDAO.h"
#import "BACityListModel.h"
@interface BACitysDao : HCBaseDAO

-(NSArray *)hotCities;
-(NSArray *)cityList;

@end
