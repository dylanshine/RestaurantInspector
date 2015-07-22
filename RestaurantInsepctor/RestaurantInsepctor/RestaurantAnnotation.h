//
//  RestaurantAnnotation.h
//  RestaurantInsepctor
//
//  Created by Mason Macias on 7/20/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Restaurant.h"
@interface RestaurantAnnotation : NSObject <MKAnnotation>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
@property (nonatomic, strong) NSString *address;
@property (nonatomic) NSString *placeID;
@property (nonatomic) Restaurant *restaurant;
-(instancetype)initWithName:(NSString *)name Coordinate:(CLLocationCoordinate2D)coordinate Address:(NSString *)address Place:(NSString *)place;
-(UIImage *)setPinImage;
@end
