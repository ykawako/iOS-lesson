//
//  MapViewController.m
//  私の今を知る
//
//  Created by 河原 on 2013/09/03.
//  Copyright (c) 2013年 河原. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()


@property(nonatomic) MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
    [self.mapView.userLocation addObserver:self forKeyPath:@"location" options:0 context:NULL];
    [super viewWillAppear:animated];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    self.mapView.centerCoordinate = self.mapView.userLocation.location.coordinate;
    MKCoordinateSpan CoordinateSpan = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion CoordinateRegion = MKCoordinateRegionMake(self.mapView.centerCoordinate, CoordinateSpan);
    [self.mapView setRegion:CoordinateRegion animated:YES];
    [self.mapView.userLocation removeObserver:self forKeyPath:@"location"];
}



@end
