//
//  ViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 23/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "ViewController.h"

#import "MainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![[ZASharedClass sharedInstance]isNetworkAvalible])
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:@"Please Check your Network connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        MainViewController * mainViewObj = (MainViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"MainViewController"];
        [self.navigationController pushViewController:mainViewObj animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
