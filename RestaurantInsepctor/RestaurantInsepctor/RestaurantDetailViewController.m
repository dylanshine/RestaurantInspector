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
@property (weak, nonatomic) IBOutlet UILabel *cuisineLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *gradeImageView;

@end

@implementation RestaurantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.allowsSelection = NO;
    self.tableView.estimatedRowHeight = 150;
    self.tableView.separatorColor = [UIColor colorWithRed:230.0f/255.0f green:83.0f/255.0f blue:54.0f/255.0f alpha:1.0f];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.navBar.topItem.title = self.restaurant.name;
    self.cuisineLabel.text = self.restaurant.cuisineDescription;
    self.gradeImageView.image = [self setGradeImage];
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
    UILabel *description = (UILabel *)[cell.contentView viewWithTag:2];
    UIImageView *flag = (UIImageView *)[cell.contentView viewWithTag:3];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *inspectionDateString = [dateFormatter stringFromDate:inspection.inspectionDate];
    
    dateLabel.text = inspectionDateString;
    description.text = inspection.violationDescription;
    flag.hidden = !inspection.criticalFlag;
    
    return cell;
}

-(UIImage *)setGradeImage {
    if (!self.restaurant.mostRecentGrade) {
        return [UIImage imageNamed:@"pending"];
    }
    return [UIImage imageNamed:self.restaurant.mostRecentGrade];
}

-(BOOL) prefersStatusBarHidden {
    return YES;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
