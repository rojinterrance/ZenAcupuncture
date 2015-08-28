//
//  LoginViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "LoginViewController.h"

#import "RegisterViewController.h"

#import "AccunpunctureViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title= @"ZenAcupuncture";
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem =leftButton;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.emailFeild.text =@"rojin.terrance@spericorn.com";
//    self.passwordFeild.text = @"password";
}
-(IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registerMeAction:(id)sender
{
    RegisterViewController * registerObj = (RegisterViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController pushViewController:registerObj animated:NO];
}

- (IBAction)loginMeAction:(id)sender
{
    if ([self.emailFeild.text length]> 0 && [self.passwordFeild.text length] > 0)
    {
        [[ZASharedClass sharedInstance]showGlobalProgressHUDWithTitle:@"Loading"];
        
        NSString *functionAndFormat =@"&function=authentication&format=xml";
        
        NSString * urlString = [NSString stringWithFormat:@"%@?username=%@&password=%@%@",baseUrl,self.emailFeild.text,self.passwordFeild.text,functionAndFormat];
        
        [[ZASharedClass sharedInstance]fetchDataForLoginDetailsWith:urlString withCompletion:^(BOOL success, NSString *response) {
            
            if (success)
            {
                //NSLog(@"message %@",response);
                
                [ZASharedClass sharedInstance].parserdelegate = self;
                [[ZASharedClass sharedInstance]parseTheXML:response];
            }
            else
            {
                NSLog(@"Failed");
                [[ZASharedClass sharedInstance]dismissGlobalHUD];
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:@"Some thing Went wrong Please try Again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
}
- (void)reloadDataWithResponseDictionary:(NSMutableDictionary*)dictionary
{
    [[ZASharedClass sharedInstance]dismissGlobalHUD];
    
    if([[dictionary valueForKey:@"data"] isEqualToString:@"Success"])
    {
        NSLog(@"login Scuccess");
        
        AccunpunctureViewController * accView = (AccunpunctureViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"AccunpunctureViewController"];
        [self.navigationController pushViewController:accView animated:YES];
    }
    else
    {
        self.emailFeild.text =@"";
        self.passwordFeild.text = @"";

        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:[dictionary valueForKey:@"data"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.emailFeild isFirstResponder])
    {
        [self.emailFeild resignFirstResponder];
        [self.passwordFeild becomeFirstResponder];
    }
    else if ([self.passwordFeild isFirstResponder])
    {
        [self.passwordFeild resignFirstResponder];
    }
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
