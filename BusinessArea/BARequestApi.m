//
//  BARequestApi.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-21.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BARequestApi.h"
#import "BAUserInfoManager.h"

@implementation BARequestApi

NSString * const Business_user  = @"dev_business_user";

NSString * const C_USER = @"user";
NSString * const D_USER = @"user";


-(NSDictionary *)baseParams{
    if ([self.httpMethod isEqualToString:@"GET"]) {
//        return @{@"c":@"user",@"m":@"login",@"d":@"user"};

    }
    return nil;
}
-(id)initWithMethod:(NSString *)method{
//    DebugAssert(NO, @"子类实现");
    self = [super init];
    if (self) {
        self.method = method;
        self.httpMethod = @"POST";
    }
    return self;
}

-(NSString *)operation{
////    pwd = 1111;
////    tel = 13898189131;
//
//    return @"http://115.28.59.82/dev_business_user/index.php?c=user&m=login&d=user&tel=13898189131&pwd=1111";
    NSString *protal;
    NSString *someC;
    NSString *someD;
    
    
    if (self.portal) {
        protal = self.portal;
    }else{
        protal = Business_user;
    }
    if (self.someC) {
        someC = self.someC;
    }else{
        someC = C_USER;
    }
    if (self.someD) {
        someD = self.someD;
    }else{
        someD = D_USER;
    }
    
    NSString *opertion = [NSString stringWithFormat:BaseUrlFormat,baseUrl,protal,someC,self.method,someD];
    NSArray *apisWithoutMethod = @[@"login",@"register",@"getsms",@"config",@"download"];

    if (![apisWithoutMethod containsObject:self.method]) {
        NSString *authToken =[[BAUserInfoManager share] authToken];
        if (authToken) {
            opertion = [[opertion stringByAppendingString:@"&token="] stringByAppendingString:authToken];
        }
    }
//    opertion = [[opertion stringByAppendingString:@"&code="] stringByAppendingString:CODE];

    
//    NSString *opertion = [NSString stringWithFormat:BaseUrlFormat,baseUrl,protal];

    
    return opertion;
}
@end
