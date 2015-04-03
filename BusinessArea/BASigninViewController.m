//
//  BASigninViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-12.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BASigninViewController.h"
#import "BATabBarController.h"
#import "BABasicNavigationController.h"
#import "AppDelegate.h"
#import "BAUserInfoManager.h"
#import "BACityChooseTableViewController.h"
#import "HCDiskCache.h"
#import "BACityListModel.h"
#import "QCheckBox.h"
@interface BASigninViewController ()<AsyncDelegate,QCheckBoxDelegate>
@property (nonatomic,weak) IBOutlet QCheckBox *checkButton;
@property (nonatomic,assign) BOOL autoSignin;
@end

@implementation BASigninViewController

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
    self.navigationBarHidden = YES;
    
    self.autoSignin = [[[HCDiskCache shared] objectForKey:@"isAtuoSignin"] boolValue];
    if (self.autoSignin) {
        self.userName.text = [[HCDiskCache shared] objectForKey:@"userName"];
        self.passWord.text = [[HCDiskCache shared] objectForKey:@"passWord"];
        
//        [self signIn:nil];
        
    }
    
    self.userName.text = @"13898189131";
    self.passWord.text = @"1111";

    self.checkButton.checked = self.autoSignin;
    self.checkButton.delegate = self;
    
    
    BACityListModel *cityLocationModel = [[HCDiskCache shared] objectForKey:KEY_CITYCHOOSEDNAME];
//    [self presentcityChoose];

    if (cityLocationModel) {
        
    }else{
        [self presentcityChoose];
    }
}
-(void)viewWillAppear:(BOOL)animated{
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)presentcityChoose{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    BACityChooseTableViewController *cityVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"cityChoose"];
    BABasicNavigationController *bnc = [[BABasicNavigationController alloc] initWithRootViewController:cityVC];
    [self presentViewController:bnc animated:YES completion:^{
        
    }];
    
}


- (IBAction)signIn:(id)sender {
    BARequestApi *signInApi = [[BARequestApi alloc] initWithMethod:METHOD_login];
    NSDictionary *div = [NSDictionary dictionaryWithObjects:@[self.userName.text,self.passWord.text] forKeys:@[@"tel",@"pwd" ]];
    
    [signInApi additionalParams:div];
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:signInApi];
    request.delegate = self;
    [request start];
    
}


-(void)gotoMainView{
    if (self.checkButton.checked) {
        [[HCDiskCache shared] addObject:self.userName.text key:@"userName"];
        [[HCDiskCache shared] addObject:self.passWord.text key:@"passWord"];
        [[HCDiskCache shared] addObject:@(self.checkButton.checked) key:@"isAtuoSignin"];
    }


    
    
    UIStoryboard *homePageStoryboard = [UIStoryboard storyboardWithName:@"HomePage" bundle:nil];
    BABasicNavigationController *mainNavigationController = [homePageStoryboard instantiateViewControllerWithIdentifier:@"mainNavigationController"];
    [(AppDelegate *)[UIApplication sharedApplication].delegate window].rootViewController = mainNavigationController;
    [[(AppDelegate *)[UIApplication sharedApplication].delegate window] makeKeyAndVisible];
    
    
//    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BATabBarController"];
//    [self.navigationController pushViewController:viewController animated:YES];

    
}
- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
//    if ([result[@"ret"] intValue] == 200) {
        [BAUserInfoManager share].authToken = result[@"token"];
        BAUserInfo *userInfo = [[BAUserInfo alloc] initWithDic:result];
        userInfo.phoneNumber = self.userName.text;
        [BAUserInfoManager share].userInfo = userInfo;
        [self gotoMainView];

//    }else{
//        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:result[@"message"]];
//        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
//        [alertView show];
//    }
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFailWithError:(NSError *)error{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:[error localizedFailureReason]];
    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
    [alertView show];

}

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked{
    self.checkButton.checked = checked;
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
