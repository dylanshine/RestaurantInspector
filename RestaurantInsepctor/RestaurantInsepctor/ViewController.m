//
//  ViewController.m
//  RestaurantInsepctor
//
//  Created by Dylan Shine on 7/20/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <INTULocationManager.h>
#import "AFDataStore.h"
#import "RestaurantAnnotation.h"

@interface ViewController () <MKMapViewDelegate>
@property (assign, nonatomic) INTULocationRequestID locationRequestID;
@property (nonatomic) AFDataStore *dataStore;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocation *currentLocation;
@property (nonatomic) BOOL loaded;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataStore = [AFDataStore sharedData];
    self.mapView.delegate = self;
    self.locationRequestID = NSNotFound;
    [self.mapView setShowsUserLocation:YES];
    self.mapView.zoomEnabled = NO;
    self.mapView.scrollEnabled = NO;
    [self.mapView setShowsPointsOfInterest:NO];
    [self startLocationUpdateSubscription];
}


-(void) setupMap {
    [self.dataStore getRestaurantsWith:600 CurrentLocation:self.currentLocation Completion:^{
        NSLog(@"%@", self.dataStore.results);
        [self plotRestaurants];
    }];
}

#pragma mark - UNTULocationManager

- (void)startLocationUpdateSubscription {
    __weak __typeof(self) weakSelf = self;
    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
    self.locationRequestID = [locMgr subscribeToLocationUpdatesWithBlock:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        __typeof(weakSelf) strongSelf = weakSelf;
        
        if (status == INTULocationStatusSuccess) {
            // A new updated location is available in currentLocation, and achievedAccuracy indicates how accurate this particular location is
            strongSelf.currentLocation = currentLocation;
            [self centerMapOnLocation:self.currentLocation];
            if (!strongSelf.loaded) {
               [strongSelf setupMap];
                strongSelf.loaded = YES;
            }
            
        }
        else {
            // An error occurred, which causes the subscription to cancel automatically (this block will not execute again unless it is used to start a new subscription).
            strongSelf.locationRequestID = NSNotFound;
            NSLog(@"%@", [strongSelf getErrorDescription:status]);
        }
    }];
}


- (NSString *)getErrorDescription:(INTULocationStatus)status {
    if (status == INTULocationStatusServicesNotDetermined) {
        return @"Error: User has not responded to the permissions alert.";
    }
    if (status == INTULocationStatusServicesDenied) {
        return @"Error: User has denied this app permissions to access device location.";
    }
    if (status == INTULocationStatusServicesRestricted) {
        return @"Error: User is restricted from using location services by a usage policy.";
    }
    if (status == INTULocationStatusServicesDisabled) {
        return @"Error: Location services are turned off for all apps on this device.";
    }
    return @"An unknown error occurred.\n(Are you using iOS Simulator with location set to 'None'?)";
}

#pragma mark - MapKit

-(void) centerMapOnLocation:(CLLocation *)location {
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 700, 700);
    
    [self.mapView setRegion:region];
    
}

-(void)plotRestaurants
{
    for (id<MKAnnotation>annotation in self.mapView.annotations) {
        [self.mapView removeAnnotation:annotation];
    }
    
    for (NSDictionary *restaurant in self.dataStore.results) {
        NSNumber *latitude = restaurant[@"geometry"][@"location"][@"lat"];
        NSNumber *longitude = restaurant[@"geometry"][@"location"][@"lng"];
        NSString *name = restaurant[@"name"];
        NSString *address = restaurant[@"vicinity"];
        NSString *placeID = restaurant[@"id"];
        
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = latitude.doubleValue;
        coordinate.longitude = longitude.doubleValue;
        RestaurantAnnotation *annotation = [[RestaurantAnnotation alloc] initWithName:name Coordinate:coordinate Address:address Place:placeID];
        [self.mapView addAnnotation:annotation];
    }
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"RestaurantAnnotation";
    MKAnnotationView *annotationView = (MKAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
       return nil;
    }
    
    if(!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = YES;
        annotationView.highlighted = YES;
        
        UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [detailButton setTitle:annotation.title forState:UIControlStateNormal];
        
        [detailButton addTarget:self
                         action:@selector(showDetails)
               forControlEvents:UIControlEventTouchUpInside];
        
        annotationView.rightCalloutAccessoryView = detailButton;

    } else {
        annotationView.annotation = annotation;

    }
    
    return annotationView;
}

- (void)showDetails {
    
    NSLog(@"Annotation Click");
    
}

@end
