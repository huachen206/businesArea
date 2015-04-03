//
//  BAActiveTableViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-9.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAActiveTableViewController.h"
#import "BAActiveModel.h"
#import "BAActiveDetailViewController.h"

@interface BAActiveTableViewController ()<AsyncDelegate>
@property (nonatomic,strong) NSArray *activtyList;
@end

@implementation BAActiveTableViewController

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
    self.title = @"活动报名";

    [self requestForActiveList];
    
}


-(void)requestForActiveList{
    // 应用：/dev_business_user/index.php?c=activities&m=searchactivities&d=activities
    BARequestApi *searchactivitiesAPi = [[BARequestApi alloc] initWithMethod:METHOD_searchactivities];
    searchactivitiesAPi.someC = @"activities";
    searchactivitiesAPi.someD = @"activities";

    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:searchactivitiesAPi];
    request.delegate = self;
    [request start];
    
}
#pragma mark AsyncerDelegate
- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    NSLog(@"%@",result);
    self.activtyList = [BAActiveModel activeListWithDic:result];
    
    [self.tableView reloadData];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.activtyList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BAActiveModel *model = self.activtyList[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"activityCell"];
//        [cell.imageView sd_setImageWithURL:<#(NSURL *)#>]
        cell.textLabel.text =model.title;
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BAActiveModel *model = self.activtyList[indexPath.row];
    
    UIStoryboard *personaalStoryboard = [UIStoryboard storyboardWithName:@"MyPersonalInfo" bundle:nil];
    BAActiveDetailViewController *activeDetailVC = [personaalStoryboard instantiateViewControllerWithIdentifier:@"BAActiveDetailViewController"];
    activeDetailVC.activeModel = model;
    [self.navigationController pushViewController:activeDetailVC animated:YES];
    
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
