//
//  ApptourViewController.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 03/09/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApptourViewController : UIViewController
{
    int currentImage;
    int pageControlNum;
    
    UISwipeGestureRecognizer *rightSwipe;
    UISwipeGestureRecognizer *leftSwipe;
}
//Page Control
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;
@property(nonatomic, strong) IBOutlet UIImageView * bannerImage;
@property(nonatomic, strong) IBOutlet UIPageControl *pageControl;


- (IBAction)skipTourAction:(id)sender;

-(IBAction)rightSwipe:(id)sender;
-(IBAction)leftSwipe:(id)sender;
@end
