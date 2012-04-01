//
//  TaskCompleteViewController.m
//  FitWithFriends
//
//  Created by Jayant Sai on 3/31/12.
//  Copyright (c) 2012 LinkedIn. All rights reserved.
//

#import "TaskCompleteViewController.h"
#import "AppDelegate.h"

@interface TaskCompleteViewController ()

@property (nonatomic, retain) NSArray *nextTasks;

@end

@implementation TaskCompleteViewController

@synthesize nextTasks;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.nextTasks = [NSArray arrayWithObjects:
                      @"Climb 100 stairs",
                      @"Run a mile in 7 minutes",
                      @"75 jumping jacks",
                      @"40 pushups in 1 minute",
                      @"30 situps in 1 minute",
                      @"No new challenge",
                      nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ScoreCellIdentifier = @"ScoreCellIdentifier";
    static NSString *NextTastCellIdentifier = @"NextTastCellIdentifier";
    
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:ScoreCellIdentifier];
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:NextTastCellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NextTastCellIdentifier];
            }
            cell.textLabel.text = [self.nextTasks objectAtIndex:indexPath.row];
            
            break;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"Next Challenge for Parth";
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 64.0;
    }
    
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 5) {
            [self.navigationController dismissModalViewControllerAnimated:YES];
        }
        else {
            NSString *task = [self.nextTasks objectAtIndex:indexPath.row];
            ((AppDelegate *)[UIApplication sharedApplication].delegate).taskDone = task;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Parth's Next Challenge"
                                                            message:task
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
