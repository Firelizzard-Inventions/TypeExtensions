//
//  NSDate+stringValue.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 2/13/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSDate+stringValue.h"

@implementation NSDate (stringValue)

static NSDateFormatter * formatter = nil;

+ (NSDateFormatter *)defaultFormatter
{
    static NSDateFormatter * _default = nil;
    if (!_default)
        _default = [[NSDateFormatter alloc] initWithDateFormat:@"yyyy-MM-dd HH:mm:ss Z" allowNaturalLanguage:NO];
    return _default;
}

+ (NSDateFormatter *)formatter
{
    if (formatter)
        return formatter;
    else
        return [self defaultFormatter];
}

+ (void)setFormatter:(NSDateFormatter *)theFormatter
{
    formatter = theFormatter;
}

- (NSString *)stringValue
{
    return [[NSDate formatter] stringFromDate:self];
}

@end
