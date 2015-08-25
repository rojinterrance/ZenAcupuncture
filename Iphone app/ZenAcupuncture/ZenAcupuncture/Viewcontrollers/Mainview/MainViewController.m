//
//  MainViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem =leftButton;
    
    self.navigationItem.title= @"ZenAcupuncture";
    
    [self setTapGuesterForImageView];
    
}

-(void)setTapGuesterForImageView
{
    UITapGestureRecognizer *swedishguesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sweedishAction:)];
    [swedishguesture setNumberOfTapsRequired:1];
    [swedishguesture setDelegate:self];
    [self.swedishImage addGestureRecognizer:swedishguesture];
    
    
    UITapGestureRecognizer *deepTissueguesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deepTissueAction:)];
    [deepTissueguesture setNumberOfTapsRequired:1];
    [deepTissueguesture setDelegate:self];
    [self.deepTissueImage addGestureRecognizer:deepTissueguesture];
    
    
    UITapGestureRecognizer *sportsguesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sportsActionAction:)];
    [sportsguesture setNumberOfTapsRequired:1];
    [sportsguesture setDelegate:self];
    [self.sportsImage addGestureRecognizer:sportsguesture];
    
    
    UITapGestureRecognizer *coupleguesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coupleActionAction:)];
    [coupleguesture setNumberOfTapsRequired:1];
    [coupleguesture setDelegate:self];
    [self.coupleImage addGestureRecognizer:coupleguesture];
}

- (void)sweedishAction:(UITapGestureRecognizer *)recognizer
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:@"You have Selected SWEDISH" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];


}

- (void)deepTissueAction:(UITapGestureRecognizer *)recognizer
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:@"You have Selected DEEP TISSUE" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)sportsActionAction:(UITapGestureRecognizer *)recognizer
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:@"You have Selected SPORTS" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}


- (void)coupleActionAction:(UITapGestureRecognizer *)recognizer
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:@"You have Selected COUPLE" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
