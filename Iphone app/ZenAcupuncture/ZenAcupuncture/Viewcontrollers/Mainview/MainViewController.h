//
//  MainViewController.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *swedishImage;
@property (weak, nonatomic) IBOutlet UIImageView *deepTissueImage;
@property (weak, nonatomic) IBOutlet UIImageView *sportsImage;
@property (weak, nonatomic) IBOutlet UIImageView *coupleImage;

@end
