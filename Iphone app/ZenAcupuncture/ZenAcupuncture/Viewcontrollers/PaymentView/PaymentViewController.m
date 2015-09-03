//
//  PaymentViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 25/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "PaymentViewController.h"

#import "ConfirmationViewController.h"

@interface PaymentViewController ()

@end

@implementation PaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cardNumberFeild.text =@"5105105105105100";
    self.cvvFeild.text =@"123";
    
    self.navigationItem.title=HEADER_TITLE;
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem =leftButton;
}

-(IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)addAndContinue:(id)sender
{
    if ([self.cardNumberFeild.text length] > 0 && [self.cvvFeild.text length] >  0 && [self.monthFeild.text length]> 0 && [self.yearFeild.text length] > 0)
    {
        [[[ZASharedClass sharedInstance]inputValuesDict]  setValue:self.cardHolderNameFeild.text forKey:@"cardHolderNameFeild"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.cardNumberFeild.text forKey:@"cardNumberFeild"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.cvvFeild.text forKey:@"cvvFeild"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.monthFeild.text forKey:@"monthFeild"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue: self.yearFeild.text forKey:@"yearFeild"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.billingAddres.text forKey:@"billingAddres"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.cityFeild.text forKey:@"cityFeild"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.billingStateFeild.text forKey:@"billingStateFeild"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.billingZipCodeFeild.text forKey:@"billingZipCodeFeild"];
        
        // NSLog(@"inputFeildsDict :%@",self.inputFeildsDict);
        
        [self proceedForPayment];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:@"Please enter all the feilds" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];

    }
}

-(void)proceedForPayment
{
    NSString * appointmentDate = [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"date"];
    NSString * appointTime= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"time"];
    NSString * therapistGender= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"gender"];
    NSString * sessionLength= [[[ZASharedClass sharedInstance]inputValuesDict]valueForKey:@"length"];
    NSString * note= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"notes"];
#warning teja Check  *** userId
    NSString * userId= @"1";
    NSString * addressLabel= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"addressFeild"];
    NSString * isActive= @"1";
    NSString * firstName= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"firstNameFeild"];
    NSString * lastName= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"lastNameFeild"];
    NSString * deliveryAddress = [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"addressFeild"];
    NSString * apt_suit_room= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"roomFeild"];
    NSString * city= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"cityFeild"];
    NSString * state= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"stateFeild"];
    NSString * zip= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"zipCodeFeild"];
    NSString * phone= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"phoneFeild"];
    NSString * parkingInstruction = [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"parkingFeild"];
    NSString * isHotel= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"isHotel"];
#warning teja Check  **** dateAdded, dateModified
    NSString * dateAdded= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"date"];
    NSString * dateModified= @"dateModified";
    
    NSString * cardHolderName= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"cardHolderNameFeild"];
    NSString * cardNumber= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"cardNumberFeild"];
    NSString * billingAddress= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"billingAddres"];
    NSString * billingCity= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"cityFeild"];
    NSString * billingState= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"billingStateFeild"];
    NSString * billingZip= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"billingZipCodeFeild"];
    
    NSString *functionAndFormat =@"&function=register&format=xml";
    
    NSString * urlString = [NSString stringWithFormat:@"%@?appointmentDate=%@&appointTime=%@&therapistGender=%@&sessionLength=%@&note=%@&userId=%@&addressLabel=%@&isActive=%@&firstName=%@&lastName=%@&deliveryAddress=%@&apt_suit_room=%@&city=%@&state=%@&zip=%@&phone=%@&parkingInstruction=%@&isHotel=%@&dateAdded=%@&dateModified=%@&cardHolderName=%@&cardNumber=%@&billingAddress=%@&billingCity=%@&billingState=%@&billingZip=%@%@",baseUrl,appointmentDate,appointTime,therapistGender,sessionLength,note,userId,addressLabel,isActive,firstName,lastName,deliveryAddress,apt_suit_room,city,state,zip,phone,parkingInstruction,isHotel,dateAdded,dateModified,cardHolderName,cardNumber,billingAddress,billingCity,billingState,billingZip,functionAndFormat];
    
    [[ZASharedClass sharedInstance]showGlobalProgressHUDWithTitle:@"Loading"];
    
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
- (void)reloadDataWithResponseDictionary:(NSMutableDictionary*)dictionary
{
    [[ZASharedClass sharedInstance]dismissGlobalHUD];

    
    if([[dictionary valueForKey:@"data"] isEqualToString:@"Success"])
    {
        NSLog(@"login Scuccess");
        ConfirmationViewController  *confirmation = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"ConfirmationViewController"];
        [self.navigationController pushViewController:confirmation animated:YES];
    }
    else
    {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:[dictionary valueForKey:@"data"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self.cardHolderNameFeild isFirstResponder])
    {
        [self.cardHolderNameFeild resignFirstResponder];
        [self.cardNumberFeild becomeFirstResponder];
    }
    else if ([self.cardNumberFeild isFirstResponder])
    {
        [self.cardNumberFeild resignFirstResponder];
        [self.cvvFeild becomeFirstResponder];
    }
    else if ([self.cvvFeild isFirstResponder])
    {
        [self.cvvFeild resignFirstResponder];
        [self.monthFeild becomeFirstResponder];
    }
    else if ([self.monthFeild isFirstResponder])
    {
        [self.monthFeild resignFirstResponder];
        [self.yearFeild becomeFirstResponder];
    }
    else if ([self.yearFeild isFirstResponder])
    {
        [self.yearFeild resignFirstResponder];
        [self.billingAddres becomeFirstResponder];
    }
    else if ([self.billingAddres isFirstResponder])
    {
        [self.billingAddres resignFirstResponder];
        [self.cityFeild becomeFirstResponder];
    }
    else if ([self.cityFeild isFirstResponder])
    {
        [self.cityFeild resignFirstResponder];
        [self.billingStateFeild becomeFirstResponder];
    }
    else if ([self.billingStateFeild isFirstResponder])
    {
        [self.billingStateFeild resignFirstResponder];
        [self.billingZipCodeFeild becomeFirstResponder];
    }
    else if ([self.billingZipCodeFeild isFirstResponder])
    {
        [self.billingZipCodeFeild resignFirstResponder];
    }
    
    return YES;
}
@end
