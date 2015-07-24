//
//  Restaurant.m
//  RestaurantInsepctor
//
//  Created by Mason Macias on 7/21/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import "Restaurant.h"
#import "Inspection.h"

@implementation Restaurant
-(instancetype)initWithPhoneNumber:(NSString *)phoneNumber Name:(NSString *)name
{
    self = [super init];
    if (self) {
        _phoneNumber = phoneNumber;
        _name = name;
        _inspections = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)setupRestaurantInspectionDataWithResults:(NSArray *)restaurantInspections {
    [self createAverage:restaurantInspections];
    [self findMostRecentGrade:restaurantInspections];
    [self getRestaurantCuisineDescription:restaurantInspections];
    [self createInspections:restaurantInspections];
}


- (NSString *)formattedPhoneNumber {
    NSArray *phoneArray = [self.phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    
    NSString *formattedPhoneNumber = [phoneArray componentsJoinedByString:@""];
    return formattedPhoneNumber;
}

-(void)createAverage:(NSArray *)restaurantInspections {
    NSMutableArray *scores = [NSMutableArray array];
    
    for (NSDictionary *inspection in restaurantInspections) {
        if (inspection[@"score"]) {
            [scores addObject:inspection[@"score"]];
        }
    }
    NSInteger totalOfScores = 0;
    
    for (NSNumber *score in scores) {
        totalOfScores += score.integerValue;
    }

   self.averageGrade = [NSString stringWithFormat:@"%lu",totalOfScores / scores.count];
}

-(NSString *)convertScoreToGrade:(NSInteger)score {
    
    if (score <= 14) {
        return @"A";
    } else if (score > 14 && score < 28) {
        return @"B";
    } else if (score > 27 ) {
        return @"C";
    } else {
       return @"N/A";
    }
    
}

-(void)findMostRecentGrade:(NSArray *)restaurantInspections {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *mostRecentDate = [[NSDate alloc] init];
    NSString *mostRecentGrade;
    
    
    for (NSDictionary *inspection in restaurantInspections) {
        NSString *dateString = [inspection[@"inspection_date"] substringToIndex:10];
        NSDate *date = [dateFormatter dateFromString:dateString];
        
        if (date > mostRecentDate && [inspection[@"score"] integerValue]) {
            mostRecentDate = date;
            mostRecentGrade = [self convertScoreToGrade:[inspection[@"score"] integerValue]];
        }
    }
    
    self.mostRecentGrade = mostRecentGrade;
}

-(void)getRestaurantCuisineDescription:(NSArray *)restaurantInspections {
    self.cuisineDescription = [restaurantInspections firstObject][@"cuisine_description"];
}

-(void)createInspections:(NSArray *)restaurantInspections {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    for (NSDictionary *resultInspection in restaurantInspections) {
        
        if (resultInspection[@"inspection_date"] && [resultInspection[@"score"] integerValue]) {
            NSString *dateString = [resultInspection[@"inspection_date"] substringToIndex:10];
            NSDate *date = [dateFormatter dateFromString:dateString];
            
            Inspection *inspection = [[Inspection alloc] initWithInspectionDate:date
                                                                   CriticalFlag:[self criticalValue:resultInspection[@"critical_flag"]]
                                                                    Description:resultInspection[@"violation_description"]
                                                                          Score:[resultInspection[@"score"] integerValue]];
            [self.inspections addObject:inspection];
        }
    }
    [self sortInspectionsByDate];
}

-(BOOL)criticalValue:(NSString *)criticalFlag {
    if ([criticalFlag isEqualToString:@"Not Critical"]) {
        return NO;
    }
    return YES;
}

-(NSString *)textBubbleMessage {
    if (!self.mostRecentGrade) {
        return [NSString stringWithFormat:@"I couldn't find the current grade for %@.\nPlease try again later.", self.name];
    } else {
        return [NSString stringWithFormat:@"%@ currently holds a Grade %@ sanitary inspection with %lu critical violations.\nPlease tap for more details...ya heard?!",self.name,self.mostRecentGrade,(unsigned long)[self criticalViolations]];
    }
}

-(void)sortInspectionsByDate {
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"inspectionDate" ascending:NO];
    NSArray *descriptors = [NSArray arrayWithObject:descriptor];
    self.inspections = [[self.inspections sortedArrayUsingDescriptors:descriptors] mutableCopy];
}

-(NSUInteger)criticalViolations {
    NSUInteger criticalViolationsCount = 0;
    for (Inspection *inspection in self.inspections) {
        if (inspection.criticalFlag) {
            criticalViolationsCount++;
        }
    }
    return criticalViolationsCount;
}

@end
