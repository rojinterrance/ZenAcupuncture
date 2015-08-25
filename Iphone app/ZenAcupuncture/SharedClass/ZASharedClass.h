//
//  SharedClass.h
//
//
//  Created by Teja Swaroop on 16/11/14.
//  Copyright (c) 2014 SaiTeja. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MBProgressHUD.h"

#import "AppDelegate.h"

/**
 *Creates a NSMutableArray forZoukiCategorie
 *Creates a NSMutableDictionary for ZoukiProduct
**/

typedef void(^ZAResponseArray)(NSMutableArray* categoriesArray, BOOL success, NSString *message);
typedef void(^ZAResponseDictionary)(NSMutableDictionary * productDetDict, BOOL success, NSString *message);

@interface ZASharedClass : NSObject

#pragma mark - Properties

@property(nonatomic, strong) AppDelegate * appdelegateObj;
@property(nonatomic, strong) UIWindow *window;   

#pragma mark - Class/Instance Methods

+ (ZASharedClass *)sharedInstance;
- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title;
- (void)dismissGlobalHUD;
- (BOOL)isNetworkAvalible;
- (UIColor*)colorWithHexString:(NSString*)hex;

#pragma mark - Webservices

- (void)fetchDataForLoginDetailsWith:(NSString*)urlString withCompletion:(ZAResponseArray)completionHandler;

#pragma mark Methods
-(void)setNavigationBarInViewController:(UIViewController*)viewController;

@end
