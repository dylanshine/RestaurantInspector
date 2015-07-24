//
//  RestaurantDetailViewController.m
//  RestaurantInsepctor
//
//  Created by Dylan Shine on 7/23/15.
//  Copyright (c) 2015 Dylan Shine. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "Inspection.h"

@interface RestaurantDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *currentGradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *averageGradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cuisineLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RestaurantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 150;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.navBar.topItem.title = self.restaurant.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.restaurant.inspections.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"violationCell" forIndexPath:indexPath];
    Inspection *inspection = (Inspection *)self.restaurant.inspections[indexPath.row];
    
    
    UILabel *dateLabel = (UILabel *)[cell.contentView viewWithTag:1];
    UILabel *scoreLabel = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *description = (UILabel *)[cell.contentView viewWithTag:3];
    
    dateLabel.text = [NSString stringWithFormat:@"%@",inspection.inspectionDate];
    scoreLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)inspection.score];
    description.text = inspection.violationDescription;
    
    return cell;
}

-(BOOL) prefersStatusBarHidden {
    return YES;
}

@end
