//
//  AFDataStore.h
//  RestaurantInsepctor
//
//  Created by Dylan Shine on 7/20/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@class AFDataStore;

@protocol AFDataStoreDelegate <NSObject>

@required
-(void)dataStore:(AFDataStore *)dataStore didLoadRestaurants:(NSArray *)restaurants;

@end


@interface AFDataStore : NSObject

@property (nonatomic) NSMutableArray *results;
@property (nonatomic, weak) id<AFDataStoreDelegate> delegate;

+(instancetype)sharedData;
-(void)getRestaurantsWith:(NSInteger)radius CurrentLocation:(CLLocation *)currentLocation; // Completion:(void (^)())completion;
-(void)getDetailsForRestaurantID:(NSString *)placeID Completion:(void (^)(NSString *))completion;
-(void)getRestaurantInfoWithCompletion:(NSString *)phoneNumber completionBlock:(void(^)(NSArray *))completionBlock;

@end
