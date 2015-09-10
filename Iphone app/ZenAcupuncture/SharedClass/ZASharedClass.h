//
//  SharedClass.h
//ZenAcupuncture
//
//  Created by Teja Swaroop on 16/11/14.
//  Copyright (c) 2014 SaiTeja. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MBProgressHUD.h"

#import "AppDelegate.h"

typedef void(^ZAResponseXMLString)(BOOL success, NSString *message);
typedef void(^ZAResponseDictionary)(NSMutableDictionary * productDetDict, BOOL success, NSString *message);

@protocol ParsedResponseDelegate <NSObject>

@required
- (void)reloadDataWithResponseDictionary:(NSMutableDictionary*)dictionary;
@end

@interface ZASharedClass : NSObject<NSXMLParserDelegate>

#pragma mark - Properties

@property(nonatomic, strong) NSMutableDictionary * inputValuesDict;

@property(nonatomic, strong) NSMutableDictionary * responeDict;
@property(nonatomic, strong) NSString * elementNameStr;
@property(nonatomic, strong) NSXMLParser * parserObj;
@property(nonatomic, strong) AppDelegate * appdelegateObj;
@property(nonatomic, strong) UIWindow *window;   

@property (weak, nonatomic) id <ParsedResponseDelegate> parserdelegate;

#pragma mark - Class/Instance Methods

+ (ZASharedClass *)sharedInstance;
- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title;
- (void)dismissGlobalHUD;
- (BOOL)isNetworkAvalible;
- (UIColor*)colorWithHexString:(NSString*)hex;
- (NSOperationQueue *)requestQueue;
#pragma mark - Webservices

- (void)fetchDataForLoginDetailsWith:(NSString*)urlString withCompletion:(ZAResponseXMLString)completionHandler;
- (void)getRequestWithURL:(NSString *)url withCallback:(void (^) (id result, NSError *error))callbackHandler;

#pragma mark Methods
-(void)setNavigationBarInViewController:(UIViewController*)viewController;

#pragma mark Parse Methods
-(void)parseTheXML:(NSString*)serverDataString;

@end
