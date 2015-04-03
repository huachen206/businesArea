//
//  BAUserInfoManager.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-21.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAUserInfoManager.h"

@implementation BAUserInfoManager
@synthesize shoppingCartList = _shoppingCartList;
+(instancetype)share{
    static dispatch_once_t onceToken;
    static BAUserInfoManager *__diskCache;
    dispatch_once(&onceToken, ^{
        __diskCache = [[BAUserInfoManager alloc] init];
    });
    return __diskCache;
}

-(NSString *)pathOfShoppingCartList{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"shoppingCartList%@",_userInfo.userId]];
    return path;
}

-(BOOL)writeToFile:(NSData*)data{
    return [data writeToFile:[self pathOfShoppingCartList] atomically:YES];
}
-(void)addShopingCartWithGoodModel:(BAGoodModel *)goodModel{
    BOOL isHave = NO;
    for (BAGoodModel *inGoodModel in self.shoppingCartList) {
        if ([inGoodModel.id isEqualToString:goodModel.id]) {
            isHave = YES;
            inGoodModel.num = goodModel.num;
        }
    }
    if (!isHave) {
        [self.shoppingCartList addObject:goodModel];
    }
    [self writeToFile:[NSKeyedArchiver archivedDataWithRootObject:self.shoppingCartList]];

}

-(void)removeShopingCartWithGoodModel:(BAGoodModel *)goodModel{
    [self.shoppingCartList removeObject:goodModel];
    [self writeToFile:[NSKeyedArchiver archivedDataWithRootObject:self.shoppingCartList]];

}

-(NSMutableArray *)shoppingCartList{
    if (!_shoppingCartList) {
        NSData * data = [NSData dataWithContentsOfFile:[self pathOfShoppingCartList] options:0 error:NULL];
        if (data) {
            _shoppingCartList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }else{
            _shoppingCartList = [[NSMutableArray alloc] init];
        }
    }
    return _shoppingCartList;
}

-(NSMutableArray *)shopsForGoodsList{
    NSMutableArray *shops_goods = [NSMutableArray array];
    for (BAGoodModel *goodModel in self.shoppingCartList) {
        BOOL isHave = NO;
        for (NSMutableArray *shops in shops_goods) {
            for (BAGoodModel *inGoodModel in shops) {
                if ([inGoodModel.sid isEqualToString:goodModel.sid]) {
                    isHave = YES;
                    [shops addObject:goodModel];
                    break;
                }
            }
        }
        if (!isHave) {
            NSMutableArray *shops = [NSMutableArray array];
            [shops addObject:goodModel];
            [shops_goods addObject:shops];
        }
    }
    return shops_goods;
}

@end
