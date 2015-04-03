//
//  BAGoodViewController.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-6.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BABasicViewController.h"
#import "BAShopModel.h"
@interface BAGoodViewController : BABasicViewController
@property (nonatomic,strong) NSArray *goods;
@property (nonatomic,strong) BAShopModel *thisShopModel;
@end
