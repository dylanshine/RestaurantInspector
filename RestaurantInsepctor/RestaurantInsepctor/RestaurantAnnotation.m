//
//  RestaurantAnnotation.m
//  RestaurantInsepctor
//
//  Created by Mason Macias on 7/20/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import "RestaurantAnnotation.h"
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
@interface RestaurantAnnotation()
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *address;
@end


@implementation RestaurantAnnotation

-(instancetype)initWithName:(NSString *)name Coordinate:(CLLocationCoordinate2D)coordinate Address:(NSString *)address
{

    
    if (self =  [super init]) {
        _name = name;
        _address = address;
        self.coordinate = coordinate;
    }
    
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (MKMapItem *)mapItem
{
    NSDictionary *addressDict = @{(NSString *)kABPersonAddressStreetKey:self.address};
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    mapItem.name = self.name;
    
    return mapItem;
}

@end
