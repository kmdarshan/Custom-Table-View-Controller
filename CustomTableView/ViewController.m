//
//  ViewController.m
//  CustomTableView
//
//  Created by Darshan Katrumane on 5/6/15.
//  Copyright (c) 2015 Darshan Katrumane. All rights reserved.
//

#import "ViewController.h"
#import "RRComplaint.h"
@interface ViewController ()
{
    NSMutableArray *rows;
    RRTableView *tableview;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void) setup {
    rows = [NSMutableArray new];
    [self readFromFile];
    tableview = [[RRTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [tableview setDelegate:self];
    [tableview setDataSource:self];
    [self.view addSubview:tableview];
    [tableview reloadData];
}

-(void) readFromFile {
    NSString *txtFilePath = [[NSBundle mainBundle] pathForResource:@"Consumer_Complaints_trimmed" ofType:@"csv"];
    RRComplaint *complaint = [RRComplaint new];
    NSMutableArray *complaints = [complaint parseFile:txtFilePath];
    rows = [complaints mutableCopy];
}
- (RRTableViewCell*) tableView:(RRTableView *)tableView cellForRowAtIndex:(NSInteger)row
{
    static NSString* cellIdentifier = @"Complaints";
    RRComplaint *complaint = [rows objectAtIndex: row];
    RRTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if (!cell)
    {
        // todo calculate height of the row dynamically
        cell = [[RRTableViewCell alloc] initWithIdentifier:cellIdentifier andFrame:CGRectMake(0.0, 0.0, [tableview bounds].size.width, 44.0f)];
    }
    [cell setDetailedLabelText:complaint.type];
    [cell setTitleLabelText:complaint.name];
    return cell;
}

-(NSInteger)numberOfRows:(RRTableView *)tableView {
    return [rows count];
}
-(CGFloat)tableView:(RRTableView *)tableView heightForRow:(NSInteger)row {
    return 44.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
