//
//  RefreshTableViewController.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/12.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "RefreshTableViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"

#import "HelloTableViewController.h"
#import "HelloData.h"

@interface RefreshTableViewController ()

@end

@implementation RefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [NSMutableArray new];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.cachePath]) {
        [self loadDataFromCache];
    }
    else {
        [self loadDataFromServer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRefreshType:(FLRefreshType)refreshType
{
    _refreshType = refreshType;
    
    if (refreshType & FLRefreshTypeHeader) {
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    }
    if (refreshType & FLRefreshTypeFooter) {
        self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    }
    
    
}

- (void) headerRefresh
{
    [self loadDataFromServer];
}

- (void) footerRefresh
{
    
}

- (void) endFooterRefresh
{
    [self.tableView.footer endRefreshing];
}

- (void) loadDataFromCache
{
    NSData * fileData = [NSData dataWithContentsOfFile:self.cachePath];
    NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:nil];
    if (!objects) {
        return;
    }
    
    [self.data removeAllObjects];
    
    NSArray * dataArray = objects[@"data"];
    for (id node in dataArray) {
        id obj = [self createDataWithJSONNode: node];
        [self.data addObject:obj];
    }
    
    [self.tableView reloadData];
}

- (id) createDataWithJSONNode: (id) node
{
    NSLog(@"You should not see this warning!!!");
    return nil;
}

- (void) loadDataFromServer
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:self.url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [self.tableView.header endRefreshing];
             if (responseObject) {
                 [[NSFileManager defaultManager] removeItemAtPath:self.cachePath error:nil];
                 
                 [operation.responseData writeToFile:self.cachePath atomically:NO];
                 
                 [self loadDataFromCache];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Url failed: %@", self.url);
             [self.tableView.header endRefreshing];
         }
     ];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
