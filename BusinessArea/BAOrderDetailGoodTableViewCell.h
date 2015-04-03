//
//  BAOrderDetailGoodTableViewCell.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-20.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAOrderModel.h"
@interface BAOrderDetailGoodTableViewCell : UITableViewCell
@property (nonatomic,strong) BAOrderDetailModel *detailModel;
@property (weak, nonatomic) IBOutlet UIImageView *overImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
-(void)loadWithDetailModel:(BAOrderDetailModel *)model;
@end
