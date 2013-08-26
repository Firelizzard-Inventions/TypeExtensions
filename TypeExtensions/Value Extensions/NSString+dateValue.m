//
//  NSString+dateValue.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 2/13/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSString+dateValue.h"

#import <TypeExtensions/NSDate+stringValue.h>

@implementation NSString (dateValue)

- (NSDate *)dateValue
{
    return [[NSDate formatter] dateFromString:self];
}

@end
