//
//  MSTransportDetailsView.m
//  Moov'Simply
//
//  Created by Valtech on 7/16/13.
//  Copyright (c) 2013 DuchessFrance. All rights reserved.
//

#import "MSTransportDetailsView.h"
#import "MSTransport.h"

@interface MSTransportDetailsView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@end

@implementation MSTransportDetailsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"MSTransportDetailsView" owner:self options:nil];
    }
    
    return self;
}

- (void)showTransportInformations:(MSTransport *)transport atUserLocation:(CLLocation *)userLocation
{
    [self.titleLabel setText:transport.name];
    [self.distanceLabel setText:[NSString stringWithFormat:@"à %.1fm à pieds",[userLocation distanceFromLocation:transport.location]]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
