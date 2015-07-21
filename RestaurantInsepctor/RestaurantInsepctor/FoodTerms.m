//
//  FoodTerms.m
//  RestaurantInsepctor
//
//  Created by Dylan Shine on 7/21/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import "FoodTerms.h"

@implementation FoodTerms
+(NSSet *)fastFood {
    
    NSSet *fastFoodSet = [[NSSet alloc] initWithArray:@[@"mcdonald's",@"burger king",@"subway"]];
    return fastFoodSet;
}

+(NSSet *)cafe {
    NSSet *cafeSet = [[NSSet alloc] initWithArray:@[@"cafe"]];
    return cafeSet;
}

+(NSSet *)bar {
    NSSet *barSet = [[NSSet alloc] initWithArray:@[@"bar"]];
    return barSet;
}

+(NSSet *)mexican {
    NSSet *mexicanSet = [[NSSet alloc] initWithArray:@[@"mexican",@"mexicano",@"taco",@"cantina"]];
    return mexicanSet;
}

+(NSSet *)pizza {
    NSSet *pizzaSet = [[NSSet alloc] initWithArray:@[@"pizza",@"pizzaria"]];
    return pizzaSet;
}

+(NSSet *)chinese {
    NSSet *chineseSet = [[NSSet alloc] initWithArray:@[@"china",@"chinese",@"wok"]];
    return chineseSet;
}

+(NSSet *)japanese {
    NSSet *japaneseSet = [[NSSet alloc] initWithArray:@[@"sushi",@"japanese",@"teriyaki"]];
    return japaneseSet;
}


@end
