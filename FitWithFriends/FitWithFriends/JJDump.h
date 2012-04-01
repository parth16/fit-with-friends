//
//  JJDump.h
//  FitWithFriends
//
//  Created by Jayant Sai on 3/31/12.
//  Copyright (c) 2012 LinkedIn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJDump : NSObject

@property (nonatomic, assign) double last_x;
@property (nonatomic, assign) double dir;
@property (nonatomic, assign) double trip;
@property (nonatomic, assign) int samples;
@property (nonatomic, assign) double travelled;

@end

extern BOOL isJJ(JJDump *dump, double x, double y, double z);
