//
//  MSTransportDetailsView.h
//  Moov'Simply
//
//  Created by Valtech on 7/16/13.
//  Copyright (c) 2013 DuchessFrance. All rights reserved.
//

@import CoreLocation;

@class MSTransport;

@interface MSTransportDetailsView : UIView
- (void)showTransportInformations:(MSTransport *)transport atUserLocation:(CLLocation *)userLocation;
@end
