//
//  RestaurantAnnotation.m
//  RestaurantInsepctor
//
//  Created by Mason Macias on 7/20/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import <Asterism/Asterism.h>
#import "RestaurantAnnotation.h"
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
@interface RestaurantAnnotation()
@property (nonatomic, strong) NSArray *restaurantIcons;
@end


@implementation RestaurantAnnotation

-(instancetype)initWithName:(NSString *)name Coordinate:(CLLocationCoordinate2D)coordinate Address:(NSString *)address Place:(NSString *)place
{

    
    if (self =  [super init]) {
        _name = name;
        _address = address;
        _placeID = place;
        _theCoordinate = coordinate;
    }
    
    return self;
}


- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return self.address;
}

- (CLLocationCoordinate2D)coordinate {
        return self.theCoordinate;
}

- (MKMapItem *)mapItem
{
    NSDictionary *addressDict = @{(NSString *)kABPersonAddressStreetKey:self.address};
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];

    mapItem.name = self.title;
    
    return mapItem;
}

-(UIImage *)setPinImage {
    
    UIImage *restaurantImage = [UIImage imageNamed:@"restaurantImageNoBorder"];
    
    return restaurantImage;
}



@end
