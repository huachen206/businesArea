//
//  BASignUpTableViewCell.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-9.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BASignUpTableViewCell.h"

@implementation BASignUpTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setContentText:(NSString *)text{
    self.mainTextField.text = text;
}
-(void)setContentPlaceHold:(NSString *)text{
    self.mainTextField.placeholder = text;
}
-(void)setMainTitle:(NSString *)title{
    self.leftTitleLabel.text = title;
}


@end
