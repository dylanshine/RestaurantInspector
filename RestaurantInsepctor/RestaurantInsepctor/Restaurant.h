//
//  Restaurant.h
//  RestaurantInsepctor
//
//  Created by Mason Macias on 7/21/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *averageGrade;
@property (nonatomic, strong) NSString *cuisineDescription;

-(instancetype)initWithPhoneNumber:(NSString *)phoneNumber;
-(NSString *)formattedPhoneNumber;
+(NSString *)mostRecentScore:(NSArray *)restaurantInspections;
+(NSString *)convertScoreToGrade:(NSString *)score;
+(NSString *)createAverage:(NSArray *)restaurantInspections;

@end
