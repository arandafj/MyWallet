//
//  NSObject+GNUStep.m
//  Wallet
//
//  Created by CLAG on 18/7/16.
//  Copyright © 2016 Clag. All rights reserved.
//

#import "NSObject+GNUStep.h"

@import ObjectiveC;

@implementation NSObject (GNUStep)

-(id) subclassResponsibility: (SEL)aSel{
    
    char prefix = class_isMetaClass(object_getClass(self)) ? '+': '-';
    
    [NSException raise: NSInvalidArgumentException
                format:@"%@%c%@ should be overriden by its subclass",
     NSStringFromClass([self class]), prefix, NSStringFromSelector(aSel)];
    
    return self; // not reached
    
}

@end

