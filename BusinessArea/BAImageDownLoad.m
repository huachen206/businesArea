//
//  BAImageDownLoad.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-5.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAImageDownLoad.h"
typedef void (^DownCompleteBlock)(UIImage *image);
@interface BAImageDownLoad()
@property (nonatomic,copy) DownCompleteBlock completeBlock;
@end
@implementation BAImageDownLoad
/// dev_business_user/index.php?c=util&m=download&d=util


+(void)downLoadWithFileName:(NSString *)fileName complete:(void (^)(UIImage *image))block{
    BAImageDownLoad *dowmLoad = [[BAImageDownLoad alloc] init];
    
    if (block) {
        dowmLoad.completeBlock = block;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@dev_business_user/index.php?c=util&m=download&d=util&%@",baseUrl,fileName];
    
    
    BARequestApi *searchadApi = [[BARequestApi alloc] initWithMethod:@"download"];
    searchadApi.someC = @"util";
    searchadApi.someD = @"util";
    searchadApi.httpMethod = @"GET";
    NSString *tel = [BAUserInfoManager share].userInfo.phoneNumber;
    [searchadApi additionalParams:@{@"file":fileName}];
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:searchadApi];
    request.tag = 101;
    request.delegate = dowmLoad;
    [request start];

}

- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    UIImage *image = [UIImage imageWithData:result];
    if (self.completeBlock) {
        self.completeBlock(image);
    }
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFailWithError:(NSError *)error{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:[error localizedFailureReason]];
    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
    [alertView show];
    
}


@end
