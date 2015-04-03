//
//  BAAddressViewController.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BABasicTableViewController.h"
#import "BAOrderFormTableViewController.h"

@interface BAAddressViewController : BABasicTableViewController
@property (nonatomic,strong) BAOrderFormTableViewController *fromOrderFormVC;
@end
