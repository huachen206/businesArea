//
//  BACityListModel.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-30.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BACityListModel.h"

@implementation BACityListModel
+(instancetype)model{
    BACityListModel *model = [[BACityListModel alloc] init];
    model.dbPath = [BACityListModel getPath];
    
    model.sqlHelper = [SQLHelper CreatWithTableName:@"cityList"];
    [model.sqlHelper addType:@"INTEGER PRIMARY KEY  AUTOINCREMENT DEFAULT NULL" field:@"id"];

    [model.sqlHelper addType:@"VARCHAR(256)" field:@"name"];
    [model.sqlHelper addType:@"VARCHAR(256)" field:@"adcode"];
    [model.sqlHelper addType:@"VARCHAR(256)" field:@"initials"];
    [model.sqlHelper addType:@"VARCHAR(256)" field:@"big_initials"];

    return model;
}

-(id)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if (self) {
        self.name = dic[@"name"];
        self.adcode = dic[@"adcode"];
        self.initials = dic[@"initials"];
    }
    return self;
}

-(id)initWithFMResultSet:(FMResultSet *)result{
    if (self = [super initWithFMResultSet:result]) {
        self.name = [result stringForColumn:@"name"];
        self.adcode = [result stringForColumn:@"adcode"];
        self.initials = [result stringForColumn:@"initials"];
        self.big_initials = [result stringForColumn:@"big_initials"];
    }
    return self;
}
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super init];
//    if (self)
//    {
//        self.name = [aDecoder decodeObjectForKey:@"name"];
//        self.adcode = [aDecoder decodeObjectForKey:@"adcode"];
//        self.initials = [aDecoder decodeObjectForKey:@"initials"];
//        self.big_initials =[aDecoder decodeObjectForKey:@"big_initials"];
//    }
//    return self;
//}
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:self.name forKey:@"name"];
//    [aCoder encodeObject:self.adcode forKey:@"adcode"];
//    [aCoder encodeObject:self.initials forKey:@"initials"];
//    [aCoder encodeObject:self.big_initials forKey:@"big_initials"];
//}


+(NSString *)getPath{
    NSString *docsPath = getDocumentPath();
    NSString *dbFolderPath = [docsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",@"publicDB"]];
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbFolderPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dbFolderPath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    if (!error) {
        return  [docsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@/%@",@"publicDB",@"public.db"]];
    }
    return nil;
}
@end
