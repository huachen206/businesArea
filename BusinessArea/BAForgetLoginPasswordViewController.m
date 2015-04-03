//
//  BAForgetLoginPasswordViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-26.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAForgetLoginPasswordViewController.h"
static NSUInteger const kTag_VerificationCoder = 100;
static NSUInteger const kTag_FindBackPwd = 101;

@interface BAForgetLoginPasswordViewController ()<AsyncDelegate>{
    BOOL smsSuccess;

}
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;

@end

@implementation BAForgetLoginPasswordViewController

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
    self.navigationBarHidden = NO;
    self.title = @"找回密码";
    
}
- (IBAction)smsAction:(id)sender {
    if (self.phoneNumTextField.text.length !=11) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"请输入完整的手机号码"];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView show];
    }else{
        BARequestApi *api = [[BARequestApi alloc] initWithMethod:METHOD_getsmsbybackpassword];
        [api additionalParams:@{@"tel":self.phoneNumTextField.text}];
        HCHTTPRequest *hr = [HCHTTPRequest requestWithAPI:api delegate:self];
        hr.tag =kTag_VerificationCoder;
        [hr start];

        
    }
}
- (IBAction)findPwdAction:(id)sender {
    if (self.userNameTextField.text.length == 0 || self.phoneNumTextField.text.length == 0 || self.verifyCodeTextField.text.length == 0) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"请输入完整的信息"];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView show];
    }else{
        if (!smsSuccess) {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"未成功发送校验码"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
            [alertView show];
        }
        BARequestApi *api = [[BARequestApi alloc] initWithMethod:METHOD_getbackpassword];
        [api additionalParams:@{@"tel":self.phoneNumTextField.text,@"name":self.userNameTextField.text,@"sms":self.verifyCodeTextField.text}];
        HCHTTPRequest *hr = [HCHTTPRequest requestWithAPI:api delegate:self];
        hr.tag =kTag_FindBackPwd;
        [hr start];
    
    }
    
    
}

- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    if (asyncer.tag == kTag_FindBackPwd) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"找回密码成功"];
        @weakify(self);
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertView show];
        
    }
    if (asyncer.tag == kTag_VerificationCoder) {
        alertInViewController(@"校验码发送成功", nil, PAAlertTypeSuccess);
        smsSuccess = YES;
    }
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFailWithError:(NSError *)error{
    if (asyncer.tag == kTag_VerificationCoder) {
        smsSuccess = NO;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
