//
//  FunTableViewController.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FunTableViewController.h"
#import "ASIHTTPRequest.h"
#import "FLGlobal.h"
#import "FunData.h"
#import "FunCellBase.h"

@interface FunTableViewController ()

@property (nonatomic) NSArray * data;

@end

@implementation FunTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDataFromServer];
}

- (void) loadDataFromServer
{
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[FLGlobal funnyUrl]];
    request.delegate = self;
    [request startAsynchronous];
}

- (void) requestFinished: (ASIHTTPRequest *) request
{
    NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
    if (!objects) {
        return;
    }
    
    NSArray * dataArray = objects[@"items"];
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:dataArray.count];
    for (id node in dataArray) {
        FunData * data = [[FunData alloc] initWithJSONNode:node];
        [array addObject:data];
    }
    
    self.data = array;
    
    [self.tableView reloadData];
}

- (void) requestFailed: (ASIHTTPRequest *) request
{
    NSLog(@"Request Failed");
    [self performSelector:@selector(loadDataFromServer) withObject:nil afterDelay:5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row==0 ? 150 : 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellID = indexPath.row == 0 ? @"LargeCellID" : @"SmallCellID";
    
    FunCellBase *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    // Configure the cell...
    
    FunData * data = self.data[indexPath.row];
    cell.data = data;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Testing" bundle:nil];
    
    UINavigationController * nav = [storyboard instantiateInitialViewController];
    
    [self presentViewController:nav animated:YES completion:nil];
}

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
