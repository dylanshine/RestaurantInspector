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
#import "SVProgressHUD.h"

@interface ViewController () <MKMapViewDelegate, AFDataStoreDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *ralph;
@property (assign, nonatomic) INTULocationRequestID locationRequestID;
@property (nonatomic) AFDataStore *dataStore;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocation *currentLocation;
@property (nonatomic) BOOL loaded;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ralphVerticalSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ralphHorizontalSpace;
@property (weak, nonatomic) NSLayoutConstraint *ralphXCoordinate;
@property (weak, nonatomic) NSLayoutConstraint *ralphYCoordinate;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.dataStore = [AFDataStore sharedData];
    self.dataStore.delegate = self;
    self.mapView.delegate = self;
    self.locationRequestID = NSNotFound;
    [self.mapView setShowsUserLocation:YES];
    self.mapView.zoomEnabled = NO;
    self.mapView.scrollEnabled = YES;
    [self.mapView setShowsPointsOfInterest:NO];
    [self startLocationUpdateSubscription];
    

}

-(void) setupMap {
    [self.dataStore getRestaurantsWith:600 CurrentLocation:self.currentLocation];
}

-(void)dataStore:(AFDataStore *)dataStore didLoadRestaurants:(NSArray *)restaurants
{
    [self plotRestaurants:restaurants];
}


-(void)ralphAnimateOnToScreen
{
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.ralphHorizontalSpace.constant = -50;
                         self.ralphVerticalSpace.constant = 0;
                         
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         
                     }];

}

-(void)ralphAnimateOffScreen
{
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.ralphVerticalSpace.constant = 600;
                         self.ralphHorizontalSpace.constant = -400;
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         
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
            if (!strongSelf.loaded) {
                [self centerMapOnLocation:self.currentLocation];
               [strongSelf setupMap];
                strongSelf.loaded = YES;
                [SVProgressHUD showWithStatus:@"Loading Restaurants" maskType:SVProgressHUDMaskTypeBlack];
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

-(void)plotRestaurants:(NSArray *)restaurants
{
    
    for (NSDictionary *restaurant in restaurants) {
        NSNumber *latitude = restaurant[@"geometry"][@"location"][@"lat"];
        NSNumber *longitude = restaurant[@"geometry"][@"location"][@"lng"];
        NSString *name = restaurant[@"name"];
        NSString *address = restaurant[@"vicinity"];
        NSString *placeID = restaurant[@"place_id"];
        
        
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
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        RestaurantAnnotation *restaurant = (RestaurantAnnotation *)annotationView.annotation;
        annotationView.canShowCallout = YES;
        annotationView.highlighted = YES;
        annotationView.image = [restaurant setPinImage] ;
        
        UIImage *ralphButtonImage = [UIImage imageNamed:@"ralph1"];
        
        UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        detailButton.frame = CGRectMake(141,5,30,30);
        [detailButton setImage:ralphButtonImage forState:UIControlStateNormal];
        detailButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [detailButton setTitle:annotation.title forState:UIControlStateNormal];
        
        annotationView.rightCalloutAccessoryView = detailButton;

    } else {
        annotationView.annotation = annotation;

    }
    
    return annotationView;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    RestaurantAnnotation *restaurantAnnotation = (RestaurantAnnotation *)view.annotation;
    
    if (!restaurantAnnotation.restaurant) {
        [self.dataStore getDetailsForRestaurantID:restaurantAnnotation.placeID Completion:^(NSString *phoneNumber) {
            restaurantAnnotation.restaurant = [[Restaurant alloc] initWithPhoneNumber:phoneNumber];
            [self.dataStore getRestaurantInfoWithCompletion:[restaurantAnnotation.restaurant formattedPhoneNumber]
                                            completionBlock:^(NSArray *results) {
                                                if (!restaurantAnnotation.restaurant.inspections.count) {
                                                    [restaurantAnnotation.restaurant setupRestaurantInspectionDataWithResults:results];
                                                    NSLog(@"%@",restaurantAnnotation.restaurant);
                                                }
                                                
                                                [UIView animateWithDuration:1.0
                                                                 animations:^{
                                                                     [self.mapView setCenterCoordinate:restaurantAnnotation.coordinate animated:NO];
                                                                 }
                                                                 completion:^(BOOL finished) {
                                                                      [self ralphAnimateOnToScreen];
                                                                 }];
                                    
                                               
                                            }];
        }];
    }
    
}


- (IBAction)centerMapOnUserLocation:(UIButton *)sender {
    [self.mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
}

@end
