//
//  NextViewController.h
//  IOS_WhetherApp
//
//  Created by Student P_02 on 13/06/18.
//  Copyright © 2018 Shital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface NextViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *DescriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *TempratureLabel;

@property (weak, nonatomic) IBOutlet UILabel *HumidityLabel;

@property float latitude;
@property float longitude;
@property NSMutableArray *DescriptionArray;
@property NSMutableArray *TempratureArray;
@property NSMutableArray *HumidityArray;
@property NSString *DescriptionString;
@property NSString *TempratureString;
@property NSString *HumidityString;
@end
