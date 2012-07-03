//
//  calculatorViewController.m
//  Calc
//
//  Created by Gary Higginbotham on 6/29/12.
//  Copyright (c) 2012 AMDA. All rights reserved.
//

#import "calculatorViewController.h"
#import "CalculatorBrain.h"

// set private interface elements here.  This is not public API.
@interface calculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOFEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation calculatorViewController

// initializes setters and getters
@synthesize display;
@synthesize operationsDisplay = _operationsDisplay;
@synthesize userIsInTheMiddleOFEnteringANumber;
@synthesize brain = _brain;

// initialize the calculator brain
- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}


// Delete Button
- (IBAction)delPressed:(UIButton *)sender {
    
    if (self.userIsInTheMiddleOFEnteringANumber){
        self.display.text = [self.display.text substringToIndex:[self.display.text length] - 1];
        if ([self.display.text length] < 1){
            self.display.text = @"0";
            self.userIsInTheMiddleOFEnteringANumber = NO;
        }
    }
    
}


// decimalPoint Button
- (IBAction)decimalPressed:(UIButton *)sender {
     
    if (self.userIsInTheMiddleOFEnteringANumber){
        NSRange range = [self.display.text rangeOfString:@"."];
        if (range.location == NSNotFound) {
            [self.display setText:[self.display.text stringByAppendingString:@"."]];
        }
    } else {
        self.display.text = @"0.";//if user starts with a decimal point, add a zero
        self.userIsInTheMiddleOFEnteringANumber = YES;
    }
    
}


- (IBAction)digitPressed:(UIButton *)sender {
    
    NSString *digit = sender.currentTitle;
    if (self.userIsInTheMiddleOFEnteringANumber){
        [self.display setText:[self.display.text stringByAppendingString:digit]];
    }  else {
        self.display.text = digit;
        self.userIsInTheMiddleOFEnteringANumber = YES;
    }
    
}


- (IBAction)enterPressed {
    
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOFEnteringANumber = NO;
    
    // also when user presses enter, add the number to the operations display text
    [self.operationsDisplay setText:[self.operationsDisplay.text stringByAppendingString:[NSString stringWithFormat:@" %@",self.display.text]]];
                             
}


- (IBAction)clearPressed {
    self.userIsInTheMiddleOFEnteringANumber = NO;
    display.text = @"0";
    _operationsDisplay.text = @"";
    [self.brain clearList];
}


- (IBAction)inversePressed:(UIButton *)sender {

    NSRange range = [self.display.text rangeOfString:@"-"];
    if (range.location == NSNotFound) {
        self.display.text = [NSString stringWithFormat:@"-%@", self.display.text     ];
    } else {
        [self.display setText:[self.display.text substringFromIndex:1]];
    }

    if (!self.userIsInTheMiddleOFEnteringANumber){
        [self enterPressed];
    }
    
}


- (IBAction)operationPressed:(UIButton *)sender {
    
    if (self.userIsInTheMiddleOFEnteringANumber){
            
            [self enterPressed];
            NSString *operation = [sender currentTitle];
            double result = [self.brain performOperation:operation];
            self.display.text = [NSString stringWithFormat:@"%g", result];
            [self.operationsDisplay setText:[self.operationsDisplay.text stringByAppendingString:[NSString stringWithFormat:@" %@ = %@", operation, self.display.text]]];
    
            
    } else { // user is not in the middle of entering a number
        
        NSString *operation = [sender currentTitle];
        double result = [self.brain performOperation:operation];
        self.display.text = [NSString stringWithFormat:@"%g", result];
                
    }

}

@end
