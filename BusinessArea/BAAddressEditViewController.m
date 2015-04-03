//
//  BAAddressEditViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAAddressEditViewController.h"

@interface BAAddressEditViewController ()<AsyncDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *telTextField;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet UISwitch *defaultSwitch;


@end

@implementation BAAddressEditViewController

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

    self.title = @"地址修改";
    if (self.addressModel) {
        self.nameTextField.text = self.addressModel.name;
        self.telTextField.text = self.addressModel.tel;
        self.addressTextView.text = self.addressModel.address;
        self.defaultSwitch.on = (BOOL)[self.addressModel.ustatus boolValue];
    }else{
        self.defaultSwitch.on = NO;
    }

}
- (IBAction)saveAction:(id)sender {
    if (self.nameTextField.text.length == 0 ||self.telTextField.text.length != 11 ||self.addressTextView.text.length == 0) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"请填写完整信息"];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView show];
    }else{
        if (self.addressModel) {
            [self requestApi_modify];
        }else{
            [self requestApi_add];
        }
    }
    
}
- (IBAction)defaultSwitchAction:(id)sender {
    
    
}

-(void)requestApi_modify{
    // 应用：/dev_business_user/index.php?c=user&m=updaddress&d=user
    
    BARequestApi *updaddressApi = [[BARequestApi alloc] initWithMethod:METHOD_updaddress];
    [updaddressApi additionalParams:@{@"id":self.addressModel.id,@"tel":self.telTextField.text,@"name":self.nameTextField.text,@"address":self.addressTextView.text,@"ustatus":[NSNumber numberWithBool:self.defaultSwitch.on]}];
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:updaddressApi];
    request.delegate = self;
    request.tag = 100;
    [request start];

}
-(void)requestApi_add{
    // 应用：/dev_business_user/index.php?c=user&m=saveaddress&d=user
    BARequestApi *updaddressApi = [[BARequestApi alloc] initWithMethod:METHOD_saveaddress];
    [updaddressApi additionalParams:@{@"tel":self.telTextField.text,@"name":self.nameTextField.text,@"address":self.addressTextView.text,@"ustatus":[NSNumber numberWithBool:self.defaultSwitch.on]}];
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:updaddressApi];
    request.delegate = self;
    request.tag = 101;
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
    if (asyncer.tag == 100) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"地址修改成功"];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertView show];
    }else if (asyncer.tag == 101){
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:@"新增地址成功"];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertView show];
    }

}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFailWithError:(NSError *)error{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"温馨提示" andMessage:[error localizedFailureReason]];
    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
    [alertView show];
    
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
