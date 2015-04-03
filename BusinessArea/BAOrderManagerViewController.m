//
//  BAOrderManagerViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-20.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAOrderManagerViewController.h"
#import "BAOrderModel.h"
#import "BAOrderDetailTableViewController.h"

@interface BAOrderManagerViewController ()<AsyncDelegate>
@property (nonatomic,strong) NSArray *orderList;
@end

@implementation BAOrderManagerViewController

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
    self.title = @"订单管理";
    // Do any additional setup after loading the view from its nib.
    [self requestApi_searchOrder];
}

-(void)requestApi_searchOrder{
// 应用：/dev_business_user/index.php?c=order&m=searchorders&d=order
    BARequestApi *api = [[BARequestApi alloc] initWithMethod:METHOD_searchorders];
    api.someC = @"order";
    api.someD = @"order";
    [api additionalParams:@{@"status":@(0)}];
    
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:api];
    request.tag = 101;
    request.delegate = self;
    [request start];
}

#pragma mark asyncer delegate
- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    if (asyncer.tag == 101) {
        NSArray *orders = [BAOrderModel ordersWithArray:result[@"orders"]];
        self.orderList = orders;
        
        [self performSelector:@selector(dealyJump) withObject:nil afterDelay:1.f];
    }else if (asyncer.tag == 102){
        
    }
}
-(void)dealyJump{
    UIStoryboard *persoanalStoryboard = [UIStoryboard storyboardWithName:@"MyPersonalInfo" bundle:nil];
    BAOrderDetailTableViewController *orderDetailTableViewController = [persoanalStoryboard instantiateViewControllerWithIdentifier:@"BAOrderDetailTableViewController"];
    orderDetailTableViewController.orderModel = [self.orderList firstObject];
    
            [self.navigationController pushViewController:orderDetailTableViewController animated:YES];

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
