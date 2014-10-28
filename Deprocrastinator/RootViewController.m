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

//    cell.textLabel.textColor = [UIColor blackColor];


    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.toDoList removeObjectAtIndex:indexPath.row];
    [self.checkmarks removeObjectAtIndex:indexPath.row];

    [self.toDoListTableView reloadData];
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
    
    
    // if in Edit mode (edit button = DONE)
    

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark - IBActions

- (IBAction)onAddButtonPressed:(UIButton *)gesture
{
    if (![self.toDoTextField.text isEqualToString:@""])
    {
        [self.toDoList addObject:self.toDoTextField.text];
        [self.checkmarks addObject:@NO];
        [self.toDoListTableView reloadData];
        [self.toDoTextField resignFirstResponder];
        self.toDoTextField.text = @"";
        
    }
}


- (IBAction)onEditButtonPressed:(UIButton *)gesture
{

    if ([gesture.titleLabel.text isEqualToString:@"Edit"])
    {
        [gesture setTitle:@"Done" forState:UIControlStateNormal];

        [self.toDoListTableView setEditing: YES animated: YES];
    }
    else
    {
        [gesture setTitle:@"Edit" forState:UIControlStateNormal];

        [self.toDoListTableView setEditing: NO animated: YES];

    }

    [self.toDoListTableView reloadData];

}

- (IBAction)onSwipeToPriority:(UISwipeGestureRecognizer *)gesture
{
    CGPoint touchPoint = [gesture locationInView:self.toDoListTableView];
    
    
    NSIndexPath *swipedRowIndex = [self.toDoListTableView indexPathForRowAtPoint:touchPoint];
    NSLog(@"%li", (long)swipedRowIndex.row);
    
    UITableViewCell *swipedCell = [self.toDoListTableView cellForRowAtIndexPath:swipedRowIndex];
    
    if (swipedCell.textLabel.textColor != [UIColor greenColor] && swipedCell.textLabel.textColor != [UIColor yellowColor] && swipedCell.textLabel.textColor != [UIColor redColor] && swipedCell.textLabel.textColor != [UIColor blackColor])
    {
        swipedCell.textLabel.textColor = [UIColor greenColor];
    }
    else if (swipedCell.textLabel.textColor == [UIColor greenColor])
    {
        swipedCell.textLabel.textColor = [UIColor yellowColor];
    }
    else if (swipedCell.textLabel.textColor == [UIColor yellowColor])
    {
        swipedCell.textLabel.textColor = [UIColor redColor];
    }
    else if (swipedCell.textLabel.textColor == [UIColor redColor])
    {
        swipedCell.textLabel.textColor = [UIColor blackColor];
    }
    else if (swipedCell.textLabel.textColor == [UIColor blackColor])
    {
        swipedCell.textLabel.textColor = [UIColor greenColor];
    }
    
    
}

@end
