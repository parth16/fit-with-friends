//
//  JJDump.m
//  FitWithFriends
//
//  Created by Jayant Sai on 3/31/12.
//  Copyright (c) 2012 LinkedIn. All rights reserved.
//

#import "JJDump.h"

@implementation JJDump

@synthesize last_x, dir, trip, samples, travelled;

- (id)init {
    if (self = [super init]) {
        self.last_x = -99.0;
        self.dir = 1.0;
    }
    
    return self;
}

@end

BOOL isJJ(JJDump *dump, double x, double y, double z) {
    dump.samples++;
    
    if (dump.last_x != -99) {
        if ((x - dump.last_x) * dump.dir <= 0.0 && dump.samples > 5) {
            if (dump.travelled > 0.5) {
                dump.trip += 1.0;
                dump.dir *= -1.0;
                dump.samples = 0;
            }
            
            dump.travelled = 0.0;
        }
        
        dump.travelled += ABS(x - dump.last_x);
    }
    dump.last_x = x;
    if (dump.trip == 2.0) {
        dump.trip = 0.0;
        return YES;
    }
    return NO;
}