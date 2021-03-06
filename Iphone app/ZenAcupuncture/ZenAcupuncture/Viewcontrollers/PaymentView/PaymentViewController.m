//
//  PaymentViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 25/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "PaymentViewController.h"

#import "ConfirmationViewController.h"

@interface PaymentViewController ()<STPPaymentCardTextFieldDelegate>

@property (weak, nonatomic)  STPPaymentCardTextField *paymentTextField;

@end

@implementation PaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=HEADER_TITLE;
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem =leftButton;
    
    NSString *title = [NSString stringWithFormat:@"Pay Bill"];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(addAndContinue:)];
    saveButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    STPPaymentCardTextField *paymentTextField = [[STPPaymentCardTextField alloc] init];
    paymentTextField.delegate = self;
    self.paymentTextField = paymentTextField;
    [self.view addSubview:paymentTextField];
    
    CGFloat padding = 15;
    CGFloat width = CGRectGetWidth(self.view.frame) - (padding * 2);
    self.paymentTextField.frame = CGRectMake(padding, self.cardHolderNameFeild.frame.origin.y + 160, width, 44);
}

-(IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)addAndContinue:(id)sender
{
    [[[ZASharedClass sharedInstance]inputValuesDict]  setValue:self.cardHolderNameFeild.text forKey:@"cardHolderNameFeild"];
    
//    [self proceedForPayment];
    
    if (![self.paymentTextField isValid])
    {
        return;
    }
    if (![Stripe defaultPublishableKey])
    {
        NSError *error = [NSError errorWithDomain:StripeDomain
                                             code:STPInvalidRequestError
                                         userInfo:@{
                                                    NSLocalizedDescriptionKey: @"Please specify a Stripe Publishable Key in Constants.m"
                                                    }];
        NSLog(@"Error %@",[error localizedDescription]);
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    STPCard *card = [[STPCard alloc] init];
    card.number = self.paymentTextField.cardNumber;
    card.expMonth = self.paymentTextField.expirationMonth;
    card.expYear = self.paymentTextField.expirationYear;
    card.cvc = self.paymentTextField.cvc;
  
    [[STPAPIClient sharedClient] createTokenWithCard:card
                                          completion:^(STPToken *token, NSError *error) {
                                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                                              if (error)
                                              {
                                                  NSLog(@"erroe %@",[error localizedDescription]);
                                              }
                                              else
                                              {
                                                  [[[ZASharedClass sharedInstance]inputValuesDict] setValue:token forKey:@"stripeToken"];
                                                  NSLog(@"Tokerns %@",token);
                                                  [self proceedForPayment];
                                            
                                              }
                                              
                                             
                                          }];
    
    
}

- (void)paymentView:(nonnull STPCard *)paymentView withCard:(nonnull STPCard *)card isValid:(BOOL)valid
{
    NSLog(@" valid : %d card %@",valid,card);
}
-(void)proceedForPayment
{
    NSString * appointmentDate = [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"date"];
    NSString *   appointTime = [[[[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"time"] componentsSeparatedByString:@" "] firstObject];
    NSString * therapistGender= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"gender"];
    NSString * sessionLength= [[[ZASharedClass sharedInstance]inputValuesDict]valueForKey:@"length"];
    NSString * note= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"notes"];
    NSString * userId= [[NSUserDefaults standardUserDefaults]valueForKey:@"userId"];
    NSString * addressLabel= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"addressFeild"];
    NSString * isActive= @"1";
    NSString * firstName= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"firstNameFeild"];
    NSString * lastName= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"lastNameFeild"];
    NSString * deliveryAddress = [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"addressFeild"];
    NSString * phone= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"phoneFeild"];
    NSString * isHotel= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"isHotel"];
    NSString * cardHolderName= [[[ZASharedClass sharedInstance]inputValuesDict] valueForKey:@"cardHolderNameFeild"];
    NSString * stripeToken = [[[ZASharedClass sharedInstance]inputValuesDict]valueForKey:@"stripeToken"];
    NSString*acupunctureType = [[NSUserDefaults standardUserDefaults]valueForKey:@"SelectedCategory"];
    
    NSString *functionAndFormat =@"&function=register&format=xml";
    
    NSString * urlString = [NSString stringWithFormat:@"%@?appointmentDate=%@&appointTime=%@&therapistGender=%@&sessionLength=%@&note=%@&userId=%@&acupunctureType=%@&stripeToken=%@&isActive=%@&addressLabel=%@&firstName=%@&lastname=%@&deliveryAddress=%@&phone=%@&isHotel=%@&cardHolderName=%@%@",baseUrl,appointmentDate,appointTime,therapistGender,sessionLength,note,userId,acupunctureType,stripeToken,isActive,addressLabel,firstName,lastName,deliveryAddress,phone,isHotel,cardHolderName,functionAndFormat];
    
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
        [[[ZASharedClass sharedInstance]inputValuesDict]setValue:self.cardHolderNameFeild.text forKey:@"cardHolderNameFeild"];
        [self.paymentTextField becomeFirstResponder];
    }
    
    return YES;
}

- (void)paymentCardTextFieldDidChange:(nonnull STPPaymentCardTextField *)textField {
    self.navigationItem.rightBarButtonItem.enabled = textField.isValid;
}


@end
