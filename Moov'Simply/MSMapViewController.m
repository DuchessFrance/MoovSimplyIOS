//
//  MSMapViewController.m
//  Moov'Simply
//
//  Created by Valtech on 7/15/13.
//  Copyright (c) 2013 DuchessFrance. All rights reserved.
//

@import MapKit;
#import "MSMapViewController.h"
#import "AFNetworking.h"
#import "MSTransport.h"
#import "MSTransportDetailsView.h"
#import "MSAnnotation.h"

@interface MSMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MSMapViewController
{
    NSMutableArray * nearTransports;
    
    MSTransportDetailsView * detailsView;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{    
    NSString * URL = [NSString stringWithFormat:@"http://moovsimply.fr/rest/moovin/around?LAT=%f&LNG=%f",_mapView.userLocation.coordinate.latitude,_mapView.userLocation.coordinate.longitude];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    
    AFJSONRequestOperation * operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [JSON enumerateObjectsUsingBlock:^(NSDictionary  * obj, NSUInteger idx, BOOL *stop) {
            [nearTransports addObject:[[MSTransport alloc] initWithJSON:obj]];
        }];
        [_mapView setRegion:MKCoordinateRegionMake(_mapView.userLocation.coordinate, MKCoordinateSpanMake(.005, .005))];
        [self showOnMap];
    } failure:nil];
    [operation start];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Try to dequeue an existing pin view first.
    static NSString *CellIdentifier = @"CustomPinAnnotationView";
    MKPinAnnotationView * pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:CellIdentifier];
    if (!pinView) pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:CellIdentifier];
    
    pinView.annotation = annotation;
    
    if ([((MSAnnotation *)annotation).transport.type isEqualToString:@"BUS"]) {
        pinView.image = [UIImage imageNamed:@"BusPin"];
    } else if ([((MSAnnotation *)annotation).transport.type isEqualToString:@"RER"]) {
        pinView.image = [UIImage imageNamed:@"RERPin"];
    } else if ([((MSAnnotation *)annotation).transport.type isEqualToString:@"VELIB"]) {
        pinView.image = [UIImage imageNamed:@"VelibPin"];
    } else if ([((MSAnnotation *)annotation).transport.type isEqualToString:@"METRO"]) {
        pinView.image = [UIImage imageNamed:@"MetroPin"];
    }
    
    return pinView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if ([view.annotation isKindOfClass:[MKUserLocation class]]) return;
    
    MSTransport * selectedTransport = ((MSAnnotation *)view.annotation).transport;
    [self showDetailsViewForTransport:selectedTransport];
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    [self hideDetailsView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    nearTransports = [NSMutableArray array];
    // [self.map]
}

- (void)showOnMap
{
    NSMutableArray * pins = [NSMutableArray array];
    [nearTransports enumerateObjectsUsingBlock:^(MSTransport * transport, NSUInteger idx, BOOL *stop) {
        MSAnnotation *annotation = [[MSAnnotation alloc] init];
        [annotation setCoordinate:transport.location.coordinate];
        [annotation setTransport:transport];
        [pins addObject:annotation];
    }];
    
    [_mapView addAnnotations:pins];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDetailsViewForTransport:(MSTransport *)transport
{
    if (!detailsView) {
        detailsView = [[[NSBundle mainBundle] loadNibNamed:@"MSTransportDetailsView" owner:self options:nil] objectAtIndex:0];
        [detailsView setFrame:CGRectMake(0, self.view.frame.size.height, detailsView.frame.size.width, detailsView.frame.size.height)];
        [self.view addSubview:detailsView];
    }
    
    [detailsView showTransportInformations:transport atUserLocation:self.mapView.userLocation.location];
    
    CGRect frame = detailsView.frame;
    frame.origin.y -= detailsView.frame.size.height;
    
    [UIView animateWithDuration:.3 animations:^{
        [detailsView setFrame:frame];
    }];
}

- (void)hideDetailsView
{
    CGRect frame = detailsView.frame;
    frame.origin.y += detailsView.frame.size.height;
    
    [UIView animateWithDuration:.3 animations:^{
        [detailsView setFrame:frame];
    }];
}

@end
