//
//  BAShopScoModel.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "JSONModel.h"
/*
 {
     portrait = "ce806c5bu.png";
     "shop_sco" = 800;
     sid = 1;
     uname = lils;
}
 */
@interface BAShopScoModel : JSONModel
@property (nonatomic,strong) NSString *portrait;
@property (nonatomic,strong) NSString *shop_sco;
@property (nonatomic,strong) NSString *sid;
@property (nonatomic,strong) NSString *uname;

+(NSArray *)shop_scoWithArray:(NSArray *)array;

@end
