//
//  AddressViewController.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 25/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import "AddressViewController.h"

#import "PaymentViewController.h"

#import "ActionSheetStringPicker.h"

@interface AddressViewController ()
{
    NSMutableArray *addressArray;
}
@property (nonatomic,assign) NSInteger selectedIndex;

@end

@implementation AddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title= HEADER_TITLE;
    addressArray = [NSMutableArray new];
    isHotel = YES;
    isTableShown = NO;

    self.smallView.hidden = YES;
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
    self.navigationItem.leftBarButtonItem =leftButton;
}

-(IBAction)backTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)isHotelAction:(id)sender
{
    if (isHotel)
    {
        isHotel= NO;
        [self.ishotelBtn setImage:[UIImage imageNamed:@"Unchecked.png"] forState:UIControlStateNormal];
    }
    else
    {
        isHotel= YES;
        [self.ishotelBtn setImage:[UIImage imageNamed:@"Checked.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)addAndContinueAction:(id)sender
{
    NSLog(@"inputs %@",[[ZASharedClass sharedInstance]inputValuesDict]);
    
    NSString * hotelStr;
    
    if (isHotel)
    {
        hotelStr = @"YES";
    }
    else
    {
        hotelStr = @"NO";
    }
    
    if ([self.addressFeild.text length] > 0  &&  [self.firstNameFeild.text length] > 0 )
    {
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue: self.addressFeild.text forKey:@"addressFeild"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue: self.firstNameFeild.text forKey:@"firstNameFeild"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.lastNameFeild.text forKey:@"lastNameFeild"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:self.phoneFeild.text forKey:@"phoneFeild"];
        [[[ZASharedClass sharedInstance]inputValuesDict] setValue:hotelStr forKey:@"isHotel"];

        NSLog(@"Inputs %@",[[ZASharedClass sharedInstance]inputValuesDict]);
        
        PaymentViewController * paymentView = (PaymentViewController*) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"PaymentViewController"];
        [self.navigationController pushViewController:paymentView animated:YES];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:@"Please enter Address and First name" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newString.length > 5 && self.addressFeild == textField)
    {
        NSLog(@"Make a service Call Here");

        NSString *serviceURL = [NSString stringWithFormat:@"%@%@",GOOGLE_ADDRESS_URL,self.addressFeild.text];
        if ([[ZASharedClass sharedInstance] isNetworkAvalible])
        {
            [[ZASharedClass sharedInstance]showGlobalProgressHUDWithTitle:@"Loading..."];

            [[ZASharedClass sharedInstance] getRequestWithURL:serviceURL withCallback:^(id result, NSError *error) {
                [[ZASharedClass sharedInstance]dismissGlobalHUD];

                if (result != nil)
                {
                 //   NSLog(@"Response--->%@",result);
                    [addressArray addObjectsFromArray:[result[@"results"] valueForKey:@"formatted_address"]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[ZASharedClass sharedInstance]dismissGlobalHUD];
                       [self.view endEditing:YES];
                        self.smallView.hidden = NO;
                        [self.locationTable reloadData];
                    });
                }
            }];
        }
        else
        {
            [[ZASharedClass sharedInstance]dismissGlobalHUD];
            UIAlertView *alertMessage = [[UIAlertView alloc]initWithTitle:@"No Address Found" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertMessage show];
        }
    }
    return YES;
}

#pragma mark - Table Delegates

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text=[addressArray objectAtIndex:indexPath.row];
    [cell setBackgroundColor:[UIColor whiteColor]];
return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [addressArray count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.addressFeild.text = [addressArray objectAtIndex:indexPath.row];
    self.smallView.hidden = YES;
    isTableShown =NO;
}
- (IBAction)doneClk:(id)sender {
    self.smallView.hidden = YES;
}

#pragma mark - Textfeild Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
  if ([self.firstNameFeild isFirstResponder])
    {
        [self.firstNameFeild resignFirstResponder];
        [self.lastNameFeild becomeFirstResponder];
    }
    else if ([self.lastNameFeild isFirstResponder])
    {
        [self.lastNameFeild resignFirstResponder];
        [self.phoneFeild becomeFirstResponder];
    }
    else if ([self.phoneFeild isFirstResponder])
    {
        [self.phoneFeild resignFirstResponder];
           [self.addressFeild becomeFirstResponder];
    }
    else if ([self.addressFeild isFirstResponder])
    {
        [self.addressFeild resignFirstResponder];
    }
   
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
