//
//  BAAddressViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAAddressViewController.h"
#import "BAAddressModel.h"
#import "BAAddressTableViewCell.h"
#import "BAAddressEditViewController.h"
@interface BAAddressViewController ()<AsyncDelegate>
@property (nonatomic,strong) NSMutableArray *addressList;
@end

@implementation BAAddressViewController

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
    self.title = @"地址";
    @weakify(self);
    [self setupRightBtnWithTitle:@"新建地址" withTapped:^{
        @strongify(self);
        [self addAddressAction];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestApi];
}
-(void)addAddressAction{
    UIStoryboard *persoanalStoryboard = [UIStoryboard storyboardWithName:@"MyPersonalInfo" bundle:nil];
    BAAddressEditViewController  *addressEditvc = [persoanalStoryboard instantiateViewControllerWithIdentifier:@"AddressEditViewController"];
    [self.navigationController pushViewController:addressEditvc animated:YES];
}

-(void)requestApi{
// 应用：/dev_business_user/index.php?c=user&m=searchaddress&d=user
    BARequestApi *api = [[BARequestApi alloc] initWithMethod:METHOD_searchaddress];
    
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:api];
    request.delegate = self;
    request.tag = 101;
    [request start];

}

-(void)requestApi_delete:(NSString *)addressId{
    // 应用：/dev_business_user/index.php?c=user&m=deladdress&d=user
    BARequestApi *api = [[BARequestApi alloc] initWithMethod:METHOD_deladdress];
    [api additionalParams:@{@"id":addressId}];
    
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:api];
    request.delegate = self;
    request.tag = 102;
    [request start];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark AsyncerDelegate
- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    if (asyncer.tag == 101) {
        self.addressList = [[NSMutableArray alloc] initWithArray:[BAAddressModel addressesWithArray:result[@"address"]]];
        [self.tableView reloadData];
    }
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFailWithError:(NSError *)error{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:[error localizedFailureReason]];
    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
    [alertView show];
    
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.addressList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BAAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BAAddressTableViewCell" owner:self options:nil] firstObject];
    }
    [cell loadModel:self.addressList[indexPath.section]];
    
    return cell;
}

#pragma  mark TableView Delegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView setEditing:YES animated:YES];
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView setEditing:NO animated:YES];
    BAAddressModel *model = [self.addressList objectAtIndex:indexPath.row];
    [self.addressList removeObjectAtIndex:indexPath.row];
    [self requestApi_delete:model.id];
    [tableView reloadData];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BAAddressTableViewCell *cell = (BAAddressTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

    if (self.fromOrderFormVC) {
        [self.fromOrderFormVC setAddress:cell.addressModel];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIStoryboard *persoanalStoryboard = [UIStoryboard storyboardWithName:@"MyPersonalInfo" bundle:nil];
        BAAddressEditViewController  *addressEditvc = [persoanalStoryboard instantiateViewControllerWithIdentifier:@"AddressEditViewController"];
        addressEditvc.addressModel = cell.addressModel;
        [self.navigationController pushViewController:addressEditvc animated:YES];
    }
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
