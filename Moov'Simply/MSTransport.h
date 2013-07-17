//
//  MSTransport.h
//  Moov'Simply
//
//  Created by Valtech on 7/15/13.
//  Copyright (c) 2013 DuchessFrance. All rights reserved.
//

@import CoreLocation;

@interface MSTransport : NSObject
@property (nonatomic, strong) NSString * address;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * codeUIC;
@property (nonatomic, strong) NSString * stationID;
@property (nonatomic, strong) NSString * lineNumber;
@property (nonatomic, strong) NSString * formattedName;
@property (nonatomic, strong) NSString * serviceType;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) CLLocation * location;
@property (nonatomic) BOOL isFavorite;

- (id)initWithJSON:(NSDictionary *)JSON;
+ (BOOL)saveToFavorites;
@end
