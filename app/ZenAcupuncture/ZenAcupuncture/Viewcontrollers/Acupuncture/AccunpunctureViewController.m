//
//  AccunpunctureViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 25/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "AccunpunctureViewController.h"

#import "AddressViewController.h"

@interface AccunpunctureViewController ()

@end

@implementation AccunpunctureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title= @"ZenAcupuncture";
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem =leftButton;
    
    self.genderSegment.selectedSegmentIndex = 1;
    self.lengthSegment.selectedSegmentIndex = 0;
    self.genderStr =@"Either";
    self.lenghtStr=@"60 min";
}
-(IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
}

- (IBAction)nextAction:(id)sender
{
    self.inputFeildsDict = [NSMutableDictionary new];
    
    if([self.dateFeild.text length] > 0  && [self.timeFeild.text length] > 0)
    {
        [self.inputFeildsDict setValue:self.dateFeild.text forKey:@"date"];
        [self.inputFeildsDict setValue:self.timeFeild.text forKey:@"time"];
        [self.inputFeildsDict setValue:self.genderStr forKey:@"gender"];
        [self.inputFeildsDict setValue:self.lenghtStr forKey:@"length"];
        [self.inputFeildsDict setValue:self.notesFeild.text forKey:@"notes"];
        
        NSLog(@"self.inputFeildsDict %@",self.inputFeildsDict);
        
        AddressViewController * addView = (AddressViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"AddressViewController"];
        [addView setInputsDict:self.inputFeildsDict];
        [self.navigationController pushViewController:addView animated:YES];
        
    }
    else{
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:@"Please enter Appointment Date and Time" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
   

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
