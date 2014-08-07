//
//  LocationViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 8/1/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "LocationViewController.h"
#import "MyAnnotation.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

CLPlacemark *thePlacemark;
MKRoute *routeDetails;

@synthesize mapView, toolBar, jsonData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *typeButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Satellite"
                                   style:UIBarButtonItemStyleBordered
                                   target: self
                                   action:@selector(changeMapType:)];

    UIBarButtonItem *getDirection = [[UIBarButtonItem alloc]
                                     initWithTitle: @"Get Direction"
                                     style:UIBarButtonItemStyleBordered
                                     target: self
                                     action:@selector(btnGetDirections:)];
    
    
    NSArray *buttons = [[NSArray alloc] initWithObjects:typeButton, getDirection, nil];
    toolBar.items = buttons;
    
    smallMap = NO;
    
    NSString *strXYLoc = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"strXYLoc"]];
    NSString *strPrvName = [jsonData objectForKey:@"strPrvName"];
    NSString *strSpecialist = [jsonData objectForKey:@"strSpecialist"];
    NSString *strAdd1 = [jsonData objectForKey:@"strAdd1"];
    
    NSLog(@"strXYLoc: %@",strXYLoc);
    
    coordinateX = 0.0;
    coordinateY = 0.0;
    
    if (![strXYLoc isEqual:@"<null>"]) {
        NSArray* arrayXY = [strXYLoc componentsSeparatedByString: @", "];
        coordinateX = [[arrayXY objectAtIndex: 0] doubleValue];
        coordinateY = [[arrayXY objectAtIndex: 1] doubleValue];
        NSLog(@"X Y: %f %f",coordinateX,coordinateY);
    }
    
    mapView.showsUserLocation = YES;
	NSMutableArray* annotations=[[NSMutableArray alloc] init];
	
	CLLocationCoordinate2D theCoordinate1;
    theCoordinate1.latitude = coordinateX;
    theCoordinate1.longitude = coordinateY;
    
	MyAnnotation* myAnnotation1=[[MyAnnotation alloc] init];
	myAnnotation1.coordinate=theCoordinate1;
	myAnnotation1.title=strPrvName;
	myAnnotation1.subtitle= [NSString stringWithFormat:@"%@ - %@",strSpecialist,strAdd1];
	  
	[mapView addAnnotation:myAnnotation1];
	[annotations addObject:myAnnotation1];
	NSLog(@"%lu",(unsigned long)[annotations count]);
    MKMapRect flyTo = MKMapRectNull;
	for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        }
        else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    // Position the map so that all overlays and annotations are visible on screen.
    mapView.visibleMapRect = flyTo;
}

- (IBAction)btnGetDirections:(id)sender {
    
    self.mapView.delegate = self;
    
    if (!smallMap) {
        self.mapView.frame = CGRectMake(0, 0, 320, 335);
        smallMap = YES;
    }
    else{
        self.mapView.frame = CGRectMake(0, 0, 320, 524);
        smallMap = NO;
    }
    

    //CLLocation *userLoc = mapView.userLocation.location;
    //CLLocationCoordinate2D fromCoordinate = userLoc.coordinate;
    CLLocationCoordinate2D toCoordinate   = CLLocationCoordinate2DMake(coordinateX,coordinateY);
    //MKPlacemark *fromPlacemark = [[MKPlacemark alloc] initWithCoordinate:fromCoordinate addressDictionary:nil];
    //MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:fromPlacemark];
    MKPlacemark *toPlacemark = [[MKPlacemark alloc] initWithCoordinate:toCoordinate addressDictionary:nil];
    MKMapItem *toItem = [[MKMapItem alloc] initWithPlacemark:toPlacemark];
    MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc] init];
    //MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:toPlacemark];
    [directionsRequest setSource:[MKMapItem mapItemForCurrentLocation]];
    [directionsRequest setDestination:toItem];
    directionsRequest.requestsAlternateRoutes = YES;
    directionsRequest.transportType = MKDirectionsTransportTypeAutomobile;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    [directions calculateDirectionsWithCompletionHandler: ^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"error:%@", error);
        }
        else {
            //MKRoute *routeDetails = response.routes[0];
            routeDetails = response.routes.lastObject;
            [self.mapView addOverlay:routeDetails.polyline];
            //self.destinationLabel.text = [placemark.addressDictionary objectForKey:@"Street"];
            self.destinationLabel.text = [jsonData objectForKey:@"strAdd1"];
            self.distanceLabel.text = [NSString stringWithFormat:@"%0.1f Miles", routeDetails.distance/1609.344];
            //self.transportLabel.text = [NSString stringWithFormat:@"%lu" ,routeDetails.transportType];
            self.allSteps = @" - ";
            for (int i = 0; i < routeDetails.steps.count; i++) {
                MKRouteStep *step = [routeDetails.steps objectAtIndex:i];
                NSString *newStep = step.instructions;
                self.allSteps = [self.allSteps stringByAppendingString:newStep];
                self.allSteps = [self.allSteps stringByAppendingString:@"\n\n - "];
                self.steps.text = self.allSteps;
            }
        }
    }];
}


- (void) changeMapType: (id)sender {
    if (mapView.mapType == MKMapTypeStandard)
    {
        //mapView.mapType = MKMapTypeSatellite;
        mapView.mapType = MKMapTypeHybrid;
        UIBarButtonItem *typeButton = [[UIBarButtonItem alloc]
                                       initWithTitle: @"Standard"
                                       style:UIBarButtonItemStyleBordered
                                       target: self
                                       action:@selector(changeMapType:)];
        UIBarButtonItem *getDirection = [[UIBarButtonItem alloc]
                                         initWithTitle: @"Get Direction"
                                         style:UIBarButtonItemStyleBordered
                                         target: self
                                         action:@selector(btnGetDirections:)];
        NSArray *buttons = [[NSArray alloc] initWithObjects:typeButton, getDirection, nil];
        toolBar.items = buttons;
    }
    else{
        mapView.mapType = MKMapTypeStandard;
        UIBarButtonItem *typeButton = [[UIBarButtonItem alloc]
                                       initWithTitle: @"Satellite"
                                       style:UIBarButtonItemStyleBordered
                                       target: self
                                       action:@selector(changeMapType:)];
        UIBarButtonItem *getDirection = [[UIBarButtonItem alloc]
                                         initWithTitle: @"Get Direction"
                                         style:UIBarButtonItemStyleBordered
                                         target: self
                                         action:@selector(btnGetDirections:)];
        NSArray *buttons = [[NSArray alloc] initWithObjects:typeButton, getDirection, nil];
        toolBar.items = buttons;
    }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        return NO;
    }
    return YES;
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    self.mapView.centerCoordinate = userLocation.location.coordinate;
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer  * routeLineRenderer = [[MKPolylineRenderer alloc] initWithPolyline:routeDetails.polyline];
    routeLineRenderer.strokeColor = [UIColor redColor];
    routeLineRenderer.lineWidth = 3;
    return routeLineRenderer;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	// if it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
	// try to dequeue an existing pin view first
	static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
	pinView.animatesDrop=YES;
	pinView.canShowCallout=YES;
	//pinView.pinColor=MKPinAnnotationColorPurple;
	UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[rightButton setTitle:annotation.title forState:UIControlStateNormal];
	//[rightButton addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
	pinView.rightCalloutAccessoryView = rightButton;
	UIImageView *profileIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile.png"]];
	pinView.leftCalloutAccessoryView = profileIconView;
	return pinView;
}

//- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay{
//     return [kml viewForOverlay:overlay];
//}

#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

@end

