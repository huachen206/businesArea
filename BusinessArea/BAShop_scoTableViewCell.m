//
//  BAShop_scoTableViewCell.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAShop_scoTableViewCell.h"

@implementation BAShop_scoTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadModel:(BAShopScoModel *)model{
    NSString *urlString = [NSString stringWithFormat:@"%@/dev_business_user/index.php?c=util&m=download&d=util&file=%@",baseUrl,model.portrait];
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
    self.mainTitleLabel.text = model.uname;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@积分",model.shop_sco];
}

@end
