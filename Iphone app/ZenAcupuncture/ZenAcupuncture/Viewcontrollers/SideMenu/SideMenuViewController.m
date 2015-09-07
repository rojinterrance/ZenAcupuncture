//
//  SideMenuViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 04/09/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "SideMenuViewController.h"

#import "SettingsViewController.h"

#import "MainViewController.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sideMenuArray = @[@"Book Massage",@"Bookings",@"Share",@"Settings",@"Log Out"];
}

-(void)viewWillAppear:(BOOL)animated
{
        [super viewWillAppear:animated];
       [self.menuContainerViewController setPanMode:MFSideMenuPanModeDefault];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sideMenuArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [self.sideMenuArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle      = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        MainViewController * settingsView = (MainViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"MainViewController"];
        self.menuContainerViewController.centerViewController = [[UINavigationController alloc]initWithRootViewController:settingsView];
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];

    }
    else if (indexPath.row == 3)
    {

        SettingsViewController * settingsView = (SettingsViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"SettingsViewID"];
        self.menuContainerViewController.centerViewController = [[UINavigationController alloc]initWithRootViewController:settingsView];
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];


    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
