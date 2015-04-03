//
//  BAAddressTableViewCell.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAAddressTableViewCell.h"

@implementation BAAddressTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadModel:(BAAddressModel *)model{
    self.nameLabel.text = model.name;
    self.addressLabel.text = model.address;
    self.telLabel.text = model.tel;
    self.addressModel = model;
}
@end
