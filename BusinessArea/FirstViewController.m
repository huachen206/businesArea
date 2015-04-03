//
//  FirstViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-12.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "FirstViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SelectionCell.h"
#import "UITableView+DataSourceBlocks.h"
#import "TableViewWithBlock.h"
#import "UIImageView+WebCache.h"
#import "BAProfileManager.h"
#import "BARequestApi.h"
#import "BAShopModel.h"
#import "BAShopViewController.h"

@interface FirstViewController ()<AsyncDelegate>{
    BOOL isOpened_dpKind;
    BOOL isOpened_shScope;
    BOOL isOpened_low;

}
@property (retain, nonatomic) IBOutlet TableViewWithBlock *dpKind_tableView;
@property (retain, nonatomic) IBOutlet UIButton *dpKind_openButton;
@property (retain, nonatomic) IBOutlet UITextField *dpKind_inputTextField;

@property (retain, nonatomic) IBOutlet TableViewWithBlock *shScope_tableView;
@property (retain, nonatomic) IBOutlet UIButton *shScope_openButton;
@property (retain, nonatomic) IBOutlet UITextField *shScope_inputTextField;

@property (retain, nonatomic) IBOutlet TableViewWithBlock *low_tableView;
@property (retain, nonatomic) IBOutlet UIButton *low_openButton;
@property (retain, nonatomic) IBOutlet UITextField *low_inputTextField;


@property (nonatomic,strong) BAShopType *selectShop;
@property (nonatomic,strong) BACircleModel *selectCicle;
@property (nonatomic,strong) BASendUp *selectSendUp;



@property (nonatomic,strong) NSArray *adsArray;
@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) IBOutlet UIPageControl *pageControl;
@end

@implementation FirstViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.parentViewController.title = @"首页";
}
/*
type	=1         			//商铺种类
send_id=1            			//最低消费
cir_id=1                 			//商圈id
uname=店铺名称			//名称检索时传入
lat=11611111                 		//经度       			必须     小数点后5位然后转换成int
lng=1311111                 		//纬度				必须  小数点后5位然后转换成int
page=1  // 页数
 
 
 BARequestApi *signInApi = [[BARequestApi alloc] initWithMethod:METHOD_login];
 NSDictionary *div = [NSDictionary dictionaryWithObjects:@[self.userName.text,self.passWord.text] forKeys:@[@"tel",@"pwd" ]];
 //    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
 //    [dic setObject:self.userName.text forKey:@"tel"];
 //    [dic setObject:self.passWord.text forKey:@"pwd"];
 
 
 [signInApi additionalParams:div];
 HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:signInApi];
 request.delegate = self;
 [request start];
 

*/
-(IBAction)shopSearch:(id)sender{
    BARequestApi *shopSearchApi = [[BARequestApi alloc] initWithMethod:METHOD_searchshop];
    shopSearchApi.someC = @"shop";
    shopSearchApi.someD = @"shop";
//    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[self.selectShop.typeId,self.selectSendUp.sendUpId,self.selectCicle.circleId,@(0),@(0)] forKeys:@[@"type",@"send_id",@"cir_id",@"lat",@"lng",]];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[@(1),@(1),@(1),@(0),@(0)] forKeys:@[@"type",@"send_id",@"cir_id",@"lat",@"lng",]];

    [shopSearchApi additionalParams:dic];
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:shopSearchApi];
    request.delegate = self;
    request.tag = 102;

    [request start];


}


-(void)setup_dpKindTableView{
    [_dpKind_tableView initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView, NSInteger section) {
        return [BAProfileManager shared].shop_types.count;
        
    } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        SelectionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        BAShopType *shopTyoe =[BAProfileManager shared].shop_types[indexPath.row];
        [cell.lb setText:shopTyoe.name];
        return cell;
        
    } setDidSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
        SelectionCell *cell=(SelectionCell*)[tableView cellForRowAtIndexPath:indexPath];
        _dpKind_inputTextField.text=cell.lb.text;
        self.selectShop = [BAProfileManager shared].shop_types[indexPath.row];
        [_dpKind_openButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        
    }];
    
    [_dpKind_tableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_dpKind_tableView.layer setBorderWidth:2];
    

}
-(void)setup_shScopeTableView{
    NSMutableArray *shScopeArray = [NSMutableArray array];
    [shScopeArray addObjectsFromArray:[BAProfileManager shared].circleList_n];
    [shScopeArray addObjectsFromArray:[BAProfileManager shared].circleList];
    [_shScope_tableView initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView, NSInteger section) {
        return shScopeArray.count;
        
    } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        SelectionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        BACircleModel *circle =shScopeArray[indexPath.row];
        [cell.lb setText:circle.name];
        return cell;
        
    } setDidSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
        SelectionCell *cell=(SelectionCell*)[tableView cellForRowAtIndexPath:indexPath];
        _shScope_inputTextField.text=cell.lb.text;
        self.selectCicle = shScopeArray[indexPath.row];
        [_shScope_openButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        
    }];
    
    [_shScope_tableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_shScope_tableView.layer setBorderWidth:2];
    

}
-(void)setup_lowTableView{
    [_low_tableView initTableViewDataSourceAndDelegate:^NSInteger(UITableView *tableView, NSInteger section) {
        return [BAProfileManager shared].sendUps.count;
        
    } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        SelectionCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SelectionCell"];
        if (!cell) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"SelectionCell" owner:self options:nil]objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        }
        BASendUp *sendUp = [BAProfileManager shared].sendUps[indexPath.row];
        [cell.lb setText:sendUp.money];
        return cell;
        
    } setDidSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
        SelectionCell *cell=(SelectionCell*)[tableView cellForRowAtIndexPath:indexPath];
        _low_inputTextField.text=cell.lb.text;
        self.selectSendUp =[BAProfileManager shared].sendUps[indexPath.row];
        [_low_openButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        
    }];
    
    [_low_tableView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_low_tableView.layer setBorderWidth:2];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    isOpened_dpKind=NO;
    isOpened_shScope=NO;
    isOpened_low=NO;
    [self setup_dpKindTableView];
    [self setup_shScopeTableView];
    [self setup_lowTableView];
    
    UIImage *openImage=[UIImage imageNamed:@"downArrow"];
    [_dpKind_openButton setImage:openImage forState:UIControlStateNormal];
    [_shScope_openButton setImage:openImage forState:UIControlStateNormal];
    [_low_openButton setImage:openImage forState:UIControlStateNormal];

    
    
    BARequestApi *searchadApi = [[BARequestApi alloc] initWithMethod:METHOD_searchad];
    searchadApi.someC = @"util";
    searchadApi.someD = @"util";
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:searchadApi];
    request.tag = 101;
    request.delegate = self;
    [request start];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
}



- (IBAction)changeOpenStatus_dpKind:(id)sender {
    
    if (isOpened_dpKind) {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"downArrow"];
            [_dpKind_openButton setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=_dpKind_tableView.frame;
            
            frame.size.height=1;
            [_dpKind_tableView setFrame:frame];
            
        } completion:^(BOOL finished){
            
            isOpened_dpKind=NO;
        }];
    }else{
        
        
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"upArrow"];
            [_dpKind_openButton setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=_dpKind_tableView.frame;
            
            frame.size.height=200;
            [_dpKind_tableView setFrame:frame];
        } completion:^(BOOL finished){
            
            isOpened_dpKind=YES;
        }];
    }
    
}
- (IBAction)changeOpenStatus_shScope:(id)sender {
    
    if (isOpened_shScope) {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"downArrow"];
            [_shScope_openButton setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=_shScope_tableView.frame;
            
            frame.size.height=1;
            [_shScope_tableView setFrame:frame];
            
        } completion:^(BOOL finished){
            
            isOpened_shScope=NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"upArrow"];
            [_shScope_openButton setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=_shScope_tableView.frame;
            
            frame.size.height=200;
            [_shScope_tableView setFrame:frame];
        } completion:^(BOOL finished){
            isOpened_shScope=YES;
        }];
        
        
    }
    
}
- (IBAction)changeOpenStatus_low:(id)sender {
    
    if (isOpened_low) {
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *closeImage=[UIImage imageNamed:@"downArrow"];
            [_low_openButton setImage:closeImage forState:UIControlStateNormal];
            
            CGRect frame=_low_tableView.frame;
            
            frame.size.height=1;
            [_low_tableView setFrame:frame];
            
        } completion:^(BOOL finished){
            
            isOpened_low=NO;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            UIImage *openImage=[UIImage imageNamed:@"upArrow"];
            [_low_openButton setImage:openImage forState:UIControlStateNormal];
            
            CGRect frame=_low_tableView.frame;
            
            frame.size.height=200;
            [_low_tableView setFrame:frame];
        } completion:^(BOOL finished){
            isOpened_low=YES;
        }];
        
        
    }
    
}

-(void)addAdImageView:(UIImageView *)imageView index:(int)index{
    imageView.size = self.scrollView.size;
    imageView.origin = CGPointMake(index*self.scrollView.size.width, 0);
    [self.scrollView addSubview:imageView];
    self.scrollView.contentSize = CGSizeMake((index+1)*self.scrollView.size.width, 0);
    self.pageControl.numberOfPages = index+1;
}

-(void)loadAds{
//    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i<self.adsArray.count; i++) {
        NSString *urlstring = self.adsArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        @weakify(self);
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlstring] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            @strongify(self);
            if (!error) {
                [self addAdImageView:imageView index:i];
                
            }
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = scrollView.contentOffset.x/scrollView.width;
}


- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    if (asyncer.tag == 101) {
        NSMutableArray *tmpArray = [NSMutableArray array];
        NSArray *tmp = result[@"ab"];
        for (NSDictionary *tmpdic in tmp) {
            NSString *picture = tmpdic[@"picture"];
            NSString *urlString = [NSString stringWithFormat:@"%@/dev_business_user/index.php?c=util&m=download&d=util&file=%@",baseUrl,picture];
            [tmpArray addObject:urlString];
        }
        self.adsArray = [[NSArray alloc] initWithArray:tmpArray];
        [self loadAds];
    }
    if (asyncer.tag ==102) {
        
        NSLog(@"%@",result);

        NSArray *array = [BAShopModel shopModelsWithArray:result[@"shop"]];
        if (array&&array.count>0) {
            BAShopViewController *shopViewController = [[BAShopViewController alloc] initWithNibName:@"BAShopViewController" bundle:nil];
            shopViewController.shops = array;
//
            [self.navigationController pushViewController:shopViewController animated:YES];
            
        }else{
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"没有搜索到任何店铺"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
            [alertView show];

        }
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

@end
