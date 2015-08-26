//
//  PaymentViewController.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 25/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentViewController : UIViewController<UITextFieldDelegate,ParsedResponseDelegate>

@property (strong, nonatomic) NSMutableDictionary * inputFeildsDict;
@property (weak, nonatomic) IBOutlet UITextField *cardHolderNameFeild;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberFeild;
@property (weak, nonatomic) IBOutlet UITextField *cvvFeild;
@property (weak, nonatomic) IBOutlet UITextField *monthFeild;
@property (weak, nonatomic) IBOutlet UITextField *yearFeild;
@property (weak, nonatomic) IBOutlet UITextField *billingAddres;
@property (weak, nonatomic) IBOutlet UITextField *cityFeild;
@property (weak, nonatomic) IBOutlet UITextField *billingStateFeild;
@property (weak, nonatomic) IBOutlet UITextField *billingZipCodeFeild;

- (void)proceedForPayment;
- (IBAction)addAndContinue:(id)sender;
@end
