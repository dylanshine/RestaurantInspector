//
//  Restaurant.h
//  RestaurantInsepctor
//
//  Created by Mason Macias on 7/21/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject
@property (nonatomic, strong) NSArray *nycData;
@property (nonatomic, strong) NSString *phoneNumber;

-(instancetype)initWithPhoneNumber:(NSString *)phoneNumber;
-(NSString *)formattedPhoneNumber;
@end
