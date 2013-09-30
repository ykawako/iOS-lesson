//
//  MapViewController.h
//  私の今を知る
//
//  Created by 河原 on 2013/09/03.
//  Copyright (c) 2013年 河原. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController<UITabBarControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate>

@end
