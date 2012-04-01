//
//  JumpingJackViewController.m
//  FitWithFriends
//
//  Created by Jayant Sai on 3/31/12.
//  Copyright (c) 2012 LinkedIn. All rights reserved.
//

#import "JumpingJackViewController.h"

#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioToolbox.h>
#import "JJDump.h"

typedef enum {
    ButtonStateStart = 0,
    ButtonStateTimer,
    ButtonStateGo
} ButtonState;

@interface JumpingJackViewController ()

@property (nonatomic, retain) CMMotionManager *motionManager;
@property (nonatomic, retain) NSOperationQueue *queue;

@property (nonatomic, assign) ButtonState buttonState;

@property (nonatomic, retain) JJDump *dump;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, assign) NSUInteger timeLeft;

@end

@implementation JumpingJackViewController

@synthesize countLabel, timeLabel, timeLeftLabel, button;
@synthesize time, timeLeft;
@synthesize doneButton;
@synthesize motionManager, queue, buttonState;
@synthesize dump, count;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.buttonState = ButtonStateStart;
    
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 0.1;
    
    self.queue = [[NSOperationQueue alloc] init];
    self.dump = [[JJDump alloc] init];
    
    self.time = 10;
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

#pragma mark - methods

- (IBAction)cancel:(id)sender {
    [self.motionManager stopDeviceMotionUpdates];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)buzz {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)updateButtonLabel:(NSNumber *)num {
    NSUInteger n = [num unsignedIntegerValue];
    if (n > 0) {
        [self.button setTitle:[NSString stringWithFormat:@"%d", n]
                     forState:UIControlStateNormal];

        [self performSelector:@selector(updateButtonLabel:)
                   withObject:[NSNumber numberWithUnsignedInteger:n-1]
                   afterDelay:1.0];
    }
    else {
        [self.button setTitle:@"GO!!!"
                     forState:UIControlStateNormal];
    }
}

- (void)updateTimeLabels {
    NSUInteger t = self.time - self.timeLeft;
    self.timeLabel.text = [NSString stringWithFormat:(t < 10 ? @"00:0%d" : @"00:%d"), t];
    self.timeLeftLabel.text = [NSString stringWithFormat:self.timeLeft < 10 ? @"00:0%d" : @"00:%d", self.timeLeft];
    
    if (self.timeLeft == 0) {
        [self stop];
    }
    else {
        self.timeLeft--;
        [self performSelector:@selector(updateTimeLabels) withObject:nil afterDelay:1.0];
    }
}

- (void)updateCount {
    self.countLabel.text = [NSString stringWithFormat:@"%d", self.count];
    
    if (self.count < 5) {
        self.count++;
        [self performSelector:@selector(updateCount) withObject:nil afterDelay:2.0];
    }
}

- (IBAction)buttonClicked:(id)sender {
    if (self.buttonState == ButtonStateStart) {
        [self updateButtonLabel:[NSNumber numberWithUnsignedInteger:3]];
        [self performSelector:@selector(start)
                   withObject:nil
                   afterDelay:3.0];
        self.buttonState = ButtonStateTimer;
    }
    else {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }
}

- (void)start {
    self.button.enabled = NO;
    self.button.alpha = 0.66;
    self.buttonState = ButtonStateGo;
    
    [self updateCount];
    
//    [self.motionManager startDeviceMotionUpdatesToQueue:self.queue
//                                            withHandler:^(CMDeviceMotion *motion, NSError *error) {
//                                                if (error) {
//                                                    [self stop];
//                                                }
//                                                else {
//                                                    if (isJJ(self.dump, motion.gravity.x, motion.gravity.y, motion.gravity.z)) {
//                                                        self.count++;
//                                                        [self performSelectorOnMainThread:@selector(updateCount)
//                                                                               withObject:nil
//                                                                            waitUntilDone:NO];
//                                                    }
//                                                }
//                                            }];
    
    [self buzz];
    self.timeLeft = self.time;
    [self updateTimeLabels];
}

- (void)stop {
    [self buzz];
    self.button.enabled = YES;
    self.doneButton.enabled = YES;
    self.button.alpha = 1.0;
    self.buttonState = ButtonStateStart;
    [self.motionManager stopDeviceMotionUpdates];
    [self.button setTitle:@"Retry" forState:UIControlStateNormal];
}

@end
