//
//  RestViewController.m
//  FunnyLife
//
//  Created by Wang Haitao on 15/10/14.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "RestViewController.h"

@interface RestViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *fromButton;
@property (weak, nonatomic) IBOutlet UIButton *toButton;

@property (nonatomic) NSDate * fromTime;
@property (nonatomic) NSDate * toTime;

@property (nonatomic) BOOL start;

@end

@implementation RestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString * startTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"StartTime"];
    NSString * endTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"EndTime"];
    
    NSDateFormatter * df = [NSDateFormatter new];
    [df setDateFormat:@"HH:mm"];

    self.fromTime = [df dateFromString:startTime];
    self.toTime = [df dateFromString:endTime];
    
    self.start = NO;
    [self setTimeButtonText];
    
    self.start = YES;
    [self setTimeButtonText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setStart:(BOOL)start
{
    _start = start;
    
    if (_start) {
        self.fromButton.backgroundColor = [UIColor lightGrayColor];
        self.toButton.backgroundColor = [UIColor whiteColor];
    }
    else {
        self.fromButton.backgroundColor = [UIColor whiteColor];
        self.toButton.backgroundColor = [UIColor lightGrayColor];
    }
    
    [self.datePicker setDate:_start ? self.fromTime : self.toTime animated:YES];
}

- (void) setTimeButtonText
{
    NSDateFormatter * df = [NSDateFormatter new];
    [df setDateFormat:@"HH:mm"];
    
    if (self.start) {
        NSString * title = [@"从 " stringByAppendingString: [df stringFromDate:self.fromTime]];
        [self.fromButton setTitle:title forState:UIControlStateNormal];
    }
    else {
        NSString * title = [@"至 " stringByAppendingString: [df stringFromDate:self.toTime]];
        [self.toButton setTitle:title forState:UIControlStateNormal];
    }
}

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender
{
    NSDateFormatter * df = [NSDateFormatter new];
    [df setDateFormat:@"HH:mm"];
    NSString * time = [df stringFromDate:sender.date];
    
    if (self.start) {
        self.fromTime = sender.date;
        [[NSUserDefaults standardUserDefaults] setValue:time forKey:@"StartTime"];
    }
    else {
        self.toTime = sender.date;
        [[NSUserDefaults standardUserDefaults] setValue:time forKey:@"EndTime"];
    }
    
    [self setTimeButtonText];
}

- (IBAction)fromButtonClicked:(UIButton *)sender
{
    self.start = YES;
}

- (IBAction)toButtonClicked:(UIButton *)sender
{
    self.start = NO;
}

@end
