//
//  SecondViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-12.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "SecondViewController.h"
#import "BAGoodViewController.h"
#import "BAGoodModel.h"
#import "BAGoodTableViewCell.h"
#import "BAGoodDetailViewController.h"
#import "LocationService.h"

typedef NS_ENUM(NSInteger, BAScreeningType) {
    BAScreeningType_salesVolumeHither =1,
    BAScreeningType_priceLower,
    BAScreeningType_distanceNear,
    BAScreeningType_commonScoreMore,
    BAScreeningType_shopScoreMore,
};

@interface SecondViewController ()<AsyncDelegate>
@property (weak,nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,assign) BAScreeningType screeningType;
@property (nonatomic,strong) NSArray *goods;
@property (nonatomic,strong) LocationService *lservice;
@property (nonatomic,strong) BAGoodModel  *selectGoodModel;

@end

@implementation SecondViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.parentViewController.title = @"商品";


}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.lservice stopLocation];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.lservice = [[LocationService alloc] init];
    self.screeningType = 1;
    
    [self.lservice startLocation];
    [self searchCommodityWithShopModel];

    
}
-(void)searchCommodityWithShopModel{
    @weakify(self);
    [self.lservice getMyLocation:^(NSArray *locations, NSError *error) {
        @strongify(self);
        if (!error) {
            CLLocation *location = [locations lastObject];
            BARequestApi *searchadApi = [[BARequestApi alloc] initWithMethod:METHOD_searchcommodity];
            searchadApi.someC = @"commodity";
            searchadApi.someD = @"commodity";
            [searchadApi additionalParams:@{@"type":@(self.screeningType),@"lat":@(location.verticalAccuracy),@"lng":@(location.horizontalAccuracy)}];
            
            HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:searchadApi];
            request.tag = 101;
            request.delegate = self;
            [request start];
            [self.lservice stopLocation];

        }else{
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:[error localizedFailureReason]];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
            [alertView show];

        }

    }];
    
}

#pragma  mark TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.goods.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 148;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BAGoodTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"goodCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BAGoodTableViewCell" owner:self options:nil] firstObject];
    }
    [cell loadModel:self.goods[indexPath.section]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectGoodModel =self.goods[indexPath.section];
    [self searchCommodityWithGoodModel:self.selectGoodModel];
}
-(void)searchCommodityWithGoodModel:(BAGoodModel*)goodmodel{
    BARequestApi *searchadApi = [[BARequestApi alloc] initWithMethod:METHOD_searchcommoditydetail];
    searchadApi.someC = @"commodity";
    searchadApi.someD = @"commodity";
    [searchadApi additionalParams:@{@"cid":goodmodel.id,}];
    
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:searchadApi];
    request.tag = 102;
    request.delegate = self;
    [request start];
    
}

- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    if (asyncer.tag == 101) {
        NSMutableArray *goods = [NSMutableArray array];
        for (NSDictionary *dic in result[@"commodity"]) {
            BAGoodModel *good = [[BAGoodModel alloc] initWithDictionary:dic error:nil];
            [goods addObject:good];
        }
        if (goods.count >0) {
            self.goods = goods;
            [self.myTableView reloadData];
        }else{
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"无商品信息"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
            [alertView show];
        }

    }else if(asyncer.tag == 102){
        BAGoodModel *thisGoodModel = [[BAGoodModel alloc] initWithDictionary:result[@"commoditydetail"] error:nil];
        BAShopModel *thisShopModel = [[BAShopModel alloc] initWithDictionary:result[@"shopdetail"]];
        

//        NSLog(@"%@",result);
        BAGoodDetailViewController *gdVc = [[BAGoodDetailViewController alloc] initWithNibName:@"BAGoodDetailViewController" bundle:nil];
        if (!thisGoodModel) {
            thisGoodModel = self.selectGoodModel;
        }
        gdVc.thisGoodModel =thisGoodModel;
        gdVc.thisShopModel =thisShopModel;
        [self.navigationController pushViewController:gdVc animated:YES];

    }
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFailWithError:(NSError *)error{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:[error localizedFailureReason]];
    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
    [alertView show];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
