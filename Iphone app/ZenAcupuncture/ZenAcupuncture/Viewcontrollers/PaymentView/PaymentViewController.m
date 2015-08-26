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
    
//    self.cardNumberFeild.text =@"5105105105105100";
//    self.cvvFeild.text =@"123";
    
    self.navigationItem.title= @"ZenAcupuncture";
    
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
        [ self.inputFeildsDict setValue:self.cardHolderNameFeild.text forKey:@"cardHolderNameFeild"];
        [self.inputFeildsDict setValue:self.cardNumberFeild.text forKey:@"cardNumberFeild"];
        [self.inputFeildsDict setValue:self.cvvFeild.text forKey:@"cvvFeild"];
        [self.inputFeildsDict setValue:self.monthFeild.text forKey:@"monthFeild"];
        [self.inputFeildsDict setValue: self.yearFeild.text forKey:@"yearFeild"];
        [self.inputFeildsDict setValue:self.billingAddres.text forKey:@"billingAddres"];
        [self.inputFeildsDict setValue:self.cityFeild.text forKey:@"cityFeild"];
        [self.inputFeildsDict setValue:self.billingStateFeild.text forKey:@"billingStateFeild"];
        [self.inputFeildsDict setValue:self.billingZipCodeFeild.text forKey:@"billingZipCodeFeild"];
        
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
    NSString * appointmentDate = [self.inputFeildsDict valueForKey:@"date"];
    NSString * appointTime= [self.inputFeildsDict valueForKey:@"time"];
    NSString * therapistGender= [self.inputFeildsDict valueForKey:@"gender"];
    NSString * sessionLength= [self.inputFeildsDict valueForKey:@"length"];
    NSString * note= [self.inputFeildsDict valueForKey:@"notes"];
#warning teja Check  *** userId
    NSString * userId= @"1";
    NSString * addressLabel= [self.inputFeildsDict valueForKey:@"addressFeild"];
    NSString * isActive= @"1";
    NSString * firstName= [self.inputFeildsDict valueForKey:@"firstNameFeild"];
    NSString * lastName= [self.inputFeildsDict valueForKey:@"lastNameFeild"];
    NSString * deliveryAddress = [self.inputFeildsDict valueForKey:@"addressFeild"];
    NSString * apt_suit_room= [self.inputFeildsDict valueForKey:@"roomFeild"];
    NSString * city= [self.inputFeildsDict valueForKey:@"cityFeild"];
    NSString * state= [self.inputFeildsDict valueForKey:@"stateFeild"];
    NSString * zip= [self.inputFeildsDict valueForKey:@"zipCodeFeild"];
    NSString * phone= [self.inputFeildsDict valueForKey:@"phoneFeild"];
    NSString * parkingInstruction = [self.inputFeildsDict valueForKey:@"parkingFeild"];
    NSString * isHotel= [self.inputFeildsDict valueForKey:@"isHotel"];
#warning teja Check  **** dateAdded, dateModified
    NSString * dateAdded= [self.inputFeildsDict valueForKey:@"date"];
    NSString * dateModified= @"dateModified";
    
    NSString * cardHolderName= [self.inputFeildsDict valueForKey:@"cardHolderNameFeild"];
    NSString * cardNumber= [self.inputFeildsDict valueForKey:@"cardNumberFeild"];
    NSString * billingAddress= [self.inputFeildsDict valueForKey:@"billingAddres"];
    NSString * billingCity= [self.inputFeildsDict valueForKey:@"cityFeild"];
    NSString * billingState= [self.inputFeildsDict valueForKey:@"billingStateFeild"];
    NSString * billingZip= [self.inputFeildsDict valueForKey:@"billingZipCodeFeild"];
    
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
