//
//  ViewController.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 14.02.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "CountriesViewController.h"
#import "CitiesTableViewController.h"
#import "CustomTableViewCell.h"

@implementation CountriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Countries";
    
    _countries = [NSMutableArray arrayWithObjects:@"Russia", @"Italy", @"Ukraine", @"USA", @"Germany", @"Thailand", @"Greece", @"Georgia", nil];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIBarButtonItem *citiesButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Cities"
                                   style:UIBarButtonItemStyleDone
                                   target:self
                                   action:@selector(goToCitiesVC:)];
    self.navigationItem.rightBarButtonItem = citiesButton;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _countries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CountryCell"];
    if(!cell) {
        cell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CountryCell"];
    }
    cell.nameLabel.text = _countries[indexPath.row];
    return  cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_countries removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)goToCitiesVC:(UIButton *)sender {

    CitiesTableViewController *citiesViewController = [[CitiesTableViewController alloc] init];
    [self.navigationController showViewController:citiesViewController sender:self];
//    [self.navigationController pushViewController:secondViewController animated:YES];
//    [self presentViewController:secondViewController animated:YES completion:nil];
}

@end
