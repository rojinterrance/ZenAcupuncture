//
//  AddressViewController.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 25/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL isHotel;
    BOOL isTableShown;
}
@property (strong, nonatomic) IBOutlet UIButton *ishotelBtn;
@property (strong, nonatomic) IBOutlet UITextField *addressFeild;
@property (strong, nonatomic) IBOutlet UITextField *firstNameFeild;
@property (strong, nonatomic) IBOutlet UITextField *lastNameFeild;
@property (strong, nonatomic) IBOutlet UITextField *phoneFeild;

- (IBAction)isHotelAction:(id)sender;
- (IBAction)addAndContinueAction:(id)sender;

@property(nonatomic, strong) IBOutlet UIView * smallView;
@property (strong, nonatomic) IBOutlet UITableView * locationTable;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barBtnDone;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;

- (IBAction)doneClk:(id)sender;

@end
