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

    cell.textLabel.text = toDoItem.text;
    if (toDoItem.isChecked) {
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

    [self.toDoItemArray removeObjectAtIndex:indexPath.row];

    [self.toDoListTableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ToDoItemClass *toDoItem = [self.toDoItemArray objectAtIndex:indexPath.row];
    
    toDoItem.isChecked = !toDoItem.isChecked;

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

        ToDoItemClass *toDoItem = [[ToDoItemClass alloc] init];

        toDoItem.text = self.toDoTextField.text;
        toDoItem.isChecked = NO;
        toDoItem.textColor = @[[UIColor blackColor], [UIColor greenColor], [UIColor yellowColor], [UIColor redColor], nil];
        
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
