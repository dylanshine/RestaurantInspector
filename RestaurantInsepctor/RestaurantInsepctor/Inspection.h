//
//  Inspections.h
//  RestaurantInsepctor
//
//  Created by Dylan Shine on 7/21/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Inspection : NSObject
@property (nonatomic) NSDate *inspectionDate;
@property (nonatomic) BOOL criticalFlag;
@property (nonatomic) NSString *violationDescription;
@property (nonatomic) NSUInteger score;
-(instancetype)initWithInspectionDate:(NSDate *)date CriticalFlag:(BOOL)flag Description:(NSString *)description Score:(NSUInteger)score;
@end
