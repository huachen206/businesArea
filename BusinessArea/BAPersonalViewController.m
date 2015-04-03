//
//  BAPersonalViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-24.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAPersonalViewController.h"
#import "BAMeTableViewCell.h"
#import "AppDelegate.h"
#import "BASigninViewController.h"
#import "BABasicNavigationController.h"
@interface BAPersonalViewController (){
    NSArray *cellTexts;
}
@property (nonatomic,weak) IBOutlet UITableView *tableView;

@end

@implementation BAPersonalViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.parentViewController.title = @"个人";
}

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
//    self.title = @"个人";
//    self.navigationBarHidden = YES;

    cellTexts = [[NSArray alloc]initWithObjects:@"扫一扫支付",@"活动报名",@"我的积分",@"我的资料",@"订单管理",@"购物车",@"常用地址修改",@"城市设置",nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 8;
            break;
        case 1:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personalCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"personalCell"];
        
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = cellTexts[indexPath.row];
        NSString *imageName = [NSString stringWithFormat:@"personal_%d",indexPath.row];
        [cell.imageView setImage:[UIImage imageNamed:imageName]];
    }else{
        cell.textLabel.text = @"退出";
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
#pragma  mark TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UIStoryboard *persoanalStoryboard = [UIStoryboard storyboardWithName:@"MyPersonalInfo" bundle:nil];

        switch (indexPath.row) {
            case 1:{
                UITableViewController *activityTableViewController = [persoanalStoryboard instantiateViewControllerWithIdentifier:@"activityTableViewController"];
                [self.navigationController pushViewController:activityTableViewController animated:YES];
            }
            break;
            case 2:{
                UITableViewController *activityTableViewController = [persoanalStoryboard instantiateViewControllerWithIdentifier:@"BAMyScoreTableViewController"];
                [self.navigationController pushViewController:activityTableViewController animated:YES];

            }
                break;
            case 3:{
                UITableViewController *myDetail = [persoanalStoryboard instantiateViewControllerWithIdentifier:@"MyDetail"];
                [self.navigationController pushViewController:myDetail animated:YES];
                
            }
                break;
            case 4:{
                UITableViewController *orderManager = [persoanalStoryboard instantiateViewControllerWithIdentifier:@"BAOrderManagerViewController"];
                [self.navigationController pushViewController:orderManager animated:YES];
                
            }
                break;
                
            case 5:{
                UITableViewController *ShopingCart = [persoanalStoryboard instantiateViewControllerWithIdentifier:@"ShopingCartViewController"];
                [self.navigationController pushViewController:ShopingCart animated:YES];

            }
                break;
            case 6:{
                UITableViewController *address = [persoanalStoryboard instantiateViewControllerWithIdentifier:@"AddressViewController"];
                [self.navigationController pushViewController:address animated:YES];
                
            }
                break;
            default:
                break;
        }

    }else{
        [[HCDiskCache shared] removeObjectForKey:@"userName"];
        [[HCDiskCache shared] removeObjectForKey:@"passWord"];
        [[HCDiskCache shared] removeObjectForKey:@"isAtuoSignin"];
        
        UIStoryboard *mainBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BABasicNavigationController *nav = [mainBoard instantiateViewControllerWithIdentifier:@"MainNavigationController"];
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        app.window.rootViewController = nav;
        [app.window makeKeyAndVisible];
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
