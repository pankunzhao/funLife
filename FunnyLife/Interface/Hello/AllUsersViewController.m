//
//  AllUsersViewController.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/14.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "AllUsersViewController.h"
#import <MapKit/MapKit.h>
#import "HelloData.h"

@interface AllUsersViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLGeocoder * geocoder;
@end

@implementation AllUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.geocoder = [CLGeocoder new];
    
    [self decodeAddress];
}

- (void) decodeAddress
{
    if (self.data.count==0) {
        return;
    }
    
    HelloData * data = [self.data firstObject];
    if (data.city.length<2) {
        [self.data removeObjectAtIndex:0];
        [self decodeAddress];
        return;
    }
    
    [self.geocoder geocodeAddressString:data.city completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark * placemark = placemarks[0];
        
        MKPointAnnotation * ann = [MKPointAnnotation new];
        ann.coordinate = placemark.location.coordinate;
        ann.title = data.name;
        ann.subtitle = data.city;
        [self.mapView addAnnotation:ann];
        
        [self.data removeObjectAtIndex:0];
        [self decodeAddress];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
