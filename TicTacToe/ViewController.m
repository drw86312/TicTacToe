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

@property (weak, nonatomic) IBOutlet UILabel *clickedLabel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.turn = NO;

}

-(void)findLabelUsingPoint:(CGPoint) pointNew
{
    if (CGRectContainsPoint(_myLabelOne.frame, pointNew)) {
        self.clickedLabel = self.myLabelOne;
    } else if (CGRectContainsPoint(self.myLabelTwo.frame, pointNew)) {
        self.clickedLabel = self.myLabelTwo;
    } else if (CGRectContainsPoint(self.myLabelThree.frame, pointNew)) {
        self.clickedLabel = self.myLabelThree;
    } else if (CGRectContainsPoint(self.myLabelFour.frame, pointNew)) {
        self.clickedLabel = self.myLabelFour;
    }else if (CGRectContainsPoint(self.myLabelFive.frame, pointNew)) {
        self.clickedLabel = self.myLabelFive;
    }else if (CGRectContainsPoint(self.myLabelSix.frame, pointNew)) {
        self.clickedLabel = self.myLabelSix;
    }else if (CGRectContainsPoint(self.myLabelSeven.frame, pointNew)) {
        self.clickedLabel = self.myLabelSeven;
    }else if (CGRectContainsPoint(self.myLabelEight.frame, pointNew)) {
        self.clickedLabel = self.myLabelEight;
    }else if (CGRectContainsPoint(self.myLabelNine.frame, pointNew)) {
        self.clickedLabel = self.myLabelNine;
    }
}

-(void)xIsWinner {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"X won" message:@"X won" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil ];
    [alert show];
}

-(void)yIsWinner {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Y won" message:@"Y won" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil ];
    [alert show];
}

-(IBAction)onLabelTapped:(UITapGestureRecognizer *) tap
{

    self.point = [tap locationInView:self.view];

    [self findLabelUsingPoint:self.point];
    // if BOOL = YES for Turn, set in viewDidLoad
    if (self.turn) {
        if (CGRectContainsPoint(self.clickedLabel.frame, self.point) && [self.clickedLabel.text isEqual: @" "]) {
            self.clickedLabel.text = @"O";
            self.clickedLabel.textColor = [UIColor redColor];
            self.turn = !self.turn;
            self.whichPlayerLabel.text = @"X";
            }
// Else other turn
    } else {
            if (CGRectContainsPoint(self.clickedLabel.frame, self.point) && [self.clickedLabel.text isEqual: @" "]) {
                self.clickedLabel.text = @"X";
                self.clickedLabel.textColor = [UIColor blueColor];
                self.turn = !self.turn;
                self.whichPlayerLabel.text = @"O";
                }
            }


//Checking if User Won

    if ([self.myLabelOne  isEqual: @"X"] && [self.myLabelTwo  isEqual: @"X"] && [self.myLabelThree  isEqual: @"X"]) {

        [self xIsWinner];
    }    else if ([self.myLabelOne  isEqual: @"X"] && [self.myLabelTwo  isEqual: @"X"] && [self.myLabelThree  isEqual: @"X"]) {

        [self xIsWinner];

    }  else if ([self.myLabelOne  isEqual: @"X"] && [self.myLabelTwo  isEqual: @"X"] && [self.myLabelThree  isEqual: @"X"]) {

        [self xIsWinner];
    }


//    NSLog(@"%f %f", point.x, point.y);




}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
