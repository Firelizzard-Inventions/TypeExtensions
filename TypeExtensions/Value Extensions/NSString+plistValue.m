//
//  NSString+plistValue.m
//  ObjectiveSQL
//
//  Created by Ethan Reesor on 11/20/12.
//  Copyright (c) 2012 Lens Flare. All rights reserved.
//

#import "NSString+plistValue.h"

#import "NSString+dataValue.h"

@implementation NSString (plistValue)

- (NSDictionary *)plistValue
{
	NSDictionary * plist = [NSPropertyListSerialization propertyListWithData:[self dataValue]
																	 options:0
																	  format:NULL
																	   error:NULL];
	
	if (plist)
		return plist;
	else
		return @{};
}

@end
