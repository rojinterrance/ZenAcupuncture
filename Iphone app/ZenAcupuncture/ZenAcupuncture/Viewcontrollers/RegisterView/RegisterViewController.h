//
//  RegisterViewController.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<ParsedResponseDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstNameFeild;
@property (strong, nonatomic) IBOutlet UITextField *lastNameFeild;
@property (strong, nonatomic) IBOutlet UITextField *emailFeild;
@property (strong, nonatomic) IBOutlet UITextField *phoneFeild;
@property (strong, nonatomic) IBOutlet UITextField *zipcodeFeild;
@property (strong, nonatomic) IBOutlet UITextField *passwordFeild;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordFeild;
@property (strong, nonatomic) IBOutlet UITextField *promoCodeFeild;

- (IBAction)createAccountAction:(id)sender;
- (IBAction)loginMeAction:(id)sender;
@end
