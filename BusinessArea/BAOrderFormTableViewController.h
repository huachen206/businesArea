//
//  BAOrderFormTableViewController.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BABasicTableViewController.h"
@class BAAddressModel;

@interface BAOrderFormTableViewController : BABasicTableViewController
-(void)setAddress:(BAAddressModel *)addressModel;

@end
