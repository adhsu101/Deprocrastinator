//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Mobile Making on 10/27/14.
//  Copyright (c) 2014 Alex Hsu. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *toDoTextField;
@property NSMutableArray *toDoList;
@property (strong, nonatomic) IBOutlet UITableView *toDoListTableView;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.toDoList = [@[] mutableCopy];
}

#pragma mark - tableview delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"toDoItemCell" forIndexPath:indexPath];

    cell.textLabel.text = self.toDoList[indexPath.row];

    return cell;
}


- (IBAction)onAddButtonPressed:(id)sender
{
    [self.toDoList addObject:self.toDoTextField.text];
    [self.toDoListTableView reloadData];
    [self.toDoTextField resignFirstResponder];
    self.toDoTextField.text = @"";
}


@end
