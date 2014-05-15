//
//  ViewController.m
//  TicTacToe
//
//  Created by David Warner on 5/15/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *myLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *myLabelTwo;
@property (weak, nonatomic) IBOutlet UILabel *myLabelThree;
@property (weak, nonatomic) IBOutlet UILabel *myLabelFour;
@property (weak, nonatomic) IBOutlet UILabel *myLabelFive;
@property (weak, nonatomic) IBOutlet UILabel *myLabelSix;
@property (weak, nonatomic) IBOutlet UILabel *myLabelSeven;
@property (weak, nonatomic) IBOutlet UILabel *myLabelEight;
@property (weak, nonatomic) IBOutlet UILabel *myLabelNine;

@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property CGPoint point;
@property BOOL turn;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.turn = NO;

}

-(void)findLabelUsingPoint: (CGPoint) point
{

    switch (if (CGRectContainsPoint(Label, point)) {
        case myLabelOne:
            New label = my label one
            break;

        default:
            break;
    }

            if Rect Label contains point {
                set newlabel = label
            }
}

-(IBAction)onLabelTapped:(UITapGestureRecognizer *) tap
{
    CGPoint point;
    point = [tap locationInView:self.view];


    if (self.turn) {
        if (CGRectContainsPoint(self.myLabelOne.frame, point) && [self.myLabelOne.text isEqual: @" "]) {
            self.myLabelOne.text = @"O";
            self.myLabelOne.textColor = [UIColor redColor];
            self.turn = !self.turn;
            self.whichPlayerLabel.text = @"X";
        }
    } else {
            if (CGRectContainsPoint(self.myLabelOne.frame, point) && [self.myLabelOne.text isEqual: @" "]) {
                self.myLabelOne.text = @"X";
                self.turn = !self.turn;
                self.whichPlayerLabel.text = @"O";
                }
            }
        }

//    NSLog(@"%f %f", point.x, point.y);






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
