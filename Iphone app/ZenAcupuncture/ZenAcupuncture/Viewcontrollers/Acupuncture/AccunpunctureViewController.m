//
//  AccunpunctureViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 25/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "AccunpunctureViewController.h"

#import "AddressViewController.h"

#import "LoginViewController.h"

@interface AccunpunctureViewController ()

@end

@implementation AccunpunctureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title= HEADER_TITLE;
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem =leftButton;
    
    self.genderSegment.selectedSegmentIndex = 1;
    self.lengthSegment.selectedSegmentIndex = 0;
    self.genderStr =@"Either";
    self.lenghtStr=@"60 min";
    
    self.pkrView.hidden = YES;
    
    
    UITapGestureRecognizer * dateAndTimeSelection = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chnageDateAndTime)];
    dateAndTimeSelection.numberOfTapsRequired = 1;
    [self.dateFeild addGestureRecognizer:dateAndTimeSelection];
    [self.timeFeild addGestureRecognizer:dateAndTimeSelection];
}

-(void)chnageDateAndTime
{
    self.pkrView.hidden = NO;
}

-(IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)datePlrClk:(id)sender {
    NSDate *date = _datePkr.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [formatter setDateFormat:@"dd-MM-YYYY HH:mm a"];
    
    _formattedString = [formatter stringFromDate:date];
    NSArray * array = [_formattedString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString * day = [array firstObject];
    
    NSString * time = [array objectAtIndex:1];
    NSString * amorpm = [array lastObject];
    NSString * totalTime = [NSString stringWithFormat:@"%@ %@",time,amorpm];

    
    [self.dateFeild setText:day];
    [self.timeFeild setText:totalTime];
}

- (IBAction)doneClk:(id)sender {
    self.pkrView.hidden = YES;
}

- (IBAction)genderSelectionAction:(id)sender {
    
    switch (self.genderSegment.selectedSegmentIndex)
    {
        case 0:
        {
            self.genderStr =@"Female";
        }
            break;
            
        case 1:
        {
            self.genderStr =@"Either";
        }
            break;
        case 2:
        {
            self.genderStr =@"Male";
        }
            break;
        default:
            break;
    }
    
}

- (IBAction)lengthSelectionAction:(id)sender
{
    switch (self.lengthSegment.selectedSegmentIndex)
    {
        case 0:
        {
            self.lenghtStr=@"60 min";
        }
            break;
            
        case 1:
        {
            self.lenghtStr=@"90 min";
        }
            break;
        case 2:
        {
            self.lenghtStr=@"120 min";
        }
            break;
            
        default:
            break;
    }
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    self.pkrView.hidden =YES;
}

- (IBAction)nextAction:(id)sender
{
    if([self.dateFeild.text length] > 0  && [self.timeFeild.text length] > 0)
    {
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.dateFeild.text forKey:@"date"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.timeFeild.text forKey:@"time"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.genderStr forKey:@"gender"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.lenghtStr forKey:@"length"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.notesFeild.text forKey:@"notes"];
        
        NSLog(@"self.inputFeildsDict %@",[[ZASharedClass sharedInstance]inputValuesDict]);
        
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"userId"] length ] > 0)
        {
            AddressViewController * addView = (AddressViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"AddressViewController"];
            [self.navigationController pushViewController:addView animated:YES];
        }
        else
        {
            [self proceedToLoginScreen];
        }
    }
    else{
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:@"Please enter Appointment Date and Time" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }

    
   }

-(void)proceedToLoginScreen
{
    LoginViewController * loginObj = (LoginViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginObj animated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self chnageDateAndTime];
    return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([self.dateFeild isFirstResponder])
    {
        [self.dateFeild resignFirstResponder];
        [self.timeFeild becomeFirstResponder];
    }
    else if ([self.timeFeild isFirstResponder])
    {
        [self.timeFeild resignFirstResponder];
    }
    else if([self.notesFeild isFirstResponder])
    {
        [self.notesFeild resignFirstResponder];
    }
    
    return YES;
}
@end
