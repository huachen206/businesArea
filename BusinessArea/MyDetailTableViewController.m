//
//  MyDetailTableViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-24.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "MyDetailTableViewController.h"
#import "BAUserInfoManager.h"
#import "BAMeTableViewCell.h"
#import "BAMePortraitTableViewCell.h"
#import "BAUpLoadPortrailViewController.h"


@interface MyDetailTableViewController ()

@end

@implementation MyDetailTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 84;
    }else{
        return 44;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BAUserInfo *userInfo =[BAUserInfoManager share].userInfo;
    NSArray *textarray = @[@"头像",@"昵称",@"性别",@"修改密码",@"手机号"];

    if (indexPath.row == 0){
        BAMePortraitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"protrailCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BAMePortraitTableViewCell" owner:self options:nil] firstObject];
        }
        NSString *urlString = [NSString stringWithFormat:@"%@/dev_business_user/index.php?c=util&m=download&d=util&file=%@",baseUrl,userInfo.portrait];
        [cell.portraitImageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
    }else{
        BAMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"BAMeTableViewCell" owner:self options:nil] firstObject];
        }
        cell.mainLabel.text = textarray[indexPath.row];
        switch (indexPath.row) {
            case 1:
                cell.rightLabel.text = userInfo.nickName;
                break;
            case 2:
//                cell.detailTextLabel.text = userInfo.sex;
                break;
            case 4:
                cell.rightLabel.text = userInfo.phoneNumber;
                break;
            default:
                break;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
}

#pragma  mark TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *persoanalStoryboard = [UIStoryboard storyboardWithName:@"MyPersonalInfo" bundle:nil];
    if (indexPath.row == 0) {
        UITableViewController *upLoadVC = [persoanalStoryboard instantiateViewControllerWithIdentifier:@"BAUpLoadPortrailViewController"];
        [self.navigationController pushViewController:upLoadVC animated:YES];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
