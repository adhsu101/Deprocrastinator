//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Mobile Making on 10/27/14.
//  Copyright (c) 2014 Alex Hsu. All rights reserved.
//

#import "RootViewController.h"
#import "ToDoItemClass.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *toDoTextField;
@property NSMutableArray *toDoItemArray;
@property (strong, nonatomic) IBOutlet UITableView *toDoListTableView;

@end

@implementation RootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.toDoItemArray = [@[] mutableCopy];

}

#pragma mark - tableview delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDoItemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"toDoItemCell" forIndexPath:indexPath];

    ToDoItemClass *toDoItem = self.toDoItemArray[indexPath.row];

    cell.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = toDoItem.color;
    cell.textLabel.text = toDoItem.text;

    if (toDoItem.isChecked)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:nil preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

    UIAlertAction *deleteButton = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.toDoItemArray removeObjectAtIndex:indexPath.row];
        [self.toDoListTableView reloadData]; 
    }];

    [alert addAction:cancelButton];
    [alert addAction:deleteButton];

    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ToDoItemClass *toDoItem = [self.toDoItemArray objectAtIndex:indexPath.row];
    
    toDoItem.isChecked = !toDoItem.isChecked;

    [self.toDoListTableView reloadData];
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = [self.toDoItemArray objectAtIndex:sourceIndexPath.row];
    [self.toDoItemArray removeObjectAtIndex:sourceIndexPath.row];
    [self.toDoItemArray insertObject:stringToMove atIndex:destinationIndexPath.row];
}


#pragma mark - IBActions

- (IBAction)onAddButtonPressed:(UIButton *)gesture
{
    if (![self.toDoTextField.text isEqualToString:@""])
    {

        ToDoItemClass *toDoItem = [[ToDoItemClass alloc] init];

        toDoItem.text = self.toDoTextField.text;
        toDoItem.isChecked = NO;
        toDoItem.color = [UIColor whiteColor];
        
        [self.toDoItemArray addObject:toDoItem];

        [self.toDoListTableView reloadData];
        [self.toDoTextField resignFirstResponder];
        self.toDoTextField.text = @"";
    }
}


- (IBAction)onEditButtonPressed:(UIButton *)gesture
{

    if ([gesture.titleLabel.text isEqualToString:@"Edit"])
    {
        if (!self.toDoItemArray.count == 0)
        {
            [gesture setTitle:@"Done" forState:UIControlStateNormal];
            
            [self.toDoListTableView setEditing: YES animated: YES];
        }
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

    if (!self.toDoItemArray.count == 0)
        
    {

    CGPoint touchPoint = [gesture locationInView:self.toDoListTableView];
    
    NSIndexPath *swipedRowIndex = [self.toDoListTableView indexPathForRowAtPoint:touchPoint];

    UITableViewCell *swipedCell = [self.toDoListTableView cellForRowAtIndexPath:swipedRowIndex];

    ToDoItemClass *swipedToDo = [self.toDoItemArray objectAtIndex:swipedRowIndex.row];
    
    if (swipedCell.backgroundColor != [UIColor greenColor] && swipedCell.backgroundColor != [UIColor yellowColor] && swipedCell.backgroundColor != [UIColor redColor])
    {
        swipedCell.backgroundColor = [UIColor greenColor];
        swipedToDo.color =[UIColor greenColor];
    }
    else
        if (swipedCell.backgroundColor == [UIColor greenColor])
        {
            swipedCell.backgroundColor = [UIColor yellowColor];
            swipedToDo.color =[UIColor yellowColor];

        }
    else
        if (swipedCell.backgroundColor == [UIColor yellowColor])
        {
            swipedCell.backgroundColor = [UIColor redColor];
            swipedToDo.color =[UIColor redColor];

        }
    else
        if (swipedCell.backgroundColor == [UIColor redColor])
        {
            swipedCell.backgroundColor = [UIColor whiteColor];
            swipedToDo.color =[UIColor whiteColor];
        }
    }
}

@end
