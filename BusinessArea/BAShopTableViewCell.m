//
//  BAShopTableViewCell.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-6.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAShopTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation BAShopTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)loadWithShopModel:(BAShopModel *)shopmodel{
    self.title.text = shopmodel.uname;
    self.address.text = shopmodel.address;
    self.slogan.text = shopmodel.note;
    self.distance.text = shopmodel.distance;
    NSString *urlString = [NSString stringWithFormat:@"%@/dev_business_user/index.php?c=util&m=download&d=util&file=%@",baseUrl,shopmodel.portrait];
    [self.mainImage sd_setImageWithURL:[NSURL URLWithString:urlString]];

}

@end
