//
//  JumpingJackViewController.h
//  FitWithFriends
//
//  Created by Jayant Sai on 3/31/12.
//  Copyright (c) 2012 LinkedIn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JumpingJackViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *countLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLeftLabel;
@property (nonatomic, retain) IBOutlet UIButton *button;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic, assign) NSInteger time;

- (IBAction)buttonClicked:(id)sender;
- (IBAction)cancel:(id)sender;

@end
