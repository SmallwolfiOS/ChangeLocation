//
//  ViewController.m
//  changeLocationDemo
//
//  Created by baidu on 2018/10/10.
//  Copyright © 2018 mahp. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic,strong) CLLocationManager * locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    
    
    
    
    if ([CLLocationManager locationServicesEnabled]) {
    
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
        
        [_locationManager requestAlwaysAuthorization];
    [_locationManager startUpdatingLocation];
    
    }
}
- (IBAction)confirmAction:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_textField.text completionHandler:^(NSArray *placemarks, NSError *error){
        NSLog(@"查询记录数:%ld",[placemarks count]);
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            
            NSString *strCoordinate = [NSString stringWithFormat:@"经度:%3.5f 纬度:%3.5f:",coordinate.latitude,coordinate.longitude ];
            NSLog(@"%@",strCoordinate);
        }
    }];
}


//#pragma mark CoreLocation deleagte (定位失败)
/*定位成功后则执行此代理方法*/
#pragma mark 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//    [_locationManager stopUpdatingLocation];
    /*旧值*/
    CLLocation * currentLocation = [locations lastObject];
    CLGeocoder * geoCoder = [[CLGeocoder alloc]init];
    /*打印当前经纬度*/
    NSLog(@"%f=====%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    /*地理反编码 -- 可以根据地理位置（经纬度）确认位置信息 （街道、门牌）*/
//    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (placemarks.count >0) {
//            CLPlacemark * placeMark = placemarks[0];
//            currentCity = placeMark.locality;
//            if (!currentCity) {
//                currentCity = @"无法定位当前城市";
//            }
//            /*看需求定义一个全局变量来接受赋值*/
//            NSLog(@"%@",placeMark.country);/*当前国家*/
//            NSLog(@"%@",currentCity);/*当前城市*/
//            NSLog(@"%@",placeMark.subLocality);/*当前位置*/
//            NSLog(@"%@",placeMark.thoroughfare)/*当前街道*/
//            NSLog(@"%@",placeMark.name);/*具体地址 ** 市 ** 区** 街道*/
//            /*根据经纬度判断当前距离*/
//            /*这个地方需要double转字符串赋值到label上面*/
//            self.headView.Distance.text =HZString(@"距您%.1fkm",[self getDistance:currentLocation.coordinate.latitude lng1:currentLocation.coordinate.longitude lat2:weiDouble lng2:jingDouble]);
//        }
//        else if (error == nil&&placemarks.count == 0){
//            NSLog(@"没有地址返回");
//        }
//        else if (error){
//            NSLog(@"location error:%@",error);
//        }
//    }];
//}
}








@end
