//
//  BACityChooseTableViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-30.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BACityChooseTableViewController.h"
#import "BACityListModel.h"
#import "LocationService.h"

@interface BACityChooseTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) IBOutlet UITableView *myTableView;
@property (nonatomic,strong) NSArray *hotCitys;
@property (nonatomic,strong) NSArray *allCitys;
@property (nonatomic,strong) LocationService *lservice;
@property (nonatomic,strong) BACityListModel *locationCity;

@end

@implementation BACityChooseTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)setupRightBtn{
    @weakify(self);
    [self setupRightBtnWithTitle:@"确定" withTapped:^{
        @strongify(self);
        [[HCDiskCache shared] addObject:self.locationCity key:KEY_CITYCHOOSEDNAME];

        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];

}
-(NSArray *)totalCitys{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObjectsFromArray:self.hotCitys];
    for (NSArray *tmps in self.allCitys) {
        [array addObjectsFromArray:tmps];
    }
    return array;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"城市定位";
    self.navigationBarHidden = NO;
    [self setIsLeftCancelBtn:YES];

    
    
    NSArray *hotCitys = [[BAProfileManager shared] hotCities];
    self.hotCitys = hotCitys;
    NSArray *allCitys = [[BAProfileManager shared] allCities];

    
    
    NSArray *letters = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    NSMutableArray *sortCitys = [[NSMutableArray alloc] init];
    for (NSString *letter in letters) {
        NSMutableArray *citys = [NSMutableArray array];
        for (BACityListModel *model in allCitys) {
            if ([model.big_initials isEqualToString:letter]) {
                [citys addObject:model];
            }
        }
        [sortCitys addObject:citys];
        
    }
    self.allCitys = sortCitys;
    
    self.lservice = [[LocationService alloc] init];

    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.lservice startLocation];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.lservice stopLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.allCitys.count+2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"定位城市";
    }else if (section == 1) {
        return @"热门城市";
    }else{
        NSArray *letters = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];

        return letters[section -2];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section ==1) {
        return self.hotCitys.count;
    }else{
        return [self.allCitys[section -2] count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CMainCell = @"CityCellIndentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityCellIndentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CMainCell];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = @"正在定位城市...";
        @weakify(self);
        [self.lservice getPlacemark:^(CLPlacemark *placeMark, NSError *error) {
            @strongify(self);
            NSString *city = placeMark.locality;
            if (!city) {
                city = placeMark.administrativeArea;
            }
            BOOL ismatch = NO;
            for (BACityListModel *model in [self totalCitys]) {
                if ([city hasPrefix:model.name]) {
                    city = model.name;
                    ismatch = YES;
                    self.locationCity = model;
                }
            }
            
            
            if (error||!ismatch) {
                cell.textLabel.text = @"无法定位";
            }else{
                cell.textLabel.text = city;
                [self setupRightBtn];
            }
        }];
    }else if (indexPath.section == 1) {
        BACityListModel *model = self.hotCitys[indexPath.row];
        cell.textLabel.text = model.name;
    }else{
        BACityListModel *model = self.allCitys[indexPath.section -2][indexPath.row];
        cell.textLabel.text = model.name;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cityName = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    if (cityName&&![cityName isEqualToString:@"无法定位"]) {
        BACityListModel *model = nil;
        if (indexPath.section == 1) {
            model = self.hotCitys[indexPath.row];
        }else if(indexPath.section == 2){
            model = self.allCitys[indexPath.row];
        }else{
            model = self.locationCity;
        }
        self.locationCity = model;
        [self setupRightBtn];
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
