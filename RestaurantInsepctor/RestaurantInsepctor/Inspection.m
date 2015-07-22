//
//  Inspections.m
//  RestaurantInsepctor
//
//  Created by Dylan Shine on 7/21/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import "Inspection.h"

@implementation Inspection
-(instancetype)initWithInspectionDate:(NSDate *)date CriticalFlag:(BOOL)flag Description:(NSString *)description Score:(NSUInteger)score {
    if (self = [super init]) {
        _inspectionDate = date;
        _criticalFlag = flag;
        _violationDescription = description;
        _score = score;
    }
    return self;
}
@end
