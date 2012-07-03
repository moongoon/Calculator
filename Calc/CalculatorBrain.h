//
//  CalculatorBrain.h
//  Calc
//
//  Created by Gary Higginbotham on 6/29/12.
//  Copyright (c) 2012 AMDA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (void) clearList;
- (double)performOperation:(NSString *)operation;

@end
