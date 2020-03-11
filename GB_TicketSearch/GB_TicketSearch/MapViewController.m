//
//  MapViewController.m
//  GB_TicketSearch
//
//  Created by Vitaly_Shishlyannikov on 10.03.2020.
//  Copyright © 2020 Vitaly_Shishlayannikov. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () <MKMapViewDelegate>
@property(nonatomic,strong)MKMapView *mapView;
@property(nonatomic,strong)LocationService *locationService;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
    
    _mapView.delegate = self;
    
    _locationService = [[LocationService alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrentLocation:) name:kLocationServiceDidUpdateCurrentLocation object:nil];
        
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)updateCurrentLocation:(NSNotification *)notification {
    CLLocation *currentLocation = notification.object;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 1000000, 1000000);
    [_mapView setRegion:region  animated:YES];
    
    [[LocationService alloc] addressFromLocation:currentLocation withCompletion:^(NSString * _Nonnull cityName) {
        self.title = [NSString stringWithFormat:@"Current city - %@", cityName];
    }];
    
    
    [_mapView removeAnnotations:self->_mapView.annotations];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.title = @"Moscow";
    annotation.subtitle = @"Capital of Russia";
    annotation.coordinate = CLLocationCoordinate2DMake(55.755826, 37.6173);
    [_mapView addAnnotation:annotation];
}

#pragma mark -MKMaprViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *identifier = @"MarkIdentifier";
    MKMarkerAnnotationView *annotationView = (MKMarkerAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if(!annotationView) {
        annotationView = [[MKMarkerAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = YES;
        annotationView.calloutOffset = CGPointMake(0.0, 5.0);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [button addTarget:self action:(@selector(btnPressed:)) forControlEvents:UIControlEventTouchUpInside];
        annotationView.rightCalloutAccessoryView = button;
        
    }
    annotationView.annotation = annotation;
    return annotationView;
}

-(void)btnPressed:(UIButton *)sender {
    NSLog(@"Button pressed");
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
