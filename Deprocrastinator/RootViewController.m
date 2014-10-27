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
@property NSMutableArray *checkmarks;
@property (strong, nonatomic) IBOutlet UITableView *toDoListTableView;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.toDoList = [@[] mutableCopy];
    self.checkmarks = [@[] mutableCopy];
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
    if ([self.checkmarks[indexPath.row] isEqual:@YES]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}


- (IBAction)onAddButtonPressed:(id)sender
{
    [self.toDoList addObject:self.toDoTextField.text];
    [self.checkmarks addObject:@NO];
    [self.toDoListTableView reloadData];
    [self.toDoTextField resignFirstResponder];
    self.toDoTextField.text = @"";
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *isChecked = [self.checkmarks objectAtIndex:indexPath.row];
    
    if ([isChecked isEqual:@NO])
    {
        [self.checkmarks replaceObjectAtIndex:indexPath.row withObject:@YES];
    }
    else
    {
        [self.checkmarks replaceObjectAtIndex:indexPath.row withObject:@NO];
    }

    [self.toDoListTableView reloadData];

}


@end
