//
//  ViewController.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 14.02.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "MainViewController.h"
#import "SecondViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"MainViewController";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect redViewFrame = CGRectMake(40.0, 100.0, [UIScreen mainScreen].bounds.size.width - 80.0, [UIScreen mainScreen].bounds.size.height - 180.0);
    UIView *redView = [[UIView alloc] initWithFrame: redViewFrame];
    redView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:redView];
    
    CGRect labelFrame = CGRectMake(40.0, 0.0, [UIScreen mainScreen].bounds.size.width - 80.0, [UIScreen mainScreen].bounds.size.height - 80.0);
    UILabel *testLabel = [[UILabel alloc] initWithFrame:labelFrame];
    testLabel.font = [UIFont boldSystemFontOfSize:30.0];
    testLabel.textColor = [UIColor blueColor];
    testLabel.textAlignment = NSTextAlignmentCenter;
    testLabel.text = @"TestLabel!";
    [self.view addSubview:testLabel];
    
    CGRect buttonFrame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100.0, [UIScreen mainScreen].bounds.size.height/2, 200.0, 50.0);
    UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
    [button setTitle:@"SecondVCButton" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    button.tintColor = [UIColor blackColor];
    button.frame = buttonFrame;
    [button addTarget:self action:@selector(goToSecondVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)goToSecondVC:(UIButton *)sender {
   
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    [self.navigationController showViewController:secondViewController sender:self];
//    [self.navigationController pushViewController:secondViewController animated:YES];
//    [self presentViewController:secondViewController animated:YES completion:nil];
}

@end
