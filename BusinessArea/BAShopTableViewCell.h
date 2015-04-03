//
//  BAShopTableViewCell.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-6.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAShopModel.h"
@interface BAShopTableViewCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UILabel *title;
@property (nonatomic,weak) IBOutlet UILabel *slogan;
@property (nonatomic,weak) IBOutlet UILabel *address;
@property (nonatomic,weak) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;

-(void)loadWithShopModel:(BAShopModel *)shopmodel;
@end
