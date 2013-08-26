//
//  NSString+urlValue.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 12/6/12.
//  Copyright (c) 2012 Lens Flare. Some rights reserved, see license.
//

#import "NSString+urlValue.h"

@implementation NSString (urlValue)

- (NSURL *)urlValue
{
	NSURL * url = [NSURL URLWithString:self];
	if (!url.scheme)
		url = [NSURL fileURLWithPath:self];
	return url;
}

@end
