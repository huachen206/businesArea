//
//  BASignUpViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-19.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BASignUpViewController.h"
#import "PALinkButton.h"
#import "QCheckBox.h"
#import "PAWebViewController.h"

static NSUInteger const kTag_VerificationCoder = 100;
static NSUInteger const kTag_register = 101;

@interface BASignUpViewController ()<AsyncDelegate>{
    BOOL smsSuccess;
}
@property (nonatomic,weak) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCode;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

@property (weak,nonatomic) IBOutlet QCheckBox *checkButton;
@property (weak,nonatomic) IBOutlet PALinkButton *agreementButton;


@end

@implementation BASignUpViewController

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
    self.title = @"注册";
    [self.agreementButton addTarget:self action:@selector(gotoAgreement) forControlEvents:UIControlEventTouchUpInside];
}

-(void)gotoAgreement{
    
    PAWebViewController *webVc = [[PAWebViewController alloc] initWithUrl:@"http://115.28.59.82/dev_business_official/index.php/register/register/userregisteragree" showToolBar:NO];
    [self.navigationController pushViewController:webVc animated:YES];
    
}

- (IBAction)signUpAction:(id)sender {
    if (self.userNameTextField.text.length == 0||self.passWordTextField.text.length == 0||self.verifyPasswordTextField.text.length == 0||self.verifyCode.text.length == 0) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"请输入完整的信息"];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView show];
    }else{
        if (!smsSuccess) {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"未成功发送校验码"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
            [alertView show];

        }
        if (![self.verifyPasswordTextField.text isEqualToString:self.passWordTextField.text]) {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"两次密码输入不一致"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
            [alertView show];
        }
        if (self.checkButton.checked == NO) {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"未同意注册协议"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
            [alertView show];

        }
        BARequestApi *api = [[BARequestApi alloc] initWithMethod:METHOD_register];
        HCHTTPRequest *hr = [HCHTTPRequest requestWithAPI:api delegate:self];
        hr.tag =kTag_register;
        [api additionalParams:@{@"tel":self.phoneNumberField.text,@"name":self.userNameTextField.text,@"sms":self.verifyCode.text,@"pwd":self.passWordTextField.text}];
        [hr start];
    }
}
- (IBAction)requestCode:(id)sender {
    if (self.phoneNumberField.text.length !=11) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"请输入完整的手机号码"];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView show];
    }else{
        BARequestApi *api = [[BARequestApi alloc] initWithMethod:METHOD_getsms];
        [api additionalParams:@{@"tel":self.phoneNumberField.text}];
        HCHTTPRequest *hr = [HCHTTPRequest requestWithAPI:api delegate:self];
        hr.tag =kTag_VerificationCoder;
        [hr start];
    }
}

-(IBAction)agreementAction:(id)sender{
    
    
    
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
    if (asyncer.tag == kTag_register) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"注册成功"];
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
