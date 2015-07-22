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
@property (nonatomic, strong) NSString *mostRecentGrade;
@property (nonatomic, strong) NSString *averageGrade;
@property (nonatomic, strong) NSString *cuisineDescription;
@property (nonatomic, strong) NSMutableArray *inspections;

-(instancetype)initWithPhoneNumber:(NSString *)phoneNumber;
-(NSString *)formattedPhoneNumber;

-(void)setupRestaurantInspectionDataWithResults:(NSArray *)restaurantInspections;

@end
