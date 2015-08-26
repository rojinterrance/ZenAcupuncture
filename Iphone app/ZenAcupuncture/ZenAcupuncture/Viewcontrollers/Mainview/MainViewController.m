//
//  MainViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 24/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "MainViewController.h"

#import "LoginViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [image setImage:[UIImage imageNamed:@"background.png"]];
    [image setAlpha:0.3];
    [self.view addSubview:image];
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem =leftButton;
    
    self.navigationItem.title= @"ZenAcupuncture";
    
    [self setTapGuesterForImageView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    [self proceedToLoginScreen];
}

- (void)cuppingguestureAction:(UITapGestureRecognizer *)recognizer
{
    [[NSUserDefaults standardUserDefaults]setValue:@"Cupping" forKey:@"SelectedCategory"];
    [self proceedToLoginScreen];
}


- (void)acupunctureguestureAction:(UITapGestureRecognizer *)recognizer
{
    [[NSUserDefaults standardUserDefaults]setValue:@"Cupuncture" forKey:@"SelectedCategory"];
    [self proceedToLoginScreen];
}

-(void)proceedToLoginScreen
{
    LoginViewController * loginObj = (LoginViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginObj animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
