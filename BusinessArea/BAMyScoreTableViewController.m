//
//  BAMyScoreTableViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAMyScoreTableViewController.h"
#import "BAShopScoModel.h"
#import "BAShop_scoTableViewCell.h"
#import "BAGeneral_ScoTableViewCell.h"

@interface BAMyScoreTableViewController ()<AsyncDelegate>
@property (nonatomic,strong) NSString *general_sco;
@property (nonatomic,strong) NSArray *shop_scos;

@end

@implementation BAMyScoreTableViewController

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
    // Do any additional setup after loading the view.
    self.title = @"我的积分";
    
    [self requestApi];
}

-(void)requestApi{
    // 应用：/dev_business_user/index.php?c=user&m=mysco&d=user
    BARequestApi *myscoApi = [[BARequestApi alloc] initWithMethod:METHOD_mysco];
    myscoApi.someC = @"user";
    myscoApi.someD = @"user";
    
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:myscoApi];
    request.delegate = self;
    [request start];

    
}
#pragma mark AsyncerDelegate
- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    NSLog(@"%@",result);
    self.general_sco = result[@"general_sco"];
    self.shop_scos = [BAShopScoModel shop_scoWithArray:result[@"shop_sco"]];
    [self.tableView reloadData];
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFailWithError:(NSError *)error{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:[error localizedFailureReason]];
    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
    [alertView show];
    
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else{
        return 73;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"店铺积分";
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int number = 0;
    if (self.general_sco) {
        number++;
    }
    if (self.shop_scos.count>0) {
        number++;
    }
    return number;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return self.shop_scos.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        BAGeneral_ScoTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"general_scoCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BAGeneral_ScoTableViewCell" owner:self options:nil] firstObject];
        }
        cell.mainTitleLabel.text = @"我的通用积分";
        cell.scoreLabel.text =[NSString stringWithFormat:@"%@积分",self.general_sco];
        return cell;
    }else{
        BAShopScoModel *scoModel = self.shop_scos[indexPath.row];
        BAShop_scoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shop_scoCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BAShop_scoTableViewCell" owner:self options:nil] firstObject];
        }
        [cell loadModel:scoModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

#pragma mark - Table view Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    BAActiveModel *model = self.activtyList[indexPath.row];
//    
//    UIStoryboard *personaalStoryboard = [UIStoryboard storyboardWithName:@"MyPersonalInfo" bundle:nil];
//    BAActiveDetailViewController *activeDetailVC = [personaalStoryboard instantiateViewControllerWithIdentifier:@"BAActiveDetailViewController"];
//    activeDetailVC.activeModel = model;
//    [self.navigationController pushViewController:activeDetailVC animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
