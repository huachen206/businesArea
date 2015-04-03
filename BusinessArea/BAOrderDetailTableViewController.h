//
//  BAOrderDetailTableViewController.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-20.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BABasicTableViewController.h"
#import "BAOrderModel.h"

@interface BAOrderDetailTableViewController : BABasicTableViewController
@property (nonatomic,strong) BAOrderModel *orderModel;
@end
