//
//  DescriptionViewController.m
//  ZenAcupuncture
//
//  Created by Manoj Kumar on 15/09/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "DescriptionViewController.h"

#import "AccunpunctureViewController.h"

@interface DescriptionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
- (IBAction)bookAppointmentAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end

@implementation DescriptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem =leftButton;
   
    self.navigationItem.title = @"Description";
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedCategory"] isEqualToString:@"Acupressure"])
    {
        self.descriptionLabel.text = ACUPUNCTURE;

    }
    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedCategory"] isEqualToString:@"Cupping"])
    {
        self.descriptionLabel.text = ACU_CUP;

    }
    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"SelectedCategory"] isEqualToString:@"Cupuncture"])
    {
        self.descriptionLabel.text = ACU_MASSAGE;

    }
    else
    {
        self.descriptionLabel.text = NEEDLE_FREE_MASSAGE;

    }
        // Do any additional setup after loading the view.
}

-(IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)bookAppointmentAction:(id)sender
{
    AccunpunctureViewController * appObj = (AccunpunctureViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"AccunpunctureViewController"];
    [self.navigationController pushViewController:appObj animated:YES];

}

- (IBAction)cancelAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
