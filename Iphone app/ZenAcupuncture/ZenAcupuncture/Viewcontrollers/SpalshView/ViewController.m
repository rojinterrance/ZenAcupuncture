//
//  ViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 23/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "ViewController.h"

#import "MainViewController.h"

#import "ApptourViewController.h"

@interface ViewController ()<STPPaymentCardTextFieldDelegate>

@property (weak, nonatomic)  STPPaymentCardTextField *paymentTextField;

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
        NSString *isLoggedIn = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
        if (isLoggedIn.length >0)
        {
            MainViewController * mainViewObj = (MainViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"MainViewController"];
            [self.navigationController pushViewController:mainViewObj animated:YES];
        }
        else
        {
            ApptourViewController *apptourView = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"ApptourViewController"];
            [self.navigationController pushViewController:apptourView animated:YES];
        }
    }
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
