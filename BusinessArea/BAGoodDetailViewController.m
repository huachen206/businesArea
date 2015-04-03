//
//  BAGoodDetailViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-6.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAGoodDetailViewController.h"
#import "BAGoodTableViewCell.h"
#import "BAShopTableViewCell.h"
#import "BACloseAccountTableViewCell.h"
#import "BAOrderFormTableViewController.h"
#import "BAUserInfoManager.h"

@interface BAGoodDetailViewController ()<AsyncDelegate>
@property(nonatomic,weak) IBOutlet UITableView *myTableView;


//@property(nonatomic,strong) 
@end

@implementation BAGoodDetailViewController

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
    self.title = @"商品详情";
}
-(void)requestShopDetail{
//    BARequestApi *searchadApi = [[BARequestApi alloc] initWithMethod:METHOD_searchshopdetail];
//    searchadApi.someC = @"commodity";
//    searchadApi.someD = @"commodity";
//    [searchadApi additionalParams:@{@"sid":self.thisGoodModel.sid,}];
//    
//    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:searchadApi];
//    //    request.tag = 101;
//    request.delegate = self;
//    [request start];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark TableView DataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"买家信息";
    }else{
        return @"";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 148;
            break;
        case 1:
            return 130;
            break;
        case 2:
            return 44;
            break;

        default:
            return 44;
            break;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        BAGoodTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"goodCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BAGoodTableViewCell" owner:self options:nil] firstObject];
        }
        [cell loadModel:self.thisGoodModel];
        return cell;
    }else if(indexPath.section == 1){
        BAShopTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"shopCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BAShopTableViewCell" owner:self options:nil] firstObject];
        }
        
        BAShopModel *shopmodel = self.thisShopModel;
        [cell loadWithShopModel:shopmodel];
        return cell;

    }else{
        BACloseAccountTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"goodDetailNext"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BACloseAccountTableViewCell" owner:self options:nil] firstObject];
        }
        [cell.goShoppingCartButton addTarget:self action:@selector(goShoppingCartAction) forControlEvents:UIControlEventTouchUpInside];
        [cell.settleAccountsButton addTarget:self action:@selector(settleAccountsButtonAction) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
    
}

-(void)goShoppingCartAction{
    [[BAUserInfoManager share] addShopingCartWithGoodModel:self.thisGoodModel];
    alertInViewController(@"成功添加入购物车", nil, PAAlertTypeSuccess);
}


-(void)settleAccountsButtonAction{
    BAOrderFormTableViewController *ofTvc = [[BAOrderFormTableViewController alloc] initWithNibName:@"BAOrderFormTableViewController" bundle:nil];
    [self.navigationController pushViewController:ofTvc animated:YES];
    
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self searchCommodityWithGoodModel:self.goods[indexPath.row]];
//}

@end
