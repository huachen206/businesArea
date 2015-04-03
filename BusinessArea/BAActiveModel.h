//
//  BAActiveModel.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-9.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "JSONModel.h"

/*
 "id":"2",			//唯一标识
 "title":"商家10",		//标题
 "description":"2活2动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容活动内容",			//内容
 "startdate":"1402549560",		//开始时间
 "enddate":"1403845560",			//结束时间
 "general_sco":"222222",			//返通用积分
 "signup_num":"0"				//报名人数
 "status":"0"				//是否报名 0：未报名 1：已报名
 "showstatus":"已报名"				//显示报名文字
 */

@interface BAActiveModel : JSONModel
@property(nonatomic,strong) NSString *id;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *description;
@property(nonatomic,strong) NSString *startdate;
@property(nonatomic,strong) NSString *enddate;
@property(nonatomic,strong) NSString *general_sco;
@property(nonatomic,strong) NSString *signup_num;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *showstatus;

+(NSArray *)activeListWithDic:(NSDictionary *)dic;
@end
