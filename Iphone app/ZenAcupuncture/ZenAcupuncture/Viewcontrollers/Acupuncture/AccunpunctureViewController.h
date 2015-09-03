//
//  AccunpunctureViewController.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 25/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccunpunctureViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic, strong) NSString * genderStr;
@property(nonatomic, strong) NSString * lenghtStr;

@property (strong, nonatomic) IBOutlet UITextField *dateFeild;
@property (strong, nonatomic) IBOutlet UITextField *timeFeild;
@property (strong, nonatomic) IBOutlet UITextField *notesFeild;
@property (strong, nonatomic) IBOutlet UISegmentedControl *genderSegment;
@property (strong, nonatomic) IBOutlet UISegmentedControl *lengthSegment;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *barBtnDone;
@property (strong, nonatomic) IBOutlet UIView *pkrView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePkr;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) NSString * formattedString;
@property (nonatomic, strong) NSString * timeString;

- (IBAction)datePlrClk:(id)sender;
- (IBAction)doneClk:(id)sender;

- (IBAction)genderSelectionAction:(id)sender;
- (IBAction)lengthSelectionAction:(id)sender;
- (IBAction)nextAction:(id)sender;

@end
