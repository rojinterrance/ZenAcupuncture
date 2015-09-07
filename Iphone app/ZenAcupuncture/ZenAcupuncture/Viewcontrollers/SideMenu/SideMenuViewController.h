//
//  SideMenuViewController.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 04/09/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) NSArray * sideMenuArray;
@property (strong, nonatomic) IBOutlet UITableView *sideMenuTable;

@end
