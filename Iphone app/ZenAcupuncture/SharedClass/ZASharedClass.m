//
//  SharedClass.m
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 16/11/14.
//  Copyright (c) 2014 SaiTeja. All rights reserved.
//

#import "ZASharedClass.h"


@implementation ZASharedClass

static ZASharedClass * sharedClassObj = nil;
static NSOperationQueue *reqQueue;

+(ZASharedClass *)sharedInstance
{
    if(sharedClassObj == nil)
    {
        sharedClassObj = [[super allocWithZone:NULL]init];
    }
    
    return sharedClassObj;
}

- (NSOperationQueue *)requestQueue
{
    if (!reqQueue) {
        reqQueue = [[NSOperationQueue alloc] init];
    }
    
    return reqQueue;
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
        self.inputValuesDict = [[NSMutableDictionary alloc]init];
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
#pragma mark - Fetch Response From Server

- (void)fetchDataForLoginDetailsWith:(NSString*)urlString withCompletion:(ZAResponseXMLString)completionHandler
{
   NSString *escapedUrlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *aUrl = [NSURL URLWithString:escapedUrlString];
    
    NSLog(@"request : %@",[NSString stringWithFormat:@"%@",aUrl]);
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL: aUrl] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *resp, NSData *data, NSError *err)
     {
         if(data != nil)
         {
              NSString *response = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];

             //NSLog(@"resp %@",response);
             
             completionHandler(YES,response);
        }
         else
         {
             NSLog(@"eerrpr %@",[err localizedDescription]);
            completionHandler(NO,@"Failure");
         }
     }];
}

- (void)getRequestWithURL:(NSString *)url withCallback:(void (^) (id result, NSError *error))callbackHandler {
    
    NSLog(@"URL : %@", url);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[self requestQueue] completionHandler:^(NSURLResponse *resp, NSData *data, NSError *error) {
        
        id  responseObject = nil;
        
        if (data != nil) {
            responseObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        }
        
        NSLog(@"Response : %@\nError : %@", responseObject, error.description);
        
        callbackHandler(responseObject, error);
    }];
}

#pragma mark - Parsing

-(void)parseTheXML:(NSString*)serverDataString
{
    self.parserObj = [[NSXMLParser alloc] initWithData:(NSMutableData*)[serverDataString dataUsingEncoding:NSUTF8StringEncoding]];
    [self.parserObj setDelegate: self];
    [self.parserObj setShouldResolveExternalEntities: YES];
    [self.parserObj parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.responeDict =[[NSMutableDictionary alloc]init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.elementNameStr = elementName;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([string isEqualToString:@"\n"] || [string isEqualToString:@"\n\t"])
    {
        return;
    }
    
    if ([self.elementNameStr isEqualToString:@"code"])
    {
        [self.responeDict setValue:string forKey:@"code"];
    }
    else if ([self.elementNameStr isEqualToString:@"data"])
    {
        [self.responeDict setValue:string forKey:@"data"];
    }
    else if([self.elementNameStr isEqualToString:@"userId"])
    {
        [self.responeDict setValue:string forKey:@"userId"];
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self.parserdelegate reloadDataWithResponseDictionary:self.responeDict];
}



@end
