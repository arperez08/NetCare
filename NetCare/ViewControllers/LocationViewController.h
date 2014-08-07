//
//  LocationViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 8/1/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController : UIViewController <MKMapViewDelegate> {
    IBOutlet MKMapView* mapView;
    UIToolbar *toolbar;
    NSMutableDictionary *jsonData;
    double coordinateX;
    double coordinateY;
    MKRoute *routeDetails;
    BOOL smallMap;

}
@property(nonatomic,retain)	IBOutlet MKMapView* mapView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) NSMutableDictionary *jsonData;

@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *transportLabel;
@property (weak, nonatomic) IBOutlet UITextView *steps;

@property (strong, nonatomic) NSString *allSteps;

- (IBAction)btnBack:(id)sender;
- (IBAction)btnGetDirections:(id)sender;

@end
