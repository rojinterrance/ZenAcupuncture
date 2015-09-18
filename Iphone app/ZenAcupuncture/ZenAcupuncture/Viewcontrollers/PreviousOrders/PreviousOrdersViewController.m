//
//  PreviousOrdersViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 31/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "PreviousOrdersViewController.h"

#import "MainViewController.h"

#import "AppointmentCell.h"

@interface PreviousOrdersViewController ()

@end

@implementation PreviousOrdersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=@"Appointments";
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Hamburger"] style:UIBarButtonItemStylePlain target:self action:@selector(hamberAction:)];
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:246.0/255.0 green:188.0/255.0 blue:47.0/255.0 alpha:1.0]];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.previousTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newAppointment:)];
    self.navigationItem.rightBarButtonItem =rightButton;
}

-(void)hamberAction:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

-(IBAction)newAppointment:(id)sender
{
    NSLog(@"%s",__func__);
    MainViewController * mainObj = (MainViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"MainViewController"];

    [self.navigationController pushViewController:mainObj animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadPreviosDetails];
}

-(IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)loadPreviosDetails
{
    [[ZASharedClass sharedInstance]showGlobalProgressHUDWithTitle:@"Loading"];
    
    NSString *functionAndFormat =@"&function=getOrder&format=xml";
    
    NSString * urlString = [NSString stringWithFormat:@"%@?userid=%@%@",baseUrl,[[NSUserDefaults standardUserDefaults]valueForKey:@"userId"],functionAndFormat];
    
    [[ZASharedClass sharedInstance]fetchDataForLoginDetailsWith:urlString withCompletion:^(BOOL success, NSString *response) {
        
        if (success)
        {
            //NSLog(@"message %@",response);
            
            [ZASharedClass sharedInstance].parserdelegate = self;
            [[ZASharedClass sharedInstance]parseTheXML:response];
        }
        else
        {
            NSLog(@"Failed");
            [[ZASharedClass sharedInstance]dismissGlobalHUD];
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:@"Some thing Went wrong Please try Again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        [[ZASharedClass sharedInstance]dismissGlobalHUD];
    }];
}

- (void)reloadDataWithResponseDictionary:(NSMutableDictionary*)dictionary
{
//    NSLog(@"dictionary %@",dictionary);
    NSString * dataStr = [dictionary valueForKey:@"data"];
    
    self.previousArray = [NSJSONSerialization JSONObjectWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    [self.previousTable reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.previousArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
//    
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
//    }
//    
//    NSDictionary * eachDict = [self.previousArray objectAtIndex:indexPath.row];
//    
//  cell.textLabel.text =[NSString stringWithFormat:@"Date: %@ Time: %@",[eachDict valueForKey:@"appointmentDate"],[eachDict valueForKey:@"appointTime"]];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"Lenght: %@",[eachDict valueForKey:@"sessionLength"]];
//    return cell;



    static NSString * simpleTableIdentifier = @"AppointmentCell";
    
    AppointmentCell *cell = (AppointmentCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"AppointmentCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
      NSDictionary * eachDict = [self.previousArray objectAtIndex:indexPath.row];

    cell.firstLabel.text = [NSString stringWithFormat:@"Date: %@  & Time: %@",[eachDict valueForKey:@"appointmentDate"],[eachDict valueForKey:@"appointTime"]];
    cell.secondLabel.text = [NSString stringWithFormat:@"Lenght :%@",[eachDict valueForKey:@"sessionLength"]];
    
    return cell;


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
