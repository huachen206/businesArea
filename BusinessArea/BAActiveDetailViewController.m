//
//  BAActiveDetailViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-9.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAActiveDetailViewController.h"

@interface BAActiveDetailViewController ()<AsyncDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *recoScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation BAActiveDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)applyAction:(id)sender {
    // 应用：/dev_business_user/index.php?c=activities&m=signup&d=activities
    BARequestApi *signUpActiveApi = [[BARequestApi alloc] initWithMethod:METHOD_signup];
    signUpActiveApi.someC = @"activities";
    signUpActiveApi.someD = @"activities";
    [signUpActiveApi additionalParams:@{@"id":self.activeModel.id}];
    
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:signUpActiveApi];
    request.delegate = self;
    [request start];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"活动报名";
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[self.activeModel.startdate intValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];//直接输出的话是机器码
    [formatter setDateFormat:@"yyyy年mm月dd日"];
    NSString *string = [formatter stringFromDate:date];
    self.dateLabel.text = string;
    self.titleLabel.text = self.activeModel.title;
    self.descriptionTextView.text = self.activeModel.description;
    self.recoScoreLabel.text = self.activeModel.general_sco;

    
}
#pragma mark AsyncerDelegate
- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:result[@"message"]];
    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
    [alertView show];

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
