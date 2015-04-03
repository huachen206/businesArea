//
//  BAMePortraitTableViewCell.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAMePortraitTableViewCell.h"

@implementation BAMePortraitTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.portraitImageView.layer.masksToBounds = YES;
    self.portraitImageView.layer.cornerRadius = self.portraitImageView.height/2;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
