//
//  HelloTableViewController.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/12.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "HelloTableViewController.h"
#import "HelloData.h"
#import "FLGlobal.h"
#import "HelloCell.h"
#import "NSString+Frame.h"
#import "UIViewAdditions.h"
#import "PhotoViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "UserViewController.h"
#import "AllUsersViewController.h"

@interface HelloTableViewController () <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager * locationManager;

@end

@implementation HelloTableViewController

- (void)viewDidLoad {
    
    self.cachePath = [FLGlobal helloCachePath];
    self.url = [FLGlobal helloUrl];

    [super viewDidLoad];
    
    self.refreshType = FLRefreshTypeHeader;
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"Location Service Not Enabled");
        return;
    }
    
    self.locationManager = [CLLocationManager new];
    
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.locationManager.delegate = self;
//    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation * location = locations[0];
    NSLog(@"%@", location);
    
    [manager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id) createDataWithJSONNode: (id) node
{
    HelloData *data = [[HelloData alloc] initWithJSONNode:node];
    
    float contentHeight = [data.content heightWithFont:[UIFont systemFontOfSize:17] withinWidth:self.tableView.width-20];
    
    if (contentHeight>21*2) {
        data.needExpand = YES;
    }
    
    return data;
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HelloData * data = self.data[indexPath.row];
    float contentWidth = self.tableView.width - 20;
    float contentHeight = [data.content heightWithFont:[UIFont systemFontOfSize:17] withinWidth:contentWidth];
    
    float expandButtonHeight = 30;
    
    if (data.needExpand) {
        if (!data.expanded) {
            contentHeight = 21 * 2;
        }
    }
    else {
        expandButtonHeight = 0;
    }
    
    float imageFrameViewHeight = [ImageFrameView heightOfContent:data.photoArray withInWidth:contentWidth];
    
    return contentHeight + expandButtonHeight + imageFrameViewHeight + 125;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HelloCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HellCellID" forIndexPath:indexPath];
    
    HelloData * data = self.data[indexPath.row];
    cell.data = data;
    
    [cell.expandButton addTarget:self action:@selector(expandButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.nameButton addTarget:self action:@selector(nameButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    for (UIImageView * imageView in cell.imageFrameView.imageArray) {
        if (imageView.gestureRecognizers.count!=0) {
            break;
        }
        UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapped:)];
        [imageView addGestureRecognizer:gesture];
        imageView.userInteractionEnabled = YES;
    }
    
    return cell;
}

- (void) userTapped: (UITapGestureRecognizer *) gesture
{
    UIImageView * imageView = (UIImageView *) gesture.view;
    ImageFrameView * imageFrameView = (ImageFrameView *) imageView.superview;
    
    NSIndexPath * indexPath = [self findView:imageFrameView];
    HelloData * data = self.data[indexPath.row];
    NSUInteger order = [imageFrameView.imageArray indexOfObject:imageView];
    
    [self performSegueWithIdentifier:@"ShowPhoto" sender:@{@"data":data,@"order":@(order)}];
}

- (void) expandButtonClicked: (UIButton *) button
{
    NSIndexPath * indexPath = [self findView:button];
    HelloData * data = self.data[indexPath.row];
    data.expanded = !data.expanded;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

- (void)nameButtonClicked: (UIButton *) button
{
    NSIndexPath * indexPath = [self findView:button];
    HelloData * data = self.data[indexPath.row];

    [self performSegueWithIdentifier:@"ShowUser" sender:data];
    
}


- (NSIndexPath *) findView: (UIView *)view
{
    NSArray * cellArray = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath * indexPath in cellArray) {
        HelloCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell.contentView==view.superview.superview) {
            return indexPath;
        }
    }
    return nil;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"ShowPhoto"]) {
        PhotoViewController * vc = [segue destinationViewController];
        vc.order = [sender[@"order"] integerValue];
        HelloData * data = sender[@"data"];
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:data.photoArray.count];
        for (HelloImageData * imageData in data.photoArray) {
            [array addObject:imageData.url];
        }
        vc.urlArray = array;
    }
    else if ([segue.identifier isEqualToString:@"ShowUser"]) {
        UserViewController * vc = segue.destinationViewController;
        vc.userData = sender;
    }
    else if ([segue.identifier isEqualToString:@"ShowAllUsers"]) {
        AllUsersViewController * vc = segue.destinationViewController;
        vc.data = [self.data mutableCopy];
    }
}

@end
