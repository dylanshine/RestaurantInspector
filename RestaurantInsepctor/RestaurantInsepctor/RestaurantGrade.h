//
//  RestaurantRating.h
//  RestaurantInsepctor
//
//  Created by Mason Macias on 7/21/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestaurantGrade : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *averageGrade;
@property (nonatomic, strong) NSString *cuisineDescription;


-(instancetype)initWithName:(NSString *)name CuisineDescription:(NSString *)cuisineDescription Grade:(NSString *)grade AverageGrade:(NSString *)averageGrade;
+(NSString *)convertScoreToGrade:(NSString *)score;
+(NSString *)mostRecentScore:(NSArray *)restaurantInspections;
+(NSString *)createAverage:(NSArray *)restaurantInspections;
@end
