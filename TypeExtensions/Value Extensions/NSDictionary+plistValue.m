//
//  NSDictionary+plistValue.m
//  ObjectiveSQL
//
//  Created by Ethan Reesor on 11/20/12.
//  Copyright (c) 2012 Lens Flare. Some rights reserved, see license.
//

#import "NSDictionary+plistValue.h"

@implementation NSDictionary (plistValue)

- (NSString *)plistValue
{
	NSString * plist = [[NSString alloc] initWithData:[NSPropertyListSerialization dataWithPropertyList:self
																								 format:	NSPropertyListXMLFormat_v1_0
																								options:0
																								  error:NULL]
											 encoding:NSUTF8StringEncoding];
	
	if (plist)
		return plist;
	else
		return @"";
}

@end
