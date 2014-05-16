//
//  ViewController.m
//  TicTacToe
//
//  Created by David Warner on 5/15/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIAlertViewDelegate>

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

@property CGPoint pointOfPanSaved;
@property CGPoint pointofLabelOrigin;
@property CGAffineTransform originPoint;

@property BOOL turn;

@property (weak, nonatomic) IBOutlet UILabel *clickedLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameRules;

@property BOOL helpButton;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) NSTimer *timer;
@property int currentSeconds;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.turn = NO;

    //Saves the center for the label
    self.originPoint = self.whichPlayerLabel.transform;

    self.pointofLabelOrigin = self.whichPlayerLabel.frame.origin;

    self.helpButton = YES;
    [self createTimer];
    self.currentSeconds = 15;
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"X won" message:@"X won" delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil, nil ];
    [alert show];
    [self.timer invalidate];
}

-(void)oIsWinner {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"O won" message:@"O won" delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil, nil ];
    [alert show];
    [self.timer invalidate];
}

-(IBAction)onLabelPan:(UIPanGestureRecognizer *) pan
{
    //Setting @Property for pan point
    self.pointOfPanSaved = [pan translationInView:self.view];
    
    self.whichPlayerLabel.transform = CGAffineTransformMakeTranslation(_pointOfPanSaved.x, _pointOfPanSaved.y);

    //Offsetting for center of label with finger point
    _pointOfPanSaved.x += (self.whichPlayerLabel.center.x);
    _pointOfPanSaved.y += (self.whichPlayerLabel.center.y);

    //Finding area where 
    if (pan.state == UIGestureRecognizerStateEnded) {

        [self findLabelUsingPoint:self.pointOfPanSaved];

        //Setting the Label back to the origin animatedly.
        [UIView animateWithDuration:1.5 animations:^{
            self.whichPlayerLabel.transform = self.originPoint;
            }];

        [self.timer invalidate];
        self.currentSeconds = 16;
        [self createTimer];

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
    }else if ([self.myLabelThree.text isEqual: @"X"] && [self.myLabelSix.text isEqual: @"X"] && [self.myLabelNine.text  isEqual: @"X"]) {
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
    }else if ([self.myLabelThree.text isEqual: @"O"] && [self.myLabelSix.text isEqual: @"O"] && [self.myLabelNine.text  isEqual: @"O"]) {
        [self oIsWinner];
    } else if ([self.myLabelOne.text isEqual: @"O"] && [self.myLabelFive.text isEqual: @"O"] && [self.myLabelNine.text  isEqual: @"O"]) {
        [self oIsWinner];
    } else if ([self.myLabelThree.text isEqual: @"O"] && [self.myLabelFive.text isEqual: @"O"] && [self.myLabelSeven.text  isEqual: @"O"]) {
        [self oIsWinner];
    }

    // If all nine lables are filled and no one has won, call the "Cat Game" alertview.
    else if (([self.myLabelOne.text isEqualToString:@"X"] || [self.myLabelOne.text isEqualToString:@"O"]) &&
             ([self.myLabelTwo.text isEqualToString:@"X"] || [self.myLabelTwo.text isEqualToString:@"O"]) &&
             ([self.myLabelThree.text isEqualToString:@"X"] || [self.myLabelThree.text isEqualToString:@"O"]) &&
             ([self.myLabelFour.text isEqualToString:@"X"] || [self.myLabelFour.text isEqualToString:@"O"]) &&
             ([self.myLabelFive.text isEqualToString:@"X"] || [self.myLabelFive.text isEqualToString:@"O"]) &&
             ([self.myLabelSix.text isEqualToString:@"X"] || [self.myLabelSix.text isEqualToString:@"O"]) &&
             ([self.myLabelSeven.text isEqualToString:@"X"] || [self.myLabelSeven.text isEqualToString:@"O"]) &&
             ([self.myLabelEight.text isEqualToString:@"X"] || [self.myLabelEight.text isEqualToString:@"O"]) &&
             ([self.myLabelNine.text isEqualToString:@"X"] || [self.myLabelNine.text isEqualToString:@"O"]))
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cat!" message:@"It's a Draw" delegate:(self) cancelButtonTitle:@"Play Again" otherButtonTitles:nil];
        [alert show];
        [self.timer invalidate];
    }

}

- (IBAction)onHelpButtonPressed:(UIButton *)sender
{
    if (self.helpButton) {
        self.gameRules.text = @"Rules:\n 1. The first player is assigned X's and places an X on a square her choosing.\n 2. The second player is assigned O's and places an O on any of the remaining squares. \n 3. The two players take turns placing X's and O's on the board. \n 4. The first player to get three X's or O's in a row is the winner.\n 5. If all  squares of the board are filled with no player getting    three in row, the game ends in a draw";
        self.helpButton = !self.helpButton;
    } else {
        self.gameRules.text = @"";
        self.helpButton = !self.helpButton;
    }
}
- (IBAction)restartButton:(id)sender {
    [self reset];
}

-(void)reset
{

    self.pointOfPanSaved = self.pointofLabelOrigin;

    [self.timer invalidate];
    self.currentSeconds = 16;
    [self createTimer];
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

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self reset];
    }
}


-(void)createTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
}

-(void)onTick:(NSTimer *)timer
{
    if (self.currentSeconds > 0) {
        self.currentSeconds -= 1;
        self.timerLabel.text = [NSString stringWithFormat:@"%d", self.currentSeconds];
    } else {
        self.timerLabel.text = @"X";
        self.timerLabel.textColor = [UIColor redColor];
        self.turn = !self.turn;
            if ([self.whichPlayerLabel.text isEqualToString:@"X"]) {
            self.whichPlayerLabel.text = @"O";
            [timer invalidate];
            self.currentSeconds = 16;
            [self createTimer];
            self.timerLabel.textColor = [UIColor colorWithRed:221.0 green:221.0 blue:221.0 alpha:1];
            }
            else {
                self.whichPlayerLabel.text = @"X";
                [timer invalidate];
                self.currentSeconds = 16;
                [self createTimer];
                self.timerLabel.textColor = [UIColor colorWithRed:221.0 green:221.0 blue:221.0 alpha:1];
            }
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
