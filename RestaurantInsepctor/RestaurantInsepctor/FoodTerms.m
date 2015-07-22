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
    
    NSSet *fastFoodSet = [[NSSet alloc] initWithArray:@[@"mcdonald's",@"burger",@"shake",@"shack",@"fries",@"burgers",@"wings",@"checkers",@"fried",@"papaya",@"castle",@"arby's",@"wendy's",@"diner"]];
    return fastFoodSet;
}

+(NSSet *)cafe {
    NSSet *cafeSet = [[NSSet alloc] initWithArray:@[@"cafe",@"café",@"coffee",@"espresso",@"roasters",@"bakery",@"tea",@"bean",@"roasting",@"starbucks",@"donuts",@"roast"]];
    return cafeSet;
}

+(NSSet *)bar {
    NSSet *barSet = [[NSSet alloc] initWithArray:@[@"bar",@"pub"]];
    return barSet;
}

+(NSSet *)latin {
    NSSet *latinSet = [[NSSet alloc] initWithArray:@[@"mexican",@"mexicano",@"taco",@"cantina",@"cuba",@"cuban"]];
    return latinSet;
}

+(NSSet *)pizza {
    NSSet *pizzaSet = [[NSSet alloc] initWithArray:@[@"pizza",@"pizzaria"]];
    return pizzaSet;
}

+(NSSet *)chinese {
    NSSet *chineseSet = [[NSSet alloc] initWithArray:@[@"china",@"chinese",@"wok",@"yips",@"oriental"]];
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

+(NSSet *)wine {
    NSSet *wineSet = [[NSSet alloc] initWithArray:@[@"wine",@"winery",@"winebar",@"winecellar",@"wines",@"vino"]];
    return wineSet;
}

+(NSSet *)thai {
    NSSet *thaiSet = [[NSSet alloc] initWithArray:@[@"thai",@"siam",@"bangkok",@"tiam",@"thailand"]];
    return thaiSet;
}

+(NSSet *)korean {
    NSSet *koreanSet = [[NSSet alloc] initWithArray:@[@"korean",@"guksu",@"kimchi",@"anju",@"spice",@"jaiya"]];
    return koreanSet;
}

+(NSSet *)tapas {
    NSSet *tapasSet = [[NSSet alloc] initWithArray:@[@"tapas"]];
    return tapasSet;
}

+(NSSet *)mediterranean {
    NSSet *mediterraneanSet = [[NSSet alloc] initWithArray:@[@"mediterranean"]];
    return mediterraneanSet;
}

+(NSSet *)indian {
    NSSet *indianSet = [[NSSet alloc] initWithArray:@[@"indian",@"kati",@"india"]];
    return indianSet;
}

+(NSSet *)vegetarian {
    NSSet *vegetarianSet = [[NSSet alloc] initWithArray:@[@"vegetarian"]];
    return vegetarianSet;
}



@end
