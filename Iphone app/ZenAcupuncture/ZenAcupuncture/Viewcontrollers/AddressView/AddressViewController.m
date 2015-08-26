//
//  AddressViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 25/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "AddressViewController.h"

#import "PaymentViewController.h"

@interface AddressViewController ()

@end

@implementation AddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title= @"ZenAcupuncture";
    
    isHotel = YES;
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem =leftButton;
}
-(IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)isHotelAction:(id)sender
{
    if (isHotel)
    {
        isHotel= NO;
        [self.ishotelBtn setImage:[UIImage imageNamed:@"Unchecked.png"] forState:UIControlStateNormal];
    }
    else
    {
        isHotel= YES;
        [self.ishotelBtn setImage:[UIImage imageNamed:@"Checked.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)addAndContinueAction:(id)sender
{
    NSLog(@"inputs %@",self.inputsDict);
    
    NSString * hotelStr;
    
    if (isHotel)
    {
        hotelStr = @"YES";
    }
    else
    {
        hotelStr = @"NO";
    }
    
    if ([self.addressFeild.text length] > 0  &&  [self.firstNameFeild.text length] > 0 )
    {
        [self.inputsDict setValue: self.addressFeild.text forKey:@"addressFeild"];
        [self.inputsDict setValue: self.firstNameFeild.text forKey:@"firstNameFeild"];
        [self.inputsDict setValue:self.lastNameFeild.text forKey:@"lastNameFeild"];
        [self.inputsDict setValue:self.deliverAddFeild.text forKey:@"deliverAddFeild"];
        [self.inputsDict setValue: self.roomFeild.text forKey:@"roomFeild"];
        [self.inputsDict setValue:self.cityFeild.text forKey:@"cityFeild"];
        [self.inputsDict setValue:self.stateFeild.text forKey:@"stateFeild"];
        [self.inputsDict setValue:self.zipCodefeild.text forKey:@"zipCodefeild"];
        [self.inputsDict setValue:self.phoneFeild.text forKey:@"phoneFeild"];
        [self.inputsDict setValue:self.parkingFeild.text forKey:@"parkingFeild"];
        [self.inputsDict setValue:hotelStr forKey:@"isHotel"];
        
        PaymentViewController * paymentView = (PaymentViewController*) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"PaymentViewController"];
        [paymentView setInputFeildsDict:self.inputsDict];
        [self.navigationController pushViewController:paymentView animated:YES];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:@"Please enter Address and First name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([self.addressFeild isFirstResponder])
    {
        [self.addressFeild resignFirstResponder];
        [self.firstNameFeild becomeFirstResponder];
    }
    else if ([self.firstNameFeild isFirstResponder])
    {
        [self.firstNameFeild resignFirstResponder];
        [self.lastNameFeild becomeFirstResponder];
    }
    else if ([self.lastNameFeild isFirstResponder])
    {
        [self.lastNameFeild resignFirstResponder];
        [self.deliverAddFeild becomeFirstResponder];
    }
    else if ([self.deliverAddFeild isFirstResponder])
    {
        [self.deliverAddFeild resignFirstResponder];
        [self.roomFeild becomeFirstResponder];
    }
    else if ([self.roomFeild isFirstResponder])
    {
        [self.roomFeild resignFirstResponder];
        [self.cityFeild becomeFirstResponder];
    }
    else if ([self.cityFeild isFirstResponder])
    {
        [self.cityFeild resignFirstResponder];
        [self.stateFeild becomeFirstResponder];
    }
    else if ([self.stateFeild isFirstResponder])
    {
        [self.stateFeild resignFirstResponder];
        [self.zipCodefeild becomeFirstResponder];
    }
    else if ([self.zipCodefeild isFirstResponder])
    {
        [self.zipCodefeild resignFirstResponder];
        [self.phoneFeild becomeFirstResponder];
    }
    else if ([self.phoneFeild isFirstResponder])
    {
        [self.phoneFeild resignFirstResponder];
        [self.parkingFeild becomeFirstResponder];
    }
    else if ([self.parkingFeild isFirstResponder])
    {
        [self.parkingFeild resignFirstResponder];
    }
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
