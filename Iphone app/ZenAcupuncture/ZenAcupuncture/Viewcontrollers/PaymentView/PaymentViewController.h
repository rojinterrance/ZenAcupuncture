//
//  PaymentViewController.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 25/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentViewController : UIViewController<UITextFieldDelegate,ParsedResponseDelegate>

@property (weak, nonatomic) IBOutlet UITextField *cardHolderNameFeild;

- (void)proceedForPayment;
- (IBAction)addAndContinue:(id)sender;
@end
