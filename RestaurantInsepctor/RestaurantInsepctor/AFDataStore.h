//
//  AFDataStore.h
//  RestaurantInsepctor
//
//  Created by Dylan Shine on 7/20/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface AFDataStore : NSObject
+(instancetype)sharedData;
-(void)getRestaurantsWith:(NSInteger)radius CurrentLocation:(CLLocation *)currentLocation;
@end
