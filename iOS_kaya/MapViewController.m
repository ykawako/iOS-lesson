//
//  MapViewController.m
//  iOS_kaya
//
//  Created by 河原 on 2013/09/03.
//  Copyright (c) 2013年 河原. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //mapView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    //MapViewに実体を持たせる。
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
      //ユーザーの位置をmapに反映してるぽい
    [mapView setUserTrackingMode:MKUserTrackingModeFollow];
    //ユーザの位置を表示するかどうか
    mapView.showsUserLocation = YES;

    [self.view addSubview:mapView];
    [mapView.userLocation addObserver:self forKeyPath:@"location" options:0 context:NULL];

    [super viewWillAppear:animated];
}


// タブが切り替わったタイミング
- (void)tabBar:(UITabBar*)tabBar didSelectItem:(UITabBarItem*)item
{
    
    NSLog(@"1");
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //位置の設定
    mapView.centerCoordinate = mapView.userLocation.location.coordinate;
    //範囲の設定
    MKCoordinateSpan CoordinateSpan = MKCoordinateSpanMake(0.005,0.005);
    MKCoordinateRegion CoordinateRegion = MKCoordinateRegionMake(mapView.centerCoordinate,CoordinateSpan);
    [mapView setRegion:CoordinateRegion animated:YES];
    [mapView.userLocation removeObserver:self forKeyPath:@"location"];
}



@end
