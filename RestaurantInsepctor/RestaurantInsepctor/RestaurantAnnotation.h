//
//  RestaurantAnnotation.h
//  RestaurantInsepctor
//
//  Created by Mason Macias on 7/20/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface RestaurantAnnotation : NSObject <MKAnnotation>
-(instancetype)initWithName:(NSString *)name Coordinate:(CLLocationCoordinate2D)coordinate Address:(NSString *)address;
@end
