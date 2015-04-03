//
//  BAOrderFormTableViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAOrderFormTableViewController.h"
#import "BAAddressModel.h"
#import "PAOrderAddressTableViewCell.h"
#import "BAAddressViewController.h"
#import "BAOrderPayTypeTableViewCell.h"
#import "BAGoodTableViewCell.h"
#import "BAOrderSettlementTableViewCell.h"
#import "NSString+HXAddtions.h"

@interface BAOrderFormTableViewController ()<AsyncDelegate,QCheckBoxDelegate>
@property (nonatomic,strong) NSArray *goodList;
@property (nonatomic,strong) BAAddressModel *usualAddressModel;
@property (nonatomic,weak) BAOrderPayTypeTableViewCell *huodaoCell;
@property (nonatomic,weak) BAOrderPayTypeTableViewCell *onlineCell;
@property (nonatomic,assign) float totalMoney;

@end

@implementation BAOrderFormTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"订单";
    self.goodList = [[BAUserInfoManager share] shoppingCartList];

    [self requestApi_usualAddress];
    
    float totalMoney = 0;
    for (BAGoodModel *good in self.goodList) {
        totalMoney+=[good.price floatValue]*[good.num intValue];
    }
    self.totalMoney = totalMoney;

}

-(void)setAddress:(BAAddressModel *)addressModel{
    self.usualAddressModel = addressModel;
    [self.tableView reloadData];
}

-(void)requestApi_usualAddress{
    // 应用：/dev_business_user/index.php?c=user&m=searchuseaddress&d=user
    BARequestApi *api = [[BARequestApi alloc] initWithMethod:METHOD_searchuseaddress];
    
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:api];
    request.tag = 101;
    request.delegate = self;
    [request start];
}
-(void)requestApi_submitOrder{
    // 应用：/dev_business_user/index.php?c=order&m=submitorders&d=order
    BARequestApi *api = [[BARequestApi alloc] initWithMethod:METHOD_submitorders];
    api.someC = @"order";
    api.someD = @"order";
    NSString *pid;
    if (self.onlineCell.selectButton.checked) {
        pid = @"2";
    }else{
        pid = @"1";
    }
    
    NSMutableArray *shops_goods = [[BAUserInfoManager share] shopsForGoodsList];
    NSMutableArray *orders = [NSMutableArray array];
    for (NSArray *shops in shops_goods) {
        NSString *sid = nil;
        NSMutableArray *buys = [NSMutableArray array];
        for (BAGoodModel *goodModel in shops) {
            if (!sid) {
                sid = goodModel.sid;
            }
            NSDictionary *dic = @{@"cid":goodModel.id,@"num":goodModel.num};
            [buys addObject:dic];
        }
        NSDictionary *ashopBuy = @{@"sid":sid,@"buy":buys};
        [orders addObject:ashopBuy];
    }
    
    
//    BOOL isJson = [NSJSONSerialization isValidJSONObject:orders];
    NSString *jsonString = [NSString jsonStringWithArray:orders];
    
    [api additionalParams:@{@"pid":pid,@"addid":self.usualAddressModel.id,@"orders":jsonString}];
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:api];
    request.tag = 102;
    request.delegate = self;
    [request start];

}

-(void)sureAction{
    [self requestApi_submitOrder];
}

#pragma mark asyncerDelegate
- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    if (asyncer.tag == 101) {
        BAAddressModel *addressModel = [[BAAddressModel alloc] initWithDictionary:result[@"address"] error:nil];
        [self setAddress:addressModel];
    }else if (asyncer.tag == 102){
        
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

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.usualAddressModel) {
        return 2+self.goodList.count+1;
    }
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"收货人信息";
    }else if(section == 1){
        return @"配送方式";
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.usualAddressModel) {
        if (indexPath.section == 0) {
            return 151;
        }else if(indexPath.section == 1){
            return 44;
        }else if(indexPath.section == 2+self.goodList.count){
            return 44;
        }
        else{
            return 148;
        }
    }
    return 44;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }else{
        return 1;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PAOrderAddressTableViewCell *cell = (PAOrderAddressTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"PAOrderAddressTableViewCell" owner:self options:nil] firstObject];
        cell.nameLabel.text = self.usualAddressModel.name;
        cell.phoneNumLabel.text = self.usualAddressModel.tel;
        cell.addressLabel.text = self.usualAddressModel.address;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            if (!self.huodaoCell) {
                BAOrderPayTypeTableViewCell *cell = (BAOrderPayTypeTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"BAOrderPayTypeTableViewCell" owner:self options:nil]firstObject];
                cell.nameLabel.text = @"货到付款";
                cell.selectButton.checked = NO;
                cell.selectButton.delegate = self;
                self.huodaoCell = cell;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                return cell;
            }else{
                return self.huodaoCell;
            }
        }else{
            if (!self.onlineCell) {
                BAOrderPayTypeTableViewCell *cell = (BAOrderPayTypeTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"BAOrderPayTypeTableViewCell" owner:self options:nil]firstObject];
                cell.nameLabel.text = @"在线支付";
                cell.selectButton.checked = YES;
                cell.selectButton.delegate = self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                self.onlineCell = cell;
                return cell;
            }else{
                return self.onlineCell;
            }
        }
    }else if (indexPath.section == 2+self.goodList.count){
       BAOrderSettlementTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"BAOrderSettlementTableViewCell" owner:self options:nil] firstObject];
        cell.totalMoneyLabel.text = [NSString stringWithFormat:@"%f",self.totalMoney];
        [cell.sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else{
        BAGoodTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"goodCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BAGoodTableViewCell" owner:self options:nil] firstObject];
        }
        [cell loadModel:self.goodList[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UIStoryboard *persoanalStoryboard = [UIStoryboard storyboardWithName:@"MyPersonalInfo" bundle:nil];
        BAAddressViewController *address = [persoanalStoryboard instantiateViewControllerWithIdentifier:@"AddressViewController"];
        address.fromOrderFormVC = self;
        [self.navigationController pushViewController:address animated:YES];

    }
}
- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked{
    if (checkbox == self.huodaoCell.selectButton) {
        self.onlineCell.selectButton.checked = !checked;
    }else{
        self.huodaoCell.selectButton.checked = !checked;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
