//
//  Restaurant.m
//  RestaurantInsepctor
//
//  Created by Mason Macias on 7/21/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant
-(instancetype)initWithPhoneNumber:(NSString *)phoneNumber
{
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
@end
