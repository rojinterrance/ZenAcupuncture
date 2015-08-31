//
//  PreviousOrdersViewController.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 31/08/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviousOrdersViewController : UIViewController<ParsedResponseDelegate>

@property (strong, nonatomic) IBOutlet UITableView *previousTable;
@property (strong, nonatomic)NSArray * previousArray;

-(void)loadPreviosDetails;

@end
