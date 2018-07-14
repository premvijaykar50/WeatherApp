//
//  NextViewController.m
//  IOS_WhetherApp
//
//  Created by Student P_02 on 13/06/18.
//  Copyright © 2018 Shital. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.DescriptionArray=[[NSMutableArray alloc]init];
    self.TempratureArray=[[NSMutableArray alloc]init];
    self.HumidityArray=[[NSMutableArray alloc]init];

    
    
    [self WheatherJson];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)WheatherJson
{
   NSString *str=[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=%s",self.latitude,self.longitude,KEY];
    NSLog(@"%@",str);
    
    NSURL *myurl=[NSURL URLWithString:str];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *dataTask=[session dataTaskWithURL:myurl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //code
        NSHTTPURLResponse *myResponse=(NSHTTPURLResponse *)response;
        if(myResponse.statusCode==200)
        {
            NSLog(@"Response Found");
            if(data)
            {
                NSDictionary *maindic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                
                NSArray *myWheatherArray=[maindic valueForKey:@"weather"];
                NSDictionary *WheatherDic=[myWheatherArray lastObject];
                
              self.DescriptionString=  [WheatherDic valueForKey:@"description"];
                self.DescriptionLabel.text=self.DescriptionString;

                //[self.DescriptionArray addObject:self.DescriptionString];
              

                
                
                
                
                NSDictionary *Temp_HumiDic=[maindic valueForKey:@"main"];
                
             id temp=[Temp_HumiDic valueForKey:@"temp"];
                self.TempratureString=[NSString stringWithFormat:@"%@",temp];
                
                 self.TempratureLabel.text=self.TempratureString;

                //[self.TempratureArray addObject:self.TempratureString];
                

                
                
                
                id humi=[Temp_HumiDic valueForKey:@"humidity"];
                self.HumidityString=[NSString stringWithFormat:@"%@",humi];

               self.HumidityLabel.text=self.HumidityString;

              // [self.HumidityArray addObject:self.HumidityString];
                
                
                if(error)
                {
                    NSLog(@"Error : %@ ",error.localizedDescription);
                }
                else
                {
                   // NSLog(@"Description :%@",self.DescriptionArray);
                    NSLog(@"Description :%@",self.DescriptionString);
                    
                   // NSLog(@"Temprature :%@",self.TempratureArray);
                    NSLog(@"Temprature :%@",self.TempratureString);

                    //NSLog(@"Humidity :%@",self.HumidityArray);
                    NSLog(@"Humidity :%@",self.HumidityString);


                }
            }
                else
                {
                    NSLog(@"Response not Found");
                    
                }
            
        }
               
            }];
    [dataTask resume];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
