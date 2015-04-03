//
//  BAOrderPayTypeTableViewCell.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-19.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"

@interface BAOrderPayTypeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet QCheckBox *selectButton;

@end
