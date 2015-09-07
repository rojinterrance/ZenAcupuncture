//
//  MainViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "MainViewController.h"

#import "AccunpunctureViewController.h"

#import "PreviousOrdersViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.menuContainerViewController setPanMode:MFSideMenuPanModeDefault];

    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [image setImage:[UIImage imageNamed:@"background.png"]];
    [image setAlpha:0.3];
    [self.view addSubview:image];
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem =leftButton;

    self.navigationItem.title= HEADER_TITLE;
    
    [self setTapGuesterForImageView];
    
    [self.acupressureImage.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.acupressureImage.layer setBorderWidth: 2.0];
    
    [self.cuppingImage.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.cuppingImage.layer setBorderWidth: 2.0];
    
    [self.acupunctureImage.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.acupunctureImage.layer setBorderWidth: 2.0];

    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Hamburger"] style:UIBarButtonItemStylePlain target:self action:@selector(hamberAction:)];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:246.0/255.0 green:188.0/255.0 blue:47.0/255.0 alpha:1.0]];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(IBAction)hamberAction:(id)sender
{
 [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;

    self.userIdStr = [[NSUserDefaults standardUserDefaults]valueForKey:@"userId"];
    
    if (self.userIdStr.length > 0)
    {
        UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Appointments.png"]  style:UIBarButtonItemStylePlain target:self action:@selector(myBookings:)];
        self.navigationItem.rightBarButtonItem =rightButton;
    }
}

-(IBAction)myBookings:(id)sender
{
    PreviousOrdersViewController * previous = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"PreviousOrdersViewController"];
    
    [self.navigationController pushViewController:previous animated:YES];
}


-(void)setTapGuesterForImageView
{
    UITapGestureRecognizer *acupressureguesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(acupressureguestureAction:)];
    [acupressureguesture setNumberOfTapsRequired:1];
    [acupressureguesture setDelegate:self];
    [self.acupressureImage addGestureRecognizer:acupressureguesture];
    
    
    UITapGestureRecognizer *cuppingguesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cuppingguestureAction:)];
    [cuppingguesture setNumberOfTapsRequired:1];
    [cuppingguesture setDelegate:self];
    [self.cuppingImage addGestureRecognizer:cuppingguesture];
    
    
    UITapGestureRecognizer *acupunctureguesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(acupunctureguestureAction:)];
    [acupunctureguesture setNumberOfTapsRequired:1];
    [acupunctureguesture setDelegate:self];
    [self.acupunctureImage addGestureRecognizer:acupunctureguesture];

}

- (void)acupressureguestureAction:(UITapGestureRecognizer *)recognizer
{
    [[NSUserDefaults standardUserDefaults]setValue:@"Acupressure" forKey:@"SelectedCategory"];

    [self proceedToAppointmentScreen];
}

- (void)cuppingguestureAction:(UITapGestureRecognizer *)recognizer
{
    [[NSUserDefaults standardUserDefaults]setValue:@"Cupping" forKey:@"SelectedCategory"];
   [self proceedToAppointmentScreen];
}

- (void)acupunctureguestureAction:(UITapGestureRecognizer *)recognizer
{
    [[NSUserDefaults standardUserDefaults]setValue:@"Cupuncture" forKey:@"SelectedCategory"];
    [self proceedToAppointmentScreen];
}

-(void)proceedToAppointmentScreen
{
    AccunpunctureViewController * appObj = (AccunpunctureViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"AccunpunctureViewController"];
    [self.navigationController pushViewController:appObj animated:YES];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
