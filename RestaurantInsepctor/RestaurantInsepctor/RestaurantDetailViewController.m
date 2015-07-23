//
//  RestaurantDetailViewController.m
//  RestaurantInsepctor
//
//  Created by Dylan Shine on 7/23/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import "RestaurantDetailViewController.h"

@interface RestaurantDetailViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

@end

@implementation RestaurantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.topItem.title = self.restaurant.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL) prefersStatusBarHidden {
    return YES;
}

@end
