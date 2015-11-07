//
//  UserViewController.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <objc/runtime.h>
#import "UserViewController.h"
#import <MapKit/MapKit.h>
#import "FLAnnotation.h"
#import "UIImageView+WebCache.h"

static char annStoreKey;

@interface UserViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLPlacemark * placemark;
@property (nonatomic) BOOL updateUserLocation;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.userData.city.length<2) {
        return;
    }
    self.mapView.delegate = self;
    
    CLGeocoder * geoCoder = [CLGeocoder new];
    
    [geoCoder geocodeAddressString:self.userData.city completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        self.placemark = placemarks[0];
        FLAnnotation * ann = [FLAnnotation new];
        ann.coordinate = self.placemark.location.coordinate;
        ann.title = self.userData.name;
        ann.subtitle = self.userData.city;
        ann.iconUrl = self.userData.iconUrl;
        
        [self.mapView addAnnotation:ann];
        
        self.mapView.showsUserLocation = YES;
        
    }];
    
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getUserPosition:)];
    gesture.numberOfTapsRequired = 3;
    [self.mapView addGestureRecognizer:gesture];
}

- (void) getUserPosition: (UITapGestureRecognizer *)gesture
{
//    if (gesture.numberOfTapsRequired==3)
    {
        CGPoint pt = [gesture locationInView:gesture.view];
        CLLocationCoordinate2D co = [self.mapView convertPoint:pt toCoordinateFromView:self.mapView];
        
        CLGeocoder * geoCoder = [CLGeocoder new];
    
        CLLocation * location = [[CLLocation alloc] initWithLatitude:co.latitude longitude:co.longitude];
        
        [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark * placemark = placemarks[0];
            
            MKPointAnnotation * ann = [MKPointAnnotation new];
            ann.coordinate = co;
            ann.title = [NSString stringWithFormat:@"%@ %@", placemark.country, placemark.administrativeArea];
            ann.subtitle = placemark.name;
            [self.mapView addAnnotation:ann];
        }];
        
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (!self.updateUserLocation) {
        MKCoordinateSpan span = MKCoordinateSpanMake(fabs(userLocation.coordinate.latitude-self.placemark.location.coordinate.latitude)+1, fabs(userLocation.coordinate.longitude-self.placemark.location.coordinate.longitude)+1);
        
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake((userLocation.coordinate.latitude+self.placemark.location.coordinate.latitude)/2, (userLocation.coordinate.longitude+self.placemark.location.coordinate.longitude)/2);
        
        MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
        [self.mapView setRegion:region animated:YES];
        
        self.updateUserLocation = YES;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[FLAnnotation class]]) {
        static NSString * annID = @"FL_ANN_ID";
        MKAnnotationView * annView = [mapView dequeueReusableAnnotationViewWithIdentifier:annID];
        if (!annView) {
            annView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annID];
            annView.canShowCallout = YES;
            UIImageView * leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            annView.leftCalloutAccessoryView = leftImage;
            UIImageView *rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_nav_share"]];
            
            annView.rightCalloutAccessoryView = rightView;
            rightView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navi2:)];
            [rightView addGestureRecognizer:gesture];
            
            
        }
        
        FLAnnotation * fla = (FLAnnotation *)annotation;
        
        UIImageView * iconImageView = (UIImageView *)annView.leftCalloutAccessoryView;
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:fla.iconUrl]];
        
        annView.image = [UIImage imageNamed:@"icon_marker"];
        
        UIImageView * rightView = (UIImageView *)annView.rightCalloutAccessoryView;
        
        objc_setAssociatedObject(rightView, &annStoreKey, fla, OBJC_ASSOCIATION_ASSIGN);
        
        return annView;
    }
    else {
        return nil;
    }
}

- (void) navi2:(UITapGestureRecognizer *)gesture
{
    FLAnnotation * ann = objc_getAssociatedObject(gesture.view, &annStoreKey);
    
    MKMapItem * fromItem = [MKMapItem mapItemForCurrentLocation];
    MKMapItem * toItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:ann.coordinate addressDictionary:nil]];
    
    toItem.name = ann.title;
    
    [MKMapItem openMapsWithItems:@[fromItem, toItem]
                   launchOptions:[NSDictionary dictionaryWithObjects:@[MKLaunchOptionsDirectionsModeDriving, @(YES)]
                                                             forKeys:@[MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
