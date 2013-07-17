//
//  MSViewController.m
//  Moov'Simply
//
//  Created by Valtech on 7/15/13.
//  Copyright (c) 2013 DuchessFrance. All rights reserved.
//

#import "MSViewController.h"

@interface MSViewController ()

@end

@implementation MSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor colorWithRed:215./255. green:211./255. blue:211./255. alpha:1.] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
