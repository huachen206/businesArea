//
//  BAShop_scoTableViewCell.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAShopScoModel.h"

@interface BAShop_scoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

-(void)loadModel:(BAShopScoModel *)model;
@end
