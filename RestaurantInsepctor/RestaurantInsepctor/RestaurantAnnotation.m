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
#import "FoodTerms.h"
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
    NSArray *nameArray = [self.name componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
   nameArray = ASTMap(nameArray, ^id(id obj) {
        return [obj lowercaseString];
    });
    
    for (NSString *word in nameArray) {
        
        if ([[FoodTerms latin] containsObject:word]) {
            return [UIImage imageNamed:@"latin"];
        } else if ([[FoodTerms pizza] containsObject:word]) {
            return [UIImage imageNamed:@"pizza"];
        } else if ([[FoodTerms chinese] containsObject:word]) {
            return [UIImage imageNamed:@"chinese"];
        } else if ([[FoodTerms japanese] containsObject:word]) {
            return [UIImage imageNamed:@"japanese"];
        } else if ([[FoodTerms italian] containsObject:word]) {
            return [UIImage imageNamed:@"italian"];
        } else if ([[FoodTerms icecream] containsObject:word]) {
            return [UIImage imageNamed:@"icecream"];
        } else if ([[FoodTerms juice] containsObject:word]) {
            return [UIImage imageNamed:@"juice"];
        } else if ([[FoodTerms steakhouse] containsObject:word]) {
            return [UIImage imageNamed:@"steakhouse"];
        } else if ([[FoodTerms fish] containsObject:word]) {
            return [UIImage imageNamed:@"fish"];
        } else if ([[FoodTerms wine] containsObject:word]) {
            return [UIImage imageNamed:@"winebar"];
        } else if ([[FoodTerms thai] containsObject:word]) {
            return [UIImage imageNamed:@"thai"];
        } else if ([[FoodTerms korean] containsObject:word]) {
            return [UIImage imageNamed:@"korean"];
        } else if ([[FoodTerms tapas] containsObject:word]) {
            return [UIImage imageNamed:@"tapas"];
        } else if ([[FoodTerms mediterranean] containsObject:word]) {
            return [UIImage imageNamed:@"mediterranean"];
        } else if ([[FoodTerms indian] containsObject:word]) {
            return [UIImage imageNamed:@"indian"];
        } else if ([[FoodTerms cafe] containsObject:word]) {
            return [UIImage imageNamed:@"coffee"];
        } else if ([[FoodTerms fastFood] containsObject:word]) {
            return [UIImage imageNamed:@"fastfood"];
        } else if ([[FoodTerms bar] containsObject:word]) {
            return [UIImage imageNamed:@"bar"];
        }
        
    }
    
    return [self randomRestaurantIcon];
}

- (UIImage *)randomRestaurantIcon
{
    int randomIndex = arc4random()%[self.restaurantIcons count];
    return [self.restaurantIcons objectAtIndex:randomIndex];
}

-(NSArray *)restaurantIcons {
    if (!_restaurantIcons) {
        _restaurantIcons = @[[UIImage imageNamed:@"restaurant1"],[UIImage imageNamed:@"restaurant2"]];
    }
    return _restaurantIcons;
}

@end
