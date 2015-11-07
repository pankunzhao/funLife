//
//  MoreTableViewController.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/14.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "MoreTableViewController.h"

@interface MoreTableViewController ()

@property (weak, nonatomic) IBOutlet UITableViewCell *addFriendCell;


@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UISwitch *restSwitch;


@end

@implementation MoreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString * startTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"StartTime"];
    NSString * toTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"EndTime"];
    
    if (startTime.length==0) {
        startTime = @"12:23";
        toTime = @"16:56";
        [[NSUserDefaults standardUserDefaults] setValue:startTime forKey:@"StartTime"];
        [[NSUserDefaults standardUserDefaults] setValue:toTime forKey:@"EndTime"];
    }
    
    self.fromLabel.text = startTime;
    self.toLabel.text = toTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addFriendSwitchValueChanged:(UISwitch *)sender
{
    self.addFriendCell.textLabel.enabled = sender.isOn;
    self.addFriendCell.userInteractionEnabled = sender.isOn;
}

- (IBAction)allowRestSwitchValueChanged:(UISwitch *)sender
{
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation: UITableViewRowAnimationNone];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==2) {
        return self.restSwitch.isOn ? 2 : 1;
    }

    return [super tableView:tableView numberOfRowsInSection:section];
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
