//
//  BAGoodDetailViewController.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-6.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BABasicViewController.h"
#import "BAGoodModel.h"
#import "BAShopModel.h"
@interface BAGoodDetailViewController : BABasicViewController
@property (nonatomic,strong) BAGoodModel *thisGoodModel;
@property (nonatomic,strong) BAShopModel *thisShopModel;

@end
