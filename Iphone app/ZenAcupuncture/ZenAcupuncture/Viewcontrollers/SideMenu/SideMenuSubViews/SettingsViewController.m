//
//  SettingsViewController.m
//  ZenAcupuncture
//
//  Created by Manoj Kumar on 04/09/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Hamburger"] style:UIBarButtonItemStylePlain target:self action:@selector(hamberAction:)];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:246.0/255.0 green:188.0/255.0 blue:47.0/255.0 alpha:1.0]];
    self.navigationItem.leftBarButtonItem = leftItem;

}

-(void)hamberAction:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
