//
//  BACitysDao.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-30.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BACitysDao.h"

@implementation BACitysDao
+(instancetype)dao{
    return [[self alloc] initWithSQLModel:[BACityListModel model]];
}
-(NSArray *)hotCities{
//    NSString *select = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE big_initials = 热门城市",self.tableName];
    __block NSMutableArray *citys = [[NSMutableArray alloc] init];
    [self.fmDbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db selectResultsFrom:self.tableName matchingValues:@{@"big_initials":@"热门城市"} orderBy:@"initials" error:nil];
        while ([rs next]) {
            [citys addObject:[[BACityListModel alloc] initWithFMResultSet:rs]];
        }
    }];
    return citys;
}

-(NSArray *)cityList{
    __block NSMutableArray *citys = [[NSMutableArray alloc] init];
//    NSString *select =[NSString stringWithFormat:@"SELECT * FROM %@ WHERE big_initials <> '热门城市' ORDER BY initials",self.tableName];
    [self.fmDbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs =  [db selectResultsFrom:self.tableName where:@"big_initials <> '热门城市'" arguments:nil orderBy:@"initials" error:nil];
        while ([rs next]) {
            [citys addObject:[[BACityListModel alloc] initWithFMResultSet:rs]];
        }
    }];
    return citys;

}

@end
