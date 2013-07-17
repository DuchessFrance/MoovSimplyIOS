//
//  MSAnnotation.h
//  Moov'Simply
//
//  Created by Valtech on 7/16/13.
//  Copyright (c) 2013 DuchessFrance. All rights reserved.
//

@import MapKit;
#import "MSTransport.h"

@interface MSAnnotation : NSObject <MKAnnotation>
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, strong) MSTransport * transport;
@end
