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
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
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
        
        if ([[FoodTerms fastFood] containsObject:word]) {
            return [UIImage imageNamed:@"fastfood"];
        }
        
        if ([[FoodTerms cafe] containsObject:word]) {
            return [UIImage imageNamed:@"coffee"];
        }
        
        if ([[FoodTerms bar] containsObject:word]) {
            return [UIImage imageNamed:@"bar"];
        }
        
        if ([[FoodTerms mexican] containsObject:word]) {
            return [UIImage imageNamed:@"mexican"];
        }
        
        if ([[FoodTerms pizza] containsObject:word]) {
            return [UIImage imageNamed:@"pizza"];
        }
        
        if ([[FoodTerms chinese] containsObject:word]) {
            return [UIImage imageNamed:@"chinese"];
        }
        
        if ([[FoodTerms japanese] containsObject:word]) {
            return [UIImage imageNamed:@"japanese"];
        }
        
        if ([[FoodTerms italian] containsObject:word]) {
            return [UIImage imageNamed:@"italian"];
        }
        
        if ([[FoodTerms icecream] containsObject:word]) {
            return [UIImage imageNamed:@"icecream"];
        }
        
        if ([[FoodTerms juice] containsObject:word]) {
            return [UIImage imageNamed:@"juice"];
        }
        
        if ([[FoodTerms steakhouse] containsObject:word]) {
            return [UIImage imageNamed:@"steakhouse"];
        }
        
        if ([[FoodTerms fish] containsObject:word]) {
            return [UIImage imageNamed:@"fish"];
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
        _restaurantIcons = @[[UIImage imageNamed:@"restaurant_blue"],[UIImage imageNamed:@"restaurant_green"],[UIImage imageNamed:@"restaurant_red"],[UIImage imageNamed:@"restaurant_teal"],[UIImage imageNamed:@"restaurant_orange"]];
    }
    return _restaurantIcons;
}

@end
