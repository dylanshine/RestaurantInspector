//
//  AFDataStore.m
//  RestaurantInsepctor
//
//  Created by Dylan Shine on 7/20/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import "AFDataStore.h"
#import <AFNetworking/AFNetworking.h>
#import "Constants.h"
#import "SVProgressHUD.h"
#import <SIAlertView/SIAlertView.h>

static const NSString *kGooglePlacesURL = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?";
static const NSString *kGooglePlaceDetailURL = @"https://maps.googleapis.com/maps/api/place/details/json?placeid=";
@interface AFDataStore()
@end

@implementation AFDataStore

+ (instancetype)sharedData {
    static AFDataStore *_sharedData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedData = [[self alloc] init];
        _sharedData.results = [[NSMutableArray alloc] init];
    });
    
    return _sharedData;
}

-(void)getRestaurantsWith:(NSInteger)radius CurrentLocation:(CLLocation *)currentLocation {
    
    NSString *apiURL = [NSString stringWithFormat:@"%@location=%f,%f&radius=%lu&types=restaurant&key=%@", kGooglePlacesURL,currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, (long)radius, kGooglePlacesAPI];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:13];
    [manager GET:apiURL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             for (NSDictionary *restaurant in responseObject[@"results"]) {
                 [self.results addObject:restaurant];
             }
             
             
             if (responseObject[@"next_page_token"]) {
                 [self getNextPageOfResults:apiURL NextPageToken:responseObject[@"next_page_token"]];
             } else {
                 [SVProgressHUD dismiss];
             }
             
             [self.delegate dataStore:self didLoadRestaurants:responseObject[@"results"]];
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             if ([error.localizedDescription isEqualToString:@"The request timed out."]) {
                 [self showTimeOutAlert];
             }
         }];
}

- (void)getDetailsForRestaurantID:(NSString *)placeID Completion:(void (^)(NSString *))completion{
    NSString *detailURL = [NSString stringWithFormat:@"%@%@&key=%@",kGooglePlaceDetailURL,placeID,kGooglePlacesAPI];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:5];
    [manager GET:detailURL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             completion(responseObject[@"result"][@"formatted_phone_number"]);

             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             if ([error.localizedDescription isEqualToString:@"The request timed out."]) {
                 [self showTimeOutAlert];
             }
         }];
}

-(void)getNextPageOfResults:(NSString *)apiURL NextPageToken:(NSString *)token {
    
    NSString *url = [NSString stringWithFormat:@"%@&pagetoken=%@",apiURL,token];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.requestSerializer setTimeoutInterval:5];
        [manager GET:url
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 
                 
                 for (NSDictionary *restaurant in responseObject[@"results"]) {
                     [self.results addObject:restaurant];
                 }
                 
                 if (responseObject[@"next_page_token"]) {
                     [self getNextPageOfResults:apiURL NextPageToken:responseObject[@"next_page_token"]];
                 } else {
                     [SVProgressHUD dismiss];
                 }
                 
                 [self.delegate dataStore:self didLoadRestaurants:responseObject[@"results"]];
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 NSLog(@"Error: %@", error);
                 if ([error.localizedDescription isEqualToString:@"The request timed out."]) {
                     [self showTimeOutAlert];
                 }
             }];
    });
    

}

//NYC OPEN DATA
-(void)getRestaurantInfoWithCompletion:(NSString *)phoneNumber completionBlock:(void(^)(NSArray *))completionBlock
{
    NSString *nycOpenDataUrl = [NSString stringWithFormat:@"https://data.cityofnewyork.us/resource/9w7m-hzhe.json?%@&phone=%@",kNycOpenDataAPI,phoneNumber];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:5];
    [manager GET:nycOpenDataUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        completionBlock(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Failure:%@",error.description);
        if ([error.localizedDescription isEqualToString:@"The request timed out."]) {
            [self showTimeOutAlert];
        }
    }];
    
}

-(void)showTimeOutAlert {
    [SVProgressHUD dismiss];
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Request Timed Out" andMessage:@"Inspector Ralph doesn't have a good connection right now."];
    alertView.titleColor = [UIColor colorWithRed:230.0f/255.0f green:83.0f/255.0f blue:54.0f/255.0f alpha:1.0f];
    
    [alertView addButtonWithTitle:@"Okay"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alert) {
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
}


@end
