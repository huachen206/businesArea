//
//  BAGoodTableViewCell.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-6.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAGoodTableViewCell.h"
#import "UIImageView+WebCache.h"

#define DetailModelSize  CGSizeMake(320, 148)


@implementation BAGoodTableViewCell
-(void)loadModel:(BAGoodModel*)goodModel{
    NSString *urlString = [NSString stringWithFormat:@"%@/dev_business_user/index.php?c=util&m=download&d=util&file=%@",baseUrl,goodModel.picture];

    [self.imageview_logo sd_setImageWithURL:[NSURL URLWithString:urlString]];
    self.label_uname.text = goodModel.uname;
    self.label_distance.text = [NSString stringWithFormat:@"距离:%@米",goodModel.distance];
    self.label_name.text = goodModel.name;
    self.label_price.text = goodModel.price;
    self.label_des.text = goodModel.des;
    self.textfield_number.text = goodModel.num;
    self.goodModel = goodModel;
}
-(void)openDetailMode{
}
- (IBAction)add:(id)sender {
    self.goodModel.num = [NSString stringWithFormat:@"%d",[self.goodModel.num intValue]+1];
    self.textfield_number.text = self.goodModel.num;
}
- (IBAction)sub:(id)sender {
    self.goodModel.num = [NSString stringWithFormat:@"%d",[self.goodModel.num intValue]-1];
    self.textfield_number.text = self.goodModel.num;

}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
