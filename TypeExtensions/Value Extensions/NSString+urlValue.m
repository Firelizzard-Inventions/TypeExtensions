//
//  NSString+urlValue.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 12/6/12.
//  Copyright (c) 2012 Lens Flare. All rights reserved.
//

#import "NSString+urlValue.h"

@implementation NSString (urlValue)

- (NSURL *)urlValue
{
	return [NSURL URLWithString:self];
}

@end
