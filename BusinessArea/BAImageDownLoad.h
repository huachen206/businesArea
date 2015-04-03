//
//  BAImageDownLoad.h
//  BusinessArea
//
//  Created by 花晨 on 14-8-5.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAImageDownLoad : NSObject<AsyncDelegate>
+(void)downLoadWithFileName:(NSString *)fileName complete:(void (^)(UIImage *image))block;

@end
