//
//  BAAddressTableViewCell.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAAddressModel.h"
@interface BAAddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;

@property (nonatomic,strong) BAAddressModel *addressModel;

-(void)loadModel:(BAAddressModel *)model;
@end
