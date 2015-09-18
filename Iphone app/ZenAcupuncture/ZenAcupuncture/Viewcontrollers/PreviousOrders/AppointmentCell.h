//
//  AppointmentCell.h
//  ZenAcupuncture
//
//  Created by Teja Swaroop on 18/09/15.
//  Copyright (c) 2015 SaiTeja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageObj;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;

@end
