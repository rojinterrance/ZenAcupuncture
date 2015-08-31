//
//  RegisterViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "RegisterViewController.h"

#import "LoginViewController.h"

#import "AccunpunctureViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=HEADER_TITLE;
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem =leftButton;
}

-(IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)createAccountAction:(id)sender
{
    if ([self.firstNameFeild.text length]> 0 && [self.lastNameFeild.text length] > 0 && [self.emailFeild.text length] > 0)
    {
        if([self.passwordFeild.text isEqualToString:self.confirmPasswordFeild.text])
        {
            [[ZASharedClass sharedInstance]showGlobalProgressHUDWithTitle:@"Loading"];
            
            NSString *functionAndFormat =@"&function=signup&format=xml";
            
            NSString * urlString = [NSString stringWithFormat:@"%@?firstName=%@&lastName=%@&email=%@&phone=%@&zip=%@&password=%@&promocode=%@%@",baseUrl,self.firstNameFeild.text,self.lastNameFeild.text,self.emailFeild.text,self.phoneFeild.text,self.zipcodeFeild.text,self.passwordFeild.text,self.promoCodeFeild.text,functionAndFormat];
            
            [[ZASharedClass sharedInstance]fetchDataForLoginDetailsWith:urlString withCompletion:^(BOOL success, NSString *response) {
                
                if (success)
                {
                    NSLog(@"message %@",response);
                    
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
        else
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:@"Please Enter same Password and Confirm Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    
}

- (IBAction)loginMeAction:(id)sender
{
    LoginViewController * loginObj = (LoginViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginObj animated:NO];
}
- (void)reloadDataWithResponseDictionary:(NSMutableDictionary*)dictionary
{
    NSLog(@"dic %@",dictionary);
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    if ([self.firstNameFeild isFirstResponder])
    {
        [self.firstNameFeild resignFirstResponder];
        [self.lastNameFeild becomeFirstResponder];
    }
    else if ([self.lastNameFeild isFirstResponder])
    {
        [self.lastNameFeild resignFirstResponder];
        [self.emailFeild becomeFirstResponder];
    }
    else if ([self.emailFeild isFirstResponder])
    {
        [self.emailFeild resignFirstResponder];
        [self.phoneFeild becomeFirstResponder];
    }
    else if ([self.phoneFeild isFirstResponder])
    {
        [self.phoneFeild resignFirstResponder];
        [self.zipcodeFeild becomeFirstResponder];
    }
    else if ([self.zipcodeFeild isFirstResponder])
    {
        [self.zipcodeFeild resignFirstResponder];
        [self.passwordFeild becomeFirstResponder];
    }
    else if ([self.passwordFeild isFirstResponder])
    {
        [self.passwordFeild resignFirstResponder];
        [self.confirmPasswordFeild becomeFirstResponder];
    }
    else if ([self.confirmPasswordFeild isFirstResponder])
    {
        [self.confirmPasswordFeild resignFirstResponder];
        [self.promoCodeFeild becomeFirstResponder];
    }
    else if ([self.promoCodeFeild isFirstResponder])
    {
        [self.promoCodeFeild resignFirstResponder];
    }
    
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
