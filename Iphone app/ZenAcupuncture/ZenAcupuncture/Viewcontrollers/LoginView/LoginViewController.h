//
//  LoginViewController.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<ParsedResponseDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *emailFeild;
@property (strong, nonatomic) IBOutlet UITextField *passwordFeild;

- (IBAction)registerMeAction:(id)sender;
- (IBAction)loginMeAction:(id)sender;

@end
