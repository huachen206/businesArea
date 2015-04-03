//
//  BAGoodTableViewCell.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-6.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAGoodModel.h"
/*
 "id":"3",			//商品id
 "sid":"1",			//商铺id
 "uname":"lils",		//商铺名称
 "lat":"1",			//经度
 "lng":"1",			//纬度
 "barcode":"",			//条形码
 "picture":"568a3cacu.jpg",	//商品图片
 "name":"可口可乐",		//商品名称
 "type":"3",			//商品种类
 "price":"3.00",		//商品单价（暂时用不到）
 "dis_price":"3.00",		//商品折后价（现在画面上显示的是这个单价）
 "shop_sco":"10",		//返店铺积分
 "general_sco":"10",		//返通用积分
 "stock":"200",			//库存
 "des":"0",			//商品描述
 " distance":"1"			//距离（sid不存
 */
@interface BAGoodTableViewCell : UITableViewCell
@property (nonatomic,strong) BAGoodModel *goodModel;
@property (nonatomic,weak) IBOutlet UIImageView *imageview_logo;
@property (nonatomic,weak) IBOutlet UILabel *label_uname;
@property (nonatomic,weak) IBOutlet UILabel *label_distance;
@property (nonatomic,weak) IBOutlet UILabel *label_name;
@property (nonatomic,weak) IBOutlet UILabel *label_price;
@property (nonatomic,weak) IBOutlet UILabel *label_des;
@property (weak, nonatomic) IBOutlet UITextField *textfield_number;

@property (nonatomic,weak) IBOutlet UIButton *button_subtraction;
@property (nonatomic,weak) IBOutlet UIButton *button_addition;

-(void)loadModel:(BAGoodModel*)goodModel;
-(void)openDetailMode;
@end
