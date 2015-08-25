//
//  SharedClass.m
//  HowBe
//
//  Created by Teja Swaroop on 16/11/14.
//  Copyright (c) 2014 SaiTeja. All rights reserved.
//

#import "ZASharedClass.h"


@implementation ZASharedClass

static ZASharedClass * sharedClassObj = nil;

+(ZASharedClass *)sharedInstance
{
    if(sharedClassObj == nil)
    {
        sharedClassObj = [[super allocWithZone:NULL]init];
    }
    
    return sharedClassObj;
}


+(id)allocWithZone:(struct _NSZone *)zone
{
    return sharedClassObj;
}
/**
 
 **/

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
        self.window = [[[UIApplication sharedApplication] windows] lastObject];
        self.appdelegateObj = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    }
    
    return self;
}

/*
 This method checks the if the internet connection is available for the device.
 @returns Yes if the internet connection is available, otherwise no.
 */

-(BOOL)isNetworkAvalible
{
    Reachability* reachability = [Reachability reachabilityForInternetConnection];
    [Reachability reachabilityWithHostname:@"http://www.google.co.in/"];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    if (remoteHostStatus == NotReachable)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
/**
 
 **/

- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.labelText = title;
    return hud;
}

/**
 
 **/
- (void)dismissGlobalHUD
{
    [MBProgressHUD hideHUDForView:self.window animated:YES];
}

/**
 
 **/
-(void)setNavigationBarInViewController:(UIViewController*)viewController
{
    UILabel *navLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    navLabel.backgroundColor = [UIColor clearColor];
    navLabel.font = FONT_NEW_FUTURA_BOLD (28);
    navLabel.textAlignment = NSTextAlignmentCenter;
    navLabel.textColor = [UIColor whiteColor];
    viewController.navigationItem.titleView = navLabel;
    navLabel.text = @"Zouki";
    [navLabel sizeToFit];
    
}

/**
 
 **/

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

- (void)fetchDataForLoginDetailsWith:(NSString*)urlString withCompletion:(ZAResponseArray)completionHandler
{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *resp, NSData *data, NSError *err)
     {
         if(data != nil)
         {
             NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &err];
              NSLog(@"json %@",json);
            
        completionHandler ([json mutableCopy],YES,[json valueForKey:@"error"]);
         }
     }];
}



@end
