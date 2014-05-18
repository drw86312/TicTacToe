//
//  HelpViewController.m
//  TicTacToe
//
//  Created by David Warner on 5/16/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *helpInstructionWebsite;

@end

@implementation HelpViewController


- (void)viewDidLoad
{
    //Returns a webview of the wikihow tic tac toe rules.
    [super viewDidLoad];
    NSString *urlString = @"http://www.wikihow.com/Play-Tic-Tac-Toe";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.helpInstructionWebsite loadRequest:request];
}

    // Dismisses the modal view.
- (IBAction)onBackButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


@end
