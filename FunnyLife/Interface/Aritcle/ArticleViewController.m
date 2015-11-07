//
//  ArticleViewController.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/16.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ArticleViewController.h"
#import "ArticleHeaderView.h"
#import "FLGlobal.h"
#import "FLCacheManager.h"
#import "MBProgressHUD.h"
#import "ArticleData.h"
#import "ArticleCellBase.h"
#import "MJRefresh.h"
#import "UIViewAdditions.h"
#import "ContentViewController.h"

@interface ArticleViewController () <UITableViewDataSource, UITableViewDelegate, ArticleHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet ArticleHeaderView * headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray * data;
@property (nonatomic, weak) NSArray * sectionArray;

@property (nonatomic) FLCacheManager * cacheManager;

@property (nonatomic, weak) MBProgressHUD * hud;
@property (nonatomic, weak) UITableView * modifyTableView;


@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.headerView.delegate = self;
    
    self.data = [NSMutableArray new];
    self.cacheManager = [FLCacheManager new];
    
    [self loadSectionFromServer];
    
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDataAtIndex:self.headerView.selectedIndex refresh:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadSectionFromServer
{
    [self.cacheManager loadSectionData:[FLGlobal articleUrl]
                             cachePath:[FLGlobal articleCachePath]
                               success:^(NSArray *sectionArray) {
                                   [self showHUD:NO];
                                   self.sectionArray = sectionArray;
                                   self.headerView.sectionArray = sectionArray;
                                   
                                   [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                       self.headerView.selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"LastIndex"];
                                   }];
                                   
                               }
                               waiting:^{
                                   [self showHUD:YES];
                               }
                                  fail:^{
                                      [self showHUD:NO];
                                      [self performSelector:@selector(loadSectionFromServer) withObject:nil afterDelay:10];
                                  }
     ];
}

- (void) showHUD: (BOOL) show
{
    if (!self.hud) {
        MBProgressHUD * hud = [[MBProgressHUD alloc] initWithView:self.tableView];
        hud.labelText = @"请等待...";
        [self.tableView addSubview:hud];
        self.hud = hud;
    }
    
    if (show) {
        [self.hud show:NO];
    }
    else {
        [self.hud hide:NO];
    }
}

- (void) loadDataAtIndex: (NSUInteger) index refresh: (BOOL) isRefresh
{
    [self.cacheManager loadDataAtSectionIndex:index
                                      refresh:NO
                                      success:^(NSString *filePath) {
                                          if (index!=self.headerView.selectedIndex) {
                                              return;
                                          }
                                          if (isRefresh) {
                                              [self.tableView.header endRefreshing];
                                          }
                                          [self showHUD:NO];
                                          [self loadDataFromFile:filePath];
                                      }
                                      waiting:^{
                                          if (!isRefresh) {
                                              [self showHUD:YES];
                                          }
                                          else {
                                              [self.tableView.header endRefreshing];
                                          }
                                      }
                                         fail:^{
                                             if (!isRefresh) {
                                                 [self showHUD:YES];
                                             }
                                             else {
                                                 [self.tableView.header endRefreshing];
                                             }
                                             
                                             UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"Funny Life" message:@"Network Error" preferredStyle:UIAlertControllerStyleAlert];
                                             
                                             [ac addAction:[UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                                 
                                             }]];
                                             
                                             [self presentViewController:ac animated:YES completion:nil];
                                         }
     ];
}

- (void) loadDataFromFile: (NSString *) path
{
    NSData * fileData = [NSData dataWithContentsOfFile:path];
    NSDictionary * objects = [NSJSONSerialization JSONObjectWithData:fileData options:NSJSONReadingMutableContainers error:nil];
    if (!objects) {
        return;
    }
    
    [self.data removeAllObjects];
    
    NSArray * dataArray = objects[@"items"];
    for (id node in dataArray) {
        ArticleItemData * data = [[ArticleItemData alloc] initWithJSONNode: node];
        [self.data addObject:data];
    }
    
    [self.tableView reloadData];
}

#pragma mark - ArticleHeaderView Delegate

- (void) headerView: (ArticleHeaderView*)header selectedIndexChanged: (NSUInteger) index
{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"LastIndex"];
    
    [self loadDataAtIndex:index refresh:NO];
}

- (void) headerView:(ArticleHeaderView *)header modify: (BOOL) modify
{
    if (!self.modifyTableView) {
        float width = self.tableView.width / 2;
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(width, self.headerView.bottom, width, 0)];
        [self.view addSubview:tableView];
        self.modifyTableView = tableView;
        self.modifyTableView.delegate = self;
        self.modifyTableView.dataSource = self;
        self.modifyTableView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    }
    
    float height = modify ? self.tableView.height * 0.8 : 0;
    CGRect target = CGRectMake(self.modifyTableView.left, self.modifyTableView.top, self.modifyTableView.width, height);

    [UIView animateWithDuration:0.2
                     animations:^{
                         self.modifyTableView.frame = target;
                     }
                     completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView==self.modifyTableView) {
        return self.sectionArray.count;
    }
    
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.modifyTableView) {
        return 36;
    }
    
    ArticleSectionData * data = self.sectionArray[self.headerView.selectedIndex];
    return [ArticleCellBase rowHeightFromType:data.contentType];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView==self.modifyTableView) {
        NSString * cellID = @"ModifyCellID";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        }
        
        ArticleSectionData * data = self.sectionArray[indexPath.row];
        cell.textLabel.text = data.title;
        cell.accessoryType = data.hidden ? UITableViewCellAccessoryNone : UITableViewCellAccessoryCheckmark;
        
        return cell;
    }

    ArticleSectionData * section = self.sectionArray[self.headerView.selectedIndex];
    NSString * cellID = section.contentType;
    
    ArticleCellBase *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    ArticleItemData * data = self.data[indexPath.row];
    cell.data = data;
    
    return cell;
}

- (NSInteger) visableSections
{
    NSInteger count = 0;
    for (ArticleSectionData * data in self.sectionArray) {
        if (!data.hidden) {
            count++;
        }
    }
    
    return count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.modifyTableView) {
        ArticleSectionData * data = self.sectionArray[indexPath.row];
        if (!data.hidden) {
            if ([self visableSections]==1) {
                return;
            }
        }
        
        data.hidden = !data.hidden;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.headerView sectionStatusChangedAtIndex:indexPath.row];
    }
    else {
        self.hidesBottomBarWhenPushed = YES;
        [self performSegueWithIdentifier:@"ShowContent" sender:indexPath];
        self.hidesBottomBarWhenPushed = NO;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowContent"]) {
        ContentViewController * vc = segue.destinationViewController;
        vc.data = self.data;
        NSIndexPath * indexPath = (NSIndexPath *)sender;
        vc.order = indexPath.row;
    }
}

@end
