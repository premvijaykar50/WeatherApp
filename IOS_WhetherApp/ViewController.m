//
//  ViewController.m
//  IOS_WhetherApp
//
//  Created by Student P_02 on 13/06/18.
//  Copyright © 2018 Shital. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.AddressTextField.delegate=self;

    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *location =self.AddressTextField.text;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:location
                 completionHandler:^(NSArray* placemarks, NSError* error){
                     if (placemarks && placemarks.count > 0) {
                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                         
                         MKCoordinateRegion region = self.myMapView.region;
                         region.center = placemark.region.center;
                         region.span.longitudeDelta /= 8.0;
                         region.span.latitudeDelta /= 8.0;
                         
                         [self.myMapView setRegion:region animated:YES];
                         [self.myMapView addAnnotation:placemark];
                     }
                 }
     ];
    [textField resignFirstResponder];
    return YES;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations

{
    CLLocation *currentLocation=[locations lastObject];
    self.latitude11=currentLocation.coordinate.latitude;
    self.longitude11=currentLocation.coordinate.longitude;
    if(currentLocation !=nil)
    {
        [manager stopUpdatingLocation];
    }
    CLLocationCoordinate2D coOrdinate=currentLocation.coordinate;
    NSLog(@"Latitude=%f and Longitude=%f",self.latitude11,self.longitude11);
    MKCoordinateSpan span=MKCoordinateSpanMake(0.5,0.5);
    MKCoordinateRegion region=MKCoordinateRegionMake(coOrdinate, span);
    [self.myMapView setRegion:region];
    CLGeocoder *geoCoder=[[CLGeocoder alloc]init];
    CLLocation *location=[[CLLocation alloc]initWithLatitude:self.latitude11 longitude:self.longitude11];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placeMark=[placemarks firstObject];
        NSString *subtitle=[NSString stringWithFormat:@"%@ ,%@,%@",placeMark.subLocality,placeMark.thoroughfare,placeMark.subThoroughfare];
        NSString *title=[NSString stringWithFormat:@"%@",placeMark.locality];
        
        MKPointAnnotation *annotation=[[MKPointAnnotation alloc]init];
        annotation.coordinate=coOrdinate;
        annotation.title=title;
        annotation.subtitle=subtitle;
        
        [self.myMapView addAnnotation:annotation];
        
    }];
    
    
}

- (IBAction)mySegmentChangeMapTypeAction:(UISegmentedControl *)sender
{
    switch (self.mySegment.selectedSegmentIndex)
    {
        case 0:
            self.myMapView.mapType=MKMapTypeStandard;
            break;
        case 1:
            self.myMapView.mapType=MKMapTypeSatellite;
            
            break;
        case 2:
            self.myMapView.mapType=MKMapTypeHybrid;
            
            break;
        default:
            break;
    }

}
-(void)startDetectingLocation
{
    self.locationManager=[[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate=self;
    [self.locationManager startUpdatingLocation];

}
- (IBAction)DetectLocationButton:(UIButton *)sender
{
    
        [self startDetectingLocation];
    
   
}

- (IBAction)DetectWeatherButton:(UIButton *)sender
{
    NextViewController *next=[self.storyboard instantiateViewControllerWithIdentifier:@"NextViewController"];
    
    next.latitude=self.latitude11;
    next.longitude=self.longitude11;
    NSLog(@"Latitude=%f Longitude=%f",next.latitude,next.longitude);
    
    [self.navigationController pushViewController:next animated:YES];
}
@end
