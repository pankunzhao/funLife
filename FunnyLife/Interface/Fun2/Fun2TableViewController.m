//
//  Fun2TableViewController.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/12.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "Fun2TableViewController.h"
#import "Funny2Data.h"
#import "FLGlobal.h"
#import "AFNetworking.h"
#import "Fun2Cell.h"
#import "UIViewAdditions.h"
#import "NSString+Frame.h"
#import "PhotoViewController.h"

@interface Fun2TableViewController () <Fun2CellDelegate>

@end

@implementation Fun2TableViewController

- (void)viewDidLoad {
    
    self.cachePath = [FLGlobal funny2CachePath];
    self.url = [FLGlobal funny2Url];
    
    [super viewDidLoad];
    
    self.refreshType = FLRefreshTypeAll;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id) createDataWithJSONNode: (id) node
{
    return [[Funny2Data alloc] initWithJSONNode:node];
}

- (void) footerRefresh
{
    Funny2Data * data = [self.data lastObject];
    
    NSString * url = [FLGlobal funny2MoreUrl: data.addon];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self endFooterRefresh];
             if (responseObject) {
                 NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
                 if (!objects) {
                     return;
                 }
                 
                 NSInteger count = self.data.count;
                 
                 NSArray * dataArray = objects[@"data"];
                 for (id node in dataArray) {
                     id obj = [self createDataWithJSONNode: node];
                     [self.data addObject:obj];
                 }
                 [self.tableView reloadData];
                 
                 NSInteger position = count>0 ? count-1:count;
                 
                 [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:position inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Url failed: %@", self.url);
             [self endFooterRefresh];
         }
     ];
}


#pragma mark - Fun2CellDelegate

- (void) imageButtonClickedOnCell: (UITableViewCell *)cell
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    Funny2Data * data = self.data[indexPath.row];
    
    [self performSegueWithIdentifier:@"ShowPhoto" sender:data];
}

- (void) bookmarkButtonClickedOnCell: (UITableViewCell *)cell
{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    Funny2Data * data = self.data[indexPath.row];

    data.bookmarked = !data.bookmarked;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Funny2Data * data = self.data[indexPath.row];
    float contentWidth = self.tableView.width - 16;
    float contentHeight = [data.content heightWithFont:[UIFont systemFontOfSize:17] withinWidth:contentWidth];
    
    return 175-21+contentHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Fun2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Fun2CellID" forIndexPath:indexPath];
    
    Funny2Data * data = self.data[indexPath.row];
    cell.data = data;
    cell.delegate = self;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    PhotoViewController * vc = segue.destinationViewController;
    Funny2Data * data = sender;
    
    vc.urlArray = @[data.imageUrl];
    vc.order = 0;
    
}

@end
