//
//  CalculatorBrain.m
//  Calc
//
//  Created by Gary Higginbotham on 6/29/12.
//  Copyright (c) 2012 AMDA. All rights reserved.
//

#import "CalculatorBrain.h"
#import "calculatorViewController.h"

@interface CalculatorBrain()
    
@property (nonatomic, strong) NSMutableArray *operandStack;

@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *) operandStack
{
    if (!_operandStack){
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}


- (void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
    
}

- (void)clearList
{
    [self.operandStack removeAllObjects];
}

- (double)popOperand
{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject)[self.operandStack removeLastObject];
    return [operandObject doubleValue];
}


- (double)performOperation:(NSString *)operation{
    
    double result = 0;
    
    if ([@"+" isEqualToString:operation]) {
        result = [self popOperand] + [self popOperand];
        
    } else if ([@"-" isEqualToString:operation]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
        
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
        
    } else if ([@"/" isEqualToString:operation]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
        
    } else if ([@"sin" isEqualToString:operation]) {
        result = sin([self popOperand]);
        
    } else if ([@"cos" isEqualToString:operation]) {
        result = cos([self popOperand]);
        
    } else if ([@"sqrt" isEqualToString:operation]) {
        result = sqrt([self popOperand]);
        
    } else if ([@"π" isEqualToString:operation]) {
        result = M_PI;
        
    } else if ([@"+/-" isEqualToString:operation]) {
        result = [self popOperand] *-1;
    }


    [self pushOperand:result];
    
    //perform operation and store answer in result
    
    return result;
    
}

@end
