//
//  ApptourViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 03/09/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "ApptourViewController.h"

#import "MainViewController.h"

@interface ApptourViewController ()

@end

@implementation ApptourViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self setScrollViewWithPageControl];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.menuContainerViewController setPanMode:MFSideMenuPanModeNone];
    [super viewWillAppear:animated];
    
    self.skipBtn.hidden = NO;
}

- (IBAction)skipTourAction:(id)sender
{
    MainViewController * mainViewObj = (MainViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"MainViewController"];
    [self.navigationController pushViewController:mainViewObj animated:YES];
}

-(void)setScrollViewWithPageControl
{
    leftSwipe  = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipe.numberOfTouchesRequired = 1;
    [leftSwipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.bannerImage addGestureRecognizer:leftSwipe];
    
    rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipe.numberOfTouchesRequired = 1;
    [rightSwipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.bannerImage addGestureRecognizer:rightSwipe];
    
    currentImage = 1;
    pageControlNum = 0;
    self.bannerImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",currentImage]];
    [self.bannerImage bringSubviewToFront:self.navigationController.view];
    
    self.pageControl.numberOfPages = 5;
    [self.pageControl setCurrentPage:pageControlNum];
}

-(IBAction)rightSwipe:(id)sender
{
    if(currentImage >= 5)
    {
        currentImage = 0;
    }
    currentImage++;
    pageControlNum = currentImage-1;
    self.pageControl.currentPage = pageControlNum;
    [self.bannerImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",currentImage]]];
}

-(IBAction)leftSwipe:(id)sender
{
    if(currentImage <= 1 )
    {
        currentImage = 6;
    }
    
    currentImage--;
    pageControlNum = currentImage -1;
    self.pageControl.currentPage =pageControlNum;
    self.bannerImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",currentImage]];
}

@end
