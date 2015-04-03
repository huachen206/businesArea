//
//  BAOrderDetailGoodTableViewCell.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-20.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAOrderDetailGoodTableViewCell.h"

@implementation BAOrderDetailGoodTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadWithDetailModel:(BAOrderDetailModel *)model{
    NSString *urlString = [NSString stringWithFormat:@"%@/dev_business_user/index.php?c=util&m=download&d=util&file=%@",baseUrl,model.picture];
    [self.overImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    self.nameLabel.text = model.name;
    self.moneyLabel.text = model.price;
    self.numberLabel.text = [NSString stringWithFormat:@"%@份",model.amount];
    self.detailModel = model;
}

@end
