//
//  FindProviderViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/1/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FindProviderViewController : UIViewController <MKMapViewDelegate>
{
    IBOutlet MKMapView* mapView;
}

@property(nonatomic,retain)	IBOutlet MKMapView* mapView;
@end
