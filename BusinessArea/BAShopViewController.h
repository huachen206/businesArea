//
//  BAShopViewController.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-6.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BABasicViewController.h"
#import "BAShopModel.h"
#import "BAShopTableViewCell.h"
@interface BAShopViewController : BABasicViewController
@property (nonatomic,weak) IBOutlet UITableView *myTableView;
@property (nonatomic,strong) NSArray *shops;
@end
