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
    
    NSSet *fastFoodSet = [[NSSet alloc] initWithArray:@[@"mcdonald's",@"burger",@"shake",@"shack",@"fries",@"burgers",@"wings",@"checkers",@"fried",@"papaya",@"castle",@"arby's",@"wendy's"]];
    return fastFoodSet;
}

+(NSSet *)cafe {
    NSSet *cafeSet = [[NSSet alloc] initWithArray:@[@"cafe",@"café",@"coffee",@"espresso",@"roasters",@"bakery",@"tea",@"bean",@"roasting",@"starbucks",@"donuts",@"roast"]];
    return cafeSet;
}

+(NSSet *)bar {
    NSSet *barSet = [[NSSet alloc] initWithArray:@[@"bar",@"pub",@"wine",@"winery"]];
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
    NSSet *japaneseSet = [[NSSet alloc] initWithArray:@[@"sushi",@"japanese",@"teriyaki",@"ramen",@"sake",@"soba",@"nobu"]];
    return japaneseSet;
}

+(NSSet *)italian {
    NSSet *italianSet = [[NSSet alloc] initWithArray:@[@"italian",@"pasta",@"ristorante"]];
    return italianSet;
}

+(NSSet *)icecream {
    NSSet *icecreamSet = [[NSSet alloc] initWithArray:@[@"icecream",@"gelato",@"comes",@"sundaes",@"creamery",@"handles",@"ices",@"cream",@"dazs",@"ice"]];
    return icecreamSet;
}

+(NSSet *)juice {
    NSSet *juiceSet = [[NSSet alloc] initWithArray:@[@"juice",@"liquiteria",@"juicery",@"organic"]];
    return juiceSet;
}


+(NSSet *)sandwich {
    NSSet *sandwichSet = [[NSSet alloc] initWithArray:@[@"sandwich",@"sandwiches",@"deli",@"bagel",@"bagels",@"subs",@"subway"]];
    return sandwichSet;
}

+(NSSet *)steakhouse {
    NSSet *steakhouseSet = [[NSSet alloc] initWithArray:@[@"steakhouse",@"grill",@"bbq"]];
    return steakhouseSet;
}

+(NSSet *)fish {
    NSSet *fishSet = [[NSSet alloc] initWithArray:@[@"fish",@"sea",@"seafood",@"ocean",@"mussels",@"oysters",@"oyster",@"lobster",@"crab",@"catch",@"fin",@"fishbar",@"hook",@"bait",@"pescaderia",@"claw",@"clam",@"dock",@"bonefish"]];
    return fishSet;
}


@end