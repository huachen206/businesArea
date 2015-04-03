//
//  BAShopingCartViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAShopingCartViewController.h"
#import "BAUserInfoManager.h"
#import "BAGoodTableViewCell.h"
#import "BAGoodModel.h"
#import "BAShopModel.h"
#import "BAGoodDetailViewController.h"

@interface BAShopingCartViewController ()<AsyncDelegate>
@property (nonatomic,strong) NSArray *goods;
@property (nonatomic,strong) BAGoodModel *selectGoodModel;
@end

@implementation BAShopingCartViewController

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
    self.title = @"购物车";
    self.goods = [[BAUserInfoManager share] shoppingCartList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
//    [cell setEditing:YES animated:YES];

    [cell loadModel:self.goods[indexPath.section]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectGoodModel =self.goods[indexPath.row];
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
    if(asyncer.tag == 102){
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




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
