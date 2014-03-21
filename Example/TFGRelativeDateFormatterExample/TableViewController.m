//
//  TableViewController.m
//  TFGRelativeDateFormatterExample
//
//  Created by Thomas on 21/03/2014.
//  Copyright (c) 2014 Thomas Guthrie. All rights reserved.
//

#import "TableViewController.h"

#import <TFGRelativeDateFormatter/TFGRelativeDateFormatter.h>

@interface TableViewController ()

@property (nonatomic) NSArray *data;
@property (nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation TableViewController

#pragma mark - View management

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableArray *data = [NSMutableArray array];

    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];

    NSDate *today = [NSDate date];
    NSCalendar *calendar = [TFGRelativeDateFormatter sharedFormatter].calendar;
    NSDateComponents *components = [[NSDateComponents alloc] init];

    for (int i=0; i < 9; ++i) {
        [components setDay:-i];
        [data addObject:[calendar dateByAddingComponents:components toDate:today options:0]];
    }

    [components setYear:-1];
    [data addObject:[calendar dateByAddingComponents:components toDate:today options:0]];

    [components setYear:-2];
    [data addObject:[calendar dateByAddingComponents:components toDate:today options:0]];

    self.data = [data copy];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:@"Cell"];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *date = [self.data objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.dateFormatter stringFromDate:date];
    cell.detailTextLabel.text = [[TFGRelativeDateFormatter sharedFormatter] stringForDate:date];
}

@end
