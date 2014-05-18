//
//  CatViewController.m
//  TicTacToe
//
//  Created by David Warner on 5/16/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "CatViewController.h"

@interface CatViewController ()

@end

@implementation CatViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)onCatBackButtonPressed:(id)sender
{
    // Dismisses cat modal view.
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


@end
