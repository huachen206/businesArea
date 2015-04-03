//
//  BASigninViewController.h
//  BusinessArea
//
//  Created by 花晨 on 14-7-12.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BABasicViewController.h"

@interface BASigninViewController : BABasicViewController

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@property (weak, nonatomic) IBOutlet UIButton *signIn;
@property (weak, nonatomic) IBOutlet UIButton *signUp;


@end
