//
//  ViewController.m
//  TicTacToe
//
//  Created by David Warner on 5/15/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import "HelpViewController.h"

@interface ViewController () <UIAlertViewDelegate>

// Label properties - these outlet to Tic Tac Toe squares
@property (weak, nonatomic) IBOutlet UILabel *myLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *myLabelTwo;
@property (weak, nonatomic) IBOutlet UILabel *myLabelThree;
@property (weak, nonatomic) IBOutlet UILabel *myLabelFour;
@property (weak, nonatomic) IBOutlet UILabel *myLabelFive;
@property (weak, nonatomic) IBOutlet UILabel *myLabelSix;
@property (weak, nonatomic) IBOutlet UILabel *myLabelSeven;
@property (weak, nonatomic) IBOutlet UILabel *myLabelEight;
@property (weak, nonatomic) IBOutlet UILabel *myLabelNine;

// Label displaying which player's turn it is.
@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;

// Properties necessary to create a NSTimer and set a timer label.
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) NSTimer *timer;
@property int currentSeconds;

// Boolean value indicating which player's turn it is.
@property BOOL turn;
// Indicates whether the helpButton has been pressed.
@property BOOL helpButton;

// Properties that help interpret gesture behavior.
@property CGPoint pointOfPanSaved;
@property CGAffineTransform originPoint;

// Other properties
@property (weak, nonatomic) IBOutlet UILabel *clickedLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameRules;

@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.turn = NO;

    //Saves the center for the label
    self.originPoint = self.whichPlayerLabel.transform;

    self.helpButton = YES;

    self.currentSeconds = 15;
    [self createTimer];
}

// Finds the correct label using the CGPoint returned by the gesture variable, pan, and sets the clickedLabel property to the label selected.
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

#pragma mark IBActions

-(IBAction)onLabelPan:(UIPanGestureRecognizer *) pan
{
    //Setting @Property for pan point
    self.pointOfPanSaved = [pan translationInView:self.view];
    
    self.whichPlayerLabel.transform = CGAffineTransformMakeTranslation(_pointOfPanSaved.x, _pointOfPanSaved.y);

    //Offsetting for center of label with finger point
    _pointOfPanSaved.x += (self.whichPlayerLabel.center.x);
    _pointOfPanSaved.y += (self.whichPlayerLabel.center.y);

    //When pan gesture has ended, call the findLabel method, snap the whichPlayerLabel to origin, and restrart the timer.
    if (pan.state == UIGestureRecognizerStateEnded) {

        [self findLabelUsingPoint:self.pointOfPanSaved];

        //Setting the Label back to the origin animatedly.
        [UIView animateWithDuration:1.5 animations:^{
            self.whichPlayerLabel.transform = self.originPoint;
            }];
        [self restartTimer];

    }//end if

    // if BOOL = YES for Turn, set in viewDidLoad
    if (self.turn) {
        if ([self.clickedLabel.text isEqual: @" "]) {
            self.clickedLabel.text = @"O";
            self.clickedLabel.textColor = [UIColor redColor];
            self.turn = !self.turn;
            self.whichPlayerLabel.text = @"X";
            }

// Else other turn
    } else {
            if ([self.clickedLabel.text isEqual: @" "]) {
                self.clickedLabel.text = @"X";
                self.clickedLabel.textColor = [UIColor blueColor];
                self.turn = !self.turn;
                self.whichPlayerLabel.text = @"O";
                }
            }

//Checking if User Won

    if ([self.myLabelOne.text isEqual: @"X"] && [self.myLabelTwo.text isEqual: @"X"] && [self.myLabelThree.text  isEqual: @"X"]) {
        [self xIsWinner];
    } else if ([self.myLabelFour.text isEqual: @"X"] && [self.myLabelFive.text isEqual: @"X"] && [self.myLabelSix.text  isEqual: @"X"]) {
        [self xIsWinner];
    } else if ([self.myLabelSeven.text isEqual: @"X"] && [self.myLabelEight.text isEqual: @"X"] && [self.myLabelNine.text  isEqual: @"X"]) {
        [self xIsWinner];
    } else if ([self.myLabelOne.text isEqual: @"X"] && [self.myLabelFour.text isEqual: @"X"] && [self.myLabelSeven.text  isEqual: @"X"]) {
        [self xIsWinner];
    } else if ([self.myLabelTwo.text isEqual: @"X"] && [self.myLabelFive.text isEqual: @"X"] && [self.myLabelEight.text  isEqual: @"X"]) {
        [self xIsWinner];
    } else if ([self.myLabelThree.text isEqual: @"X"] && [self.myLabelSix.text isEqual: @"X"] && [self.myLabelNine.text  isEqual: @"X"]) {
        [self xIsWinner];
    } else if ([self.myLabelOne.text isEqual: @"X"] && [self.myLabelFive.text isEqual: @"X"] && [self.myLabelNine.text  isEqual: @"X"]) {
        [self xIsWinner];
    } else if ([self.myLabelThree.text isEqual: @"X"] && [self.myLabelFive.text isEqual: @"X"] && [self.myLabelSeven.text  isEqual: @"X"]) {
        [self xIsWinner];
    }

    // if O scores

      else if ([self.myLabelOne.text isEqual: @"O"] && [self.myLabelTwo.text isEqual: @"O"] && [self.myLabelThree.text  isEqual: @"O"]) {
        [self oIsWinner];
    } else if ([self.myLabelFour.text isEqual: @"O"] && [self.myLabelFive.text isEqual: @"O"] && [self.myLabelSix.text  isEqual: @"O"]) {
        [self oIsWinner];
    } else if ([self.myLabelSeven.text isEqual: @"O"] && [self.myLabelEight.text isEqual: @"O"] && [self.myLabelNine.text  isEqual: @"O"]) {
        [self oIsWinner];
    } else if ([self.myLabelOne.text isEqual: @"O"] && [self.myLabelFour.text isEqual: @"O"] && [self.myLabelSeven.text  isEqual: @"O"]) {
        [self oIsWinner];
    } else if ([self.myLabelTwo.text isEqual: @"O"] && [self.myLabelFive.text isEqual: @"O"] && [self.myLabelEight.text  isEqual: @"O"]) {
        [self oIsWinner];
    } else if ([self.myLabelThree.text isEqual: @"O"] && [self.myLabelSix.text isEqual: @"O"] && [self.myLabelNine.text  isEqual: @"O"]) {
        [self oIsWinner];
    } else if ([self.myLabelOne.text isEqual: @"O"] && [self.myLabelFive.text isEqual: @"O"] && [self.myLabelNine.text  isEqual: @"O"]) {
        [self oIsWinner];
    } else if ([self.myLabelThree.text isEqual: @"O"] && [self.myLabelFive.text isEqual: @"O"] && [self.myLabelSeven.text  isEqual: @"O"]) {
        [self oIsWinner];
    }

    // If all nine lables are filled and no one has won, call the "Cat Game" alertview.
    else if (([self.myLabelOne.text isEqualToString:@"X"]    || [self.myLabelOne.text isEqualToString:@"O"])   &&
             ([self.myLabelTwo.text isEqualToString:@"X"]    || [self.myLabelTwo.text isEqualToString:@"O"])   &&
             ([self.myLabelThree.text isEqualToString:@"X"]  || [self.myLabelThree.text isEqualToString:@"O"]) &&
             ([self.myLabelFour.text isEqualToString:@"X"]   || [self.myLabelFour.text isEqualToString:@"O"])  &&
             ([self.myLabelFive.text isEqualToString:@"X"]   || [self.myLabelFive.text isEqualToString:@"O"])  &&
             ([self.myLabelSix.text isEqualToString:@"X"]    || [self.myLabelSix.text isEqualToString:@"O"])   &&
             ([self.myLabelSeven.text isEqualToString:@"X"]  || [self.myLabelSeven.text isEqualToString:@"O"]) &&
             ([self.myLabelEight.text isEqualToString:@"X"]  || [self.myLabelEight.text isEqualToString:@"O"]) &&
             ([self.myLabelNine.text isEqualToString:@"X"]   || [self.myLabelNine.text isEqualToString:@"O"]))
    {
        [self catGame];
    }
}

// Sets and shows an alertview when pressed, allowing  users to see the rules of Tic Tac Toe.
- (IBAction)onHelpButtonPressed:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"toHelpViewController" sender:self ];
}

// Resets the game when pressed. See reset helper method.
- (IBAction)restartButton:(id)sender {
    [self reset];
}

#pragma  mark Game finished methods

-(void)xIsWinner {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations X" message:@"You Won!" delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil, nil ];
    [alert show];
    [self.timer invalidate];
}

-(void)oIsWinner {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations O" message:@"You Won!" delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil, nil ];
    [alert show];
    [self.timer invalidate];
}

-(void)catGame {
    [self performSegueWithIdentifier:@"catSegue" sender:self];
    [self.timer invalidate];
    [self reset];
}


#pragma mark - Helper methods

// This method resets the board, restarts the timer, and sets the clicked label to nil.
-(void)reset
{
    self.clickedLabel = nil;

    // Stops the timer and restarts the timer.
    [self restartTimer];

    // Resets the tic tac toe square labels to an empty space.
    self.myLabelOne.text = @" ";
    self.myLabelTwo.text = @" ";
    self.myLabelThree.text = @" ";
    self.myLabelFour.text = @" ";
    self.myLabelFive.text = @" ";
    self.myLabelSix.text = @" ";
    self.myLabelSeven.text = @" ";
    self.myLabelEight.text = @" ";
    self.myLabelNine.text = @" ";
}

// A delegate method of UIAlertView that allows the game board to be reset when the alertview button is pressed.
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self reset];
    }
}

// Creates an instance of an NSTimer, sending a message to selector onTick every second.
-(void)createTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onSecondTicked:) userInfo:nil repeats:YES];
}

// Stops then restarts the timer.
-(void)restartTimer
{
    [self.timer invalidate];
    self.currentSeconds = 16;
    [self createTimer];
}

// Logic that sets the timerLabel and switches between players when time expires.
-(void)onSecondTicked:(NSTimer *)timer
{
    // currentSeconds property set to 16 in viewDidLoad method. If the value of currentSeconds is greater than 1, assign the value of currentSeconds to the timerLabel. Otherwise, switch turn to other player, switch whichPlayerLabel to other player, and restart timer.
    if (self.currentSeconds > 0)
    {
        self.currentSeconds -= 1;
        self.timerLabel.text = [NSString stringWithFormat:@"%d", self.currentSeconds];
    }
    else {
        self.timerLabel.text = @"X";
        self.turn = !self.turn;
            if ([self.whichPlayerLabel.text isEqualToString:@"X"]) {
                self.whichPlayerLabel.text = @"O";
                [self restartTimer];
            }
            else {
                self.whichPlayerLabel.text = @"X";
                [self restartTimer];
                 }
            }
}

@end
