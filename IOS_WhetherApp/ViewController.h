//
//  ViewController.h
//  IOS_WhetherApp
//
//  Created by Student P_02 on 13/06/18.
//  Copyright © 2018 Shital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NextViewController.h"
#define KEY "eccba96e96d7bf8e214f22d145336af8"
///http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=eccba96e96d7bf8e214f22d145336af8
@interface ViewController : UIViewController<CLLocationManagerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *AddressTextField;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegment;
- (IBAction)mySegmentChangeMapTypeAction:(UISegmentedControl *)sender;
- (IBAction)DetectLocationButton:(UIButton *)sender;
- (IBAction)DetectWeatherButton:(UIButton *)sender;
@property CLLocationManager *locationManager;

@property float latitude11;
@property float longitude11;
@end

