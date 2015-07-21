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

static const NSString *kGoogleURL = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?";
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

-(void)getRestaurantsWith:(NSInteger)radius CurrentLocation:(CLLocation *)currentLocation Completion:(void (^)())completion{
    
    NSString *apiURL = [NSString stringWithFormat:@"%@location=%f,%f&radius=%lu&types=restaurant&key=%@", kGoogleURL,currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, (long)radius, kGooglePlacesAPI];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:apiURL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {

             for (NSDictionary *restaurant in responseObject[@"results"]) {
                 [self.results addObject:restaurant];
             }
             completion();
             
//             if (responseObject[@"next_page_token"]) {
//                 [self getNextPageOfResults:apiURL NextPageToken:responseObject[@"next_page_token"]];
//             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

//-(void)getNextPageOfResults:(NSString *)apiURL NextPageToken:(NSString *)token {
//    
//    NSString *url = [NSString stringWithFormat:@"%@&pagetoken=%@",apiURL,token];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        [manager GET:url
//          parameters:nil
//             success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                 
//                 
//                 for (NSDictionary *restaurant in responseObject[@"results"]) {
//                     [self.results addObject:restaurant];
//                 }
//                 
//                 NSLog(@"Next Token: %@",responseObject[@"next_page_token"]);
//                 if (responseObject[@"next_page_token"]) {
//                     [self getNextPageOfResults:apiURL NextPageToken:responseObject[@"next_page_token"]];
//                 }
//                 
//             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                 NSLog(@"Error: %@", error);
//             }];
//    });
//    
//
//}


@end
