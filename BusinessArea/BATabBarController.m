//
//  BATabBarController.m
//  BusinessArea
//
//  Created by 花晨 on 14-7-12.
//  Copyright (c) 2014年 花晨. All rights reserved.
//

#import "BATabBarController.h"

@interface BATabBarController ()

@end

@implementation BATabBarController

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

    UITabBar *tabBar = self.tabBar;
    [tabBar setTintColor:[UIColor colorWithRed:1.0 green:0 blue:0 alpha:1.0]];
    tabBar.selectedImageTintColor = [UIColor redColor];
    for (UITabBarItem *item in tabBar.items) {
        [item setTitleTextAttributes:[NSDictionary
                                      dictionaryWithObjectsAndKeys: [UIColor lightGrayColor],
                                      UITextAttributeTextColor, nil] forState:UIControlStateNormal];
        [item setTitleTextAttributes:[NSDictionary
                                      dictionaryWithObjectsAndKeys: [UIColor redColor],
                                      UITextAttributeTextColor, nil] forState:UIControlStateHighlighted];
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
