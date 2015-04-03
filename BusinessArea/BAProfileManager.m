//
//  BAProfileManager.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-20.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAProfileManager.h"
#import "HCProfileService.h"
#import "HCDiskCache.h"
#import "BACityListModel.h"
#import "BACitysDao.h"

@interface BAProfileManager()<HCProfileServiceDelegate>
@property (nonatomic,strong) HCProfileService *profileService;
@property (nonatomic,strong) NSDictionary *result;

@end

@implementation BAProfileManager
+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static BAProfileManager *__diskCache;
    dispatch_once(&onceToken, ^{
        __diskCache = [[BAProfileManager alloc] init];
        __diskCache.profileService = [HCProfileService profileServiceWithUrl:prifileUrl delegate:__diskCache];
        [__diskCache insertCityToDb];
    });
    return __diskCache;
}

-(void)insertCityToDb{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"]];
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString *vercity = json[@"vercity"];

    NSString *localVercity = [[HCDiskCache shared] objectForKey:KEY_CITYJsonVercity];
    if ([vercity isEqualToString:localVercity]) {
        return;
    }else{
        BACitysDao *dao = [BACitysDao dao];
        [dao creatOrUpgradeTable];
        
        [[HCDiskCache shared] addObject:vercity key:KEY_CITYJsonVercity];
        NSArray *citylist = json[@"city"];
        
        for (NSDictionary *cityies in citylist) {
            NSString *big_initials = cityies[@"initials"];
            NSArray *list = cityies[@"cityies"];
            for (NSDictionary *cityDic in list) {
                BACityListModel *model = [[BACityListModel alloc] initWithDictionary:cityDic];
                model.big_initials = big_initials;
                [dao insertOrReplaceWithModel:model];
            }
        }

    }
    
}

-(NSArray *)hotCities{
    BACitysDao *dao = [BACitysDao dao];
    return [dao hotCities];
}
-(NSArray *)allCities{
    BACitysDao *dao = [BACitysDao dao];
    return [dao cityList];

}

-(void)ProfileServiceDownStart:(HCProfileService *)service{
    
}
-(void)ProfileService:(HCProfileService *)service jsonResult:(id)result{
    
    [[HCDiskCache shared] addObject:result key:@"profile"];
    
    self.circleList = [BACircleModel circleListWitharray:result[@"circle"][@"c"]];
    self.circleList_n =[BACircleModel circleListWitharray:result[@"circle"][@"n"]];
    
    self.shop_types = [BAShopType shopTypeListWithArray:result[@"shop_type"]];
    
    self.sendUps = [BASendUp sendUpListWithArray:result[@"sendup"]];
    
    

}



-(void)ProfileService:(HCProfileService *)service downLoadError:(NSError *)error{
    
}




@end
