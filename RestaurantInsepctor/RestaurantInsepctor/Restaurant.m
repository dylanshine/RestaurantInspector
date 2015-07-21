//
//  Restaurant.m
//  RestaurantInsepctor
//
//  Created by Mason Macias on 7/21/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant
-(instancetype)initWithPhoneNumber:(NSString *)phoneNumber {
    self = [super init];
    if (self) {
        _phoneNumber = phoneNumber;
    }
    
    return self;
}

- (NSString *)formattedPhoneNumber {
    NSArray *phoneArray = [self.phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    
    NSString *formattedPhoneNumber = [phoneArray componentsJoinedByString:@""];
    return formattedPhoneNumber;
}

+(NSString *)createAverage:(NSArray *)restaurantInspections
{
    NSMutableArray *scores = [NSMutableArray array];
    
    for (NSDictionary *inspection in restaurantInspections) {
        [scores addObject:inspection[@"score"]];
    }
    NSInteger totalOfScores = 0;
    
    for (NSNumber *score in scores) {
        totalOfScores += score.integerValue;
    }
    
    return [NSString stringWithFormat:@"%lu", totalOfScores /scores.count];
    
}

+(NSString *)convertScoreToGrade:(NSString *)score
{
    
    if (score.integerValue <= 14) {
        return @"A";
    }
    
    if (score.integerValue > 14 && score.integerValue < 28) {
        return @"B";
    }
    
    if (score.integerValue > 27 ) {
        return @"C";
    }
    
    return @"Z";
}

+(NSString *)mostRecentScore:(NSArray *)restaurantInspections
{
    NSMutableArray *inspectionDatesMut = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSMutableArray *formattedDates = [NSMutableArray array];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    for (NSDictionary *inspection in restaurantInspections)
    {
        [inspectionDatesMut addObject:[inspection[@"inspection_date"] substringToIndex:9]];
    }
    
    
    for (NSString *date in inspectionDatesMut)
    {
        NSDate *dateFromString = [dateFormatter dateFromString:date];
        [formattedDates addObject:dateFromString];
    }
    
    NSDate *mostRecentDate = [formattedDates valueForKeyPath:@"@max.self"];
    
    return [NSString stringWithFormat:@"%@",mostRecentDate];
    
}

@end
