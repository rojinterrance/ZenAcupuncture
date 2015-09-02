//
//  MainViewController.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSString * userIdStr;
@property (weak, nonatomic) IBOutlet UIImageView *acupressureImage;
@property (weak, nonatomic) IBOutlet UIImageView *cuppingImage;
@property (weak, nonatomic) IBOutlet UIImageView *acupunctureImage;

@end
