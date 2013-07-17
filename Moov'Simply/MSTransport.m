//
//  MSTransport.m
//  Moov'Simply
//
//  Created by Valtech on 7/15/13.
//  Copyright (c) 2013 DuchessFrance. All rights reserved.
//

#import "MSTransport.h"

@implementation MSTransport

- (id)initWithJSON:(NSDictionary *)JSON
{
    if (self == [super init]) {
        [self parseJSON:JSON];
    }
    
    return self;
}

- (void)parseJSON:(NSDictionary *)JSON
{
    self.name = JSON[@"name"];
    self.address = JSON[@"address"];
    self.location = [[CLLocation alloc] initWithLatitude:[JSON[@"coordinates"][@"latitude"] floatValue] longitude:[JSON[@"coordinates"][@"longitude"] floatValue]];
    self.formattedName = JSON[@"formattedName"];
    self.lineNumber = JSON[@"lineNumber"];
    self.serviceType = JSON[@"serviceType"];
    self.type = JSON[@"type"];
    self.codeUIC = JSON[@"codeUIC"];
    self.stationID = JSON[@"stationId"];
}

+ (BOOL)saveToFavorites
{
    
    return NO;
}

@end
