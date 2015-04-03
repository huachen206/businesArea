//
//  BAShopViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-6.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAShopViewController.h"
#import "BAGoodModel.h"
#import "BAGoodViewController.h"

@interface BAShopViewController ()<AsyncDelegate>
@property (nonatomic,strong) BAShopModel *selectShopModel;
@end

@implementation BAShopViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"店铺";
    
}

#pragma  mark TableView DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 130;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shops.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BAShopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"shopCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BAShopTableViewCell" owner:self options:nil] firstObject];
    }

    BAShopModel *shopmodel = self.shops[indexPath.row];
    [cell loadWithShopModel:shopmodel];
    return cell;
    
}
#pragma  mark TableView Delegate
// 应用：/dev_business_user/index.php?c=commodity&m= searchcommodity&d=commodity
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BAShopModel *shopmodel = self.shops[indexPath.row];
    self.selectShopModel = shopmodel;
    [self searchCommodityWithShopModel:shopmodel];
    
    
}


-(void)searchCommodityWithShopModel:(BAShopModel*)shopmodel{
    BARequestApi *searchadApi = [[BARequestApi alloc] initWithMethod:METHOD_searchcommodity];
    searchadApi.someC = @"commodity";
    searchadApi.someD = @"commodity";
    [searchadApi additionalParams:@{@"sid":shopmodel.sid}];
    
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:searchadApi];
//    request.tag = 101;
    request.delegate = self;
    [request start];

}
- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    NSMutableArray *goods = [NSMutableArray array];
    for (NSDictionary *dic in result[@"commodity"]) {
        BAGoodModel *good = [[BAGoodModel alloc] initWithDictionary:dic error:nil];
        [goods addObject:good];
    }
    if (goods.count >0) {
        BAGoodViewController *goodvc = [[BAGoodViewController alloc] initWithNibName:@"BAGoodViewController" bundle:nil];
        goodvc.goods = goods;
        goodvc.thisShopModel = self.selectShopModel;
        [self.navigationController pushViewController:goodvc animated:YES];
    }else{
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"无商品信息"];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView show];
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
