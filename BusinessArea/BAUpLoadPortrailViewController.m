//
//  BAUpLoadPortrailViewController.m
//  BusinessArea
//
//  Created by 花晨 on 14-8-10.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BAUpLoadPortrailViewController.h"
#import "QCheckBox.h"
#import "PAImageProcessHelper.h"
@interface BAUpLoadPortrailViewController ()<UINavigationControllerDelegate ,UIImagePickerControllerDelegate,UIActionSheetDelegate,AsyncDelegate,QCheckBoxDelegate>
@property (weak, nonatomic) IBOutlet QCheckBox *maleCheckButton;
@property (weak, nonatomic) IBOutlet QCheckBox *femaleCheckButton;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@end

@implementation BAUpLoadPortrailViewController

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
    self.title = @"修改头像";
    self.backImageView.layer.masksToBounds = YES;
    self.backImageView.layer.cornerRadius = self.backImageView.height/2;
    
    self.maleCheckButton.delegate = self;
    self.femaleCheckButton.delegate = self;
    
}

-(void)requestApiWithImage:(UIImage *)image{
    // 应用：/dev_business_user/index.php?c=user&m=upload&d=user
    UIImage *smallImage = [PAImageProcessHelper adjustImageForAvatatUpload:image size:CGSizeMake(300, 300)];

    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.5);
    NSData *base64data = [imageData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSString *base64String = [imageData base64Encoding];

    
    BARequestApi *signUpActiveApi = [[BARequestApi alloc] initWithMethod:METHOD_upload];
    [signUpActiveApi additionalParams:@{@"portrait":imageData}];
    
    HCHTTPRequest *request = [[HCHTTPRequest alloc] initWithAPI:signUpActiveApi];
    request.delegate = self;
    request.tag = 100;
    [request start];

}

- (IBAction)upLoadAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    
    [actionSheet showInView:self.view];
}
- (IBAction)compeletAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"您没有摄像头"];
            [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
            [alertView show];
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        [self presentImagePickerWithSourceType:sourceType];


    }else if(buttonIndex == 1){
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentImagePickerWithSourceType:sourceType];
    }
}
- (void)presentImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    if (sourceType == UIImagePickerControllerSourceTypeCamera) {
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
	UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.backImageView setImage:image];
    [self requestApiWithImage:image];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    if ([UIApplication sharedApplication].statusBarHidden == YES) {
    //        [UIApplication sharedApplication].statusBarHidden =NO;
    //    }
//    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark AsyncerDelegate
- (void)asyncerDidStart:(HCBasicAsyncer *)asyncer{
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFinishWithResult:(id)result{
    if (asyncer.tag == 100) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:result[@"message"]];
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView show];

    }
    
}
- (void)asyncer:(HCBasicAsyncer *)asyncer didFailWithError:(NSError *)error{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"" andMessage:[error localizedFailureReason]];
    [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
    [alertView show];
    
}

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked{
    if (checkbox == self.maleCheckButton) {
        self.femaleCheckButton.checked = !self.maleCheckButton.checked;
    }else{
        self.maleCheckButton.checked  = !self.femaleCheckButton.checked;
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
