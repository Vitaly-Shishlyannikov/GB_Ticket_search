//
//  SecondViewController.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 17.02.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//


#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"SecondViewController";
    
    self.view.backgroundColor = [UIColor blueColor];
    
    CGRect labelFrame = CGRectMake(40.0, 40, [UIScreen mainScreen].bounds.size.width - 80.0, [UIScreen mainScreen].bounds.size.height - 80);
    UILabel *testLabel = [[UILabel alloc] initWithFrame:labelFrame];
    testLabel.font = [UIFont boldSystemFontOfSize:20.0];
    testLabel.textColor = [UIColor blackColor];
    testLabel.textAlignment = NSTextAlignmentCenter;
    testLabel.text = @"SecondViewController";
    [self.view addSubview:testLabel];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
