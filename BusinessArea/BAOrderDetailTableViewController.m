//
//  BAOrderDetailTableViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-20.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAOrderDetailTableViewController.h"
#import "BAOrderDetailGoodTableViewCell.h"
#import "PAOrderAddressTableViewCell.h"
#import "UIView+BlocksKit.h"
#import "BAPayTableViewController.h"

@interface BAOrderDetailTableViewController ()<AsyncDelegate>

@end

@implementation BAOrderDetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"订单详情";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}
/**
 *  取消订单
 */
-(void)requestApi_cancelorder{
// 应用：/dev_business_user/index.php?c=order&m=cancelorder&d=order
    BARequestApi *api = [[BARequestApi alloc] initWithMethod:METHOD_cancelorder];
    api.someC = @"order";
    api.someD = @"order";
    
    
    [api additionalParams:@{@"oid":self.orderModel.orders.id}];
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:api];
    request.tag = 101;
    request.delegate = self;
    [request start];



}
/**
 *  退单申请
 */
-(void)requestApi_returnorder{
// 应用：/dev_business_user/index.php?c=order&m=returnorder&d=order
    BARequestApi *api = [[BARequestApi alloc] initWithMethod:METHOD_returnorder];
    api.someC = @"order";
    api.someD = @"order";
    
    
    [api additionalParams:@{@"oid":self.orderModel.orders.id}];
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:api];
    request.tag = 102;
    request.delegate = self;
    [request start];

}
/**
 *  确认收货
 */
-(void)requestApi_confirmreceipt{
    // 应用：/dev_business_user/index.php?c=order&m=confirmreceipt&d=order
    BARequestApi *api = [[BARequestApi alloc] initWithMethod:METHOD_confirmreceipt];
    api.someC = @"order";
    api.someD = @"order";
    
    
    [api additionalParams:@{@"oid":self.orderModel.orders.id}];
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:api];
    request.tag = 103;
    request.delegate = self;
    [request start];
    
}
/**
 *  退单确认
 */
-(void)requestApi_confirmsinglestep{
    // 应用：/dev_business_user/index.php?c=order&m=confirmsinglestep&d=order
    BARequestApi *api = [[BARequestApi alloc] initWithMethod:METHOD_confirmsinglestep];
    api.someC = @"order";
    api.someD = @"order";
    
    
    [api additionalParams:@{@"oid":self.orderModel.orders.id}];
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:api];
    request.tag = 104;
    request.delegate = self;
    [request start];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark asyncerDelegate

- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    if (asyncer.tag == 101) {
        alertInViewController(@"取消订单成功", nil, PAAlertTypeSuccess);
        [self.navigationController popViewControllerAnimated:YES];
    } else if (asyncer.tag == 102) {
        alertInViewController(@"退单成功", nil, PAAlertTypeSuccess);
        [self.navigationController popViewControllerAnimated:YES];
    }


}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFailWithError:(NSError *)error{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:[error localizedFailureReason]];
    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
    [alertView show];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1+self.orderModel.orders_detail.count;
    }else if(section == 1){
        return 2;
    }else if(section == 2){
        return 1;
    }else if (section == 3){
        return 3;
    }else if (section == 4){
        return 1;
    }
    else{
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row>0) {
            return 90;
        }
    }else if(indexPath.section == 1){
        if (indexPath.row == 1) {
            return 151;
        }
    }
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row ==0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            cell.textLabel.text = @"订单状态";
            cell.detailTextLabel.text = self.orderModel.orders.showstatus;
            [cell.detailTextLabel setTextColor:[UIColor orangeColor]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }
        else{
            BAOrderDetailGoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BAOrderDetailGoodTableViewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"BAOrderDetailGoodTableViewCell" owner:self options:nil] firstObject];
                [cell loadWithDetailModel:self.orderModel.orders_detail[indexPath.row-1]];
            }
            return cell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.text = @"收货地址";
            [cell.detailTextLabel setTextColor:[UIColor orangeColor]];
            return cell;
        }else{
            PAOrderAddressTableViewCell *cell = (PAOrderAddressTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:@"PAOrderAddressTableViewCell" owner:self options:nil] firstObject];
//            cell.nameLabel.text = self.usualAddressModel.name;
//            cell.phoneNumLabel.text = self.usualAddressModel.tel;
//            cell.addressLabel.text = self.usualAddressModel.address;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;

        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            cell.textLabel.text = @"卖家信息";
            cell.detailTextLabel.text = self.orderModel.orders.tel;
            return cell;
        }else{
            //TODO:
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            return cell;
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.text = @"订单信息";
            return cell;
        }else if (indexPath.row == 1){
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            cell.textLabel.text = @"订单号：";
            cell.detailTextLabel.text = self.orderModel.orders.order_no;
            return cell;
        }else if (indexPath.row == 2){
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            cell.textLabel.text = @"订单日期：";
//            cell.detailTextLabel.text = self.orderModel.orders.;
            return cell;
        }
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

        UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
        moneyLabel.text = [NSString stringWithFormat:@"合计:¥%@",self.orderModel.orders.total_price];
        moneyLabel.textColor = [UIColor orangeColor];
        [cell.contentView addSubview:moneyLabel];
        
        int operation = [self.orderModel.orders.operation intValue];
        if (operation != 0) {
            UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 5, 75, 30)];
            [cell.contentView addSubview:payButton];
            NSString *title;
            if (operation ==1) {
                title = @"待付款";
                @weakify(self);
                [payButton bk_whenTapped:^{
                    @strongify(self);
//                   <#(NSString *)#> BAPayTableViewController *payVc = [[BAPayTableViewController alloc] initWithNibName: bundle:<#(NSBundle *)#>]
                    
                    
                }];
            }else{
                title = @"确认收货";
                @weakify(self);
                [payButton bk_whenTapped:^{
                    @strongify(self);
                    [self requestApi_confirmreceipt];
                }];

            }
            [payButton setTitle:title forState:UIControlStateNormal];
            [payButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [payButton setTitle:title forState:UIControlStateDisabled];
            [payButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        }
        
        int cancelorder = [self.orderModel.orders.cancelorder intValue];
        if (cancelorder != 0) {
            UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(235, 5, 75, 30)];
            [cell.contentView addSubview:cancelButton];

            NSString *title;
            if (cancelorder == 1) {
                title = @"取消";
                @weakify(self);
                [cancelButton bk_whenTapped:^{
                    @strongify(self);
                    [self requestApi_cancelorder];
                }];

            }else if (cancelorder == 2){
                title = @"退货";
                @weakify(self);
                [cancelButton bk_whenTapped:^{
                    @strongify(self);
                    [self requestApi_returnorder];
                }];

            }else{
                title = @"退款确认";
                @weakify(self);
                [cancelButton bk_whenTapped:^{
                    @strongify(self);
                    [self requestApi_confirmsinglestep];
                }];
            }
            [cancelButton setTitle:title forState:UIControlStateNormal];
            [cancelButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [cancelButton setTitle:title forState:UIControlStateDisabled];
            [cancelButton setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
            }
        
        /*
         "operation":"0",	//0:不显示按钮 1：显示待付款 2：显示确认收货
         "cancelorder":"2" //0：不显示按钮 1：显示取消按钮 2：显示退货按钮  3：显示退款确认按钮
         */
    
        return cell;
    }
    
    return nil;
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
