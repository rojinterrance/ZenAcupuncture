//
//  AddressViewController.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 25/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController<UITextFieldDelegate>
{
    BOOL isHotel;
}

@property(strong, nonatomic) NSMutableDictionary * inputsDict;
@property (strong, nonatomic) IBOutlet UIButton *ishotelBtn;

@property (strong, nonatomic) IBOutlet UITextField *addressFeild;
@property (strong, nonatomic) IBOutlet UITextField *firstNameFeild;
@property (strong, nonatomic) IBOutlet UITextField *lastNameFeild;
@property (strong, nonatomic) IBOutlet UITextField *deliverAddFeild;
@property (strong, nonatomic) IBOutlet UITextField *roomFeild;
@property (strong, nonatomic) IBOutlet UITextField *cityFeild;
@property (strong, nonatomic) IBOutlet UITextField *stateFeild;
@property (strong, nonatomic) IBOutlet UITextField *zipCodefeild;
@property (strong, nonatomic) IBOutlet UITextField *phoneFeild;
@property (strong, nonatomic) IBOutlet UITextField *parkingFeild;

- (IBAction)isHotelAction:(id)sender;
- (IBAction)addAndContinueAction:(id)sender;

@end
