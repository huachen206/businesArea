//
//  BAGoodViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-6.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAGoodViewController.h"
#import "BAGoodTableViewCell.h"
#import "BAGoodDetailViewController.h"

@interface BAGoodViewController ()<AsyncDelegate>
@property (nonatomic,weak) IBOutlet UITableView *myTableView;


@end

@implementation BAGoodViewController

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
    self.title = @"商品";
    
}





#pragma  mark TableView DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 148;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goods.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BAGoodTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"goodCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BAGoodTableViewCell" owner:self options:nil] firstObject];
    }
    [cell loadModel:self.goods[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self searchCommodityWithGoodModel:self.goods[indexPath.row]];
    BAGoodDetailViewController *gdVc = [[BAGoodDetailViewController alloc] initWithNibName:@"BAGoodDetailViewController" bundle:nil];
    gdVc.thisGoodModel =self.goods[indexPath.row];
    gdVc.thisShopModel = self.thisShopModel;
    [self.navigationController pushViewController:gdVc animated:YES];
    
    
    
}

// 应用：/dev_business_user/index.php?c=commodity&m=searchcommoditydetail &d=commodity
-(void)searchCommodityWithGoodModel:(BAGoodModel*)goodmodel{
    BARequestApi *searchadApi = [[BARequestApi alloc] initWithMethod:METHOD_searchcommoditydetail];
    searchadApi.someC = @"commodity";
    searchadApi.someD = @"commodity";
    [searchadApi additionalParams:@{@"cid":goodmodel.id,}];
    
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:searchadApi];
    //    request.tag = 101;
    request.delegate = self;
    [request start];
    
}
- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    NSLog(@"%@",result);
//    NSMutableArray *goods = [NSMutableArray array];
//    for (NSDictionary *dic in result[@"commodity"]) {
//        BAGoodModel *good = [[BAGoodModel alloc] initWithDictionary:dic error:nil];
//        [goods addObject:good];
//    }
//    if (goods.count >0) {
//        BAGoodViewController *goodvc = [[BAGoodViewController alloc] initWithNibName:@"BAGoodViewController" bundle:nil];
//        goodvc.goods = goods;
//        [self.navigationController pushViewController:goodvc animated:YES];
//    }else{
//        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"无商品信息"];
//        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
//        [alertView show];
//    }
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
