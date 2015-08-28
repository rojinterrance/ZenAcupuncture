//
//  AccunpunctureViewController.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 25/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccunpunctureViewController : UIViewController<UITextFieldDelegate>

@property(nonatomic, strong) NSMutableDictionary *inputFeildsDict;
@property(nonatomic, strong) NSString * genderStr;
@property(nonatomic, strong) NSString * lenghtStr;

@property (strong, nonatomic) IBOutlet UITextField *dateFeild;
@property (strong, nonatomic) IBOutlet UITextField *timeFeild;
@property (strong, nonatomic) IBOutlet UITextField *notesFeild;
@property (strong, nonatomic) IBOutlet UISegmentedControl *genderSegment;
@property (strong, nonatomic) IBOutlet UISegmentedControl *lengthSegment;

- (IBAction)genderSelectionAction:(id)sender;
- (IBAction)lengthSelectionAction:(id)sender;
- (IBAction)nextAction:(id)sender;

@end
