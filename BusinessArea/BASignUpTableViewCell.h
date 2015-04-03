//
//  BASignUpTableViewCell.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-9.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BASignUpTableViewCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UILabel *leftTitleLabel;
@property (nonatomic,weak) IBOutlet UITextField *mainTextField;


-(void)setContentText:(NSString *)text;
-(void)setContentPlaceHold:(NSString *)text;
-(void)setMainTitle:(NSString *)title;

@end
