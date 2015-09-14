//
//  AppConstants.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 16/11/14.
//  Copyright (c) 2014 SaiTeja. All rights reserved.
//

#import "AppDelegate.h"

/**
 *Defines sharedApplication]delegate
 *Defines IS IPHONE 5 by height 568 or not
 *Defines currentDevice & DEVICE_VERSION
 *Defines UI USER INTERFACE IDIOM
 *Defines IS IPAD  Statement
 *Defines Font size and Bolt
 *Defines APPLICATION NAME
 **/

#define APPDELEGATE (AppDelegate *)[[UIApplication sharedApplication]delegate]

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define DEVICE_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#ifdef UI_USER_INTERFACE_IDIOM

#define STANDARD_DEFAULTS [NSUserDefaults standardUserDefaults]

#define IS_IPAD() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD() (false)
#endif

#define FONT_NEW_FUTURA_BOLD(f)             [UIFont fontWithName: @"Futura-Bold" size:(f)]
#define FONT_NEW_FUTURA_MEDIUM(f)           [UIFont fontWithName: @"Futura_Medium_BT" size:(f)]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define APPLICATION_NAME @"Zen Acupuncture"

#define HEADER_TITLE  @"Zen"

#import <Foundation/Foundation.h>

@interface AppConstants : NSObject

/**
 *Gets Objects  NSString  MainStoryBoardiPad
 *Gets Objects MainStoryBoardiPone
 **/

#pragma mark - Variables

OBJC_EXPORT NSString *const MainStoryBoardiPad;

OBJC_EXPORT NSString *const MainStoryBoardiPhone;

OBJC_EXPORT NSString * const baseUrl;

OBJC_EXPORT NSString * const GOOGLE_ADDRESS_URL;

@end
