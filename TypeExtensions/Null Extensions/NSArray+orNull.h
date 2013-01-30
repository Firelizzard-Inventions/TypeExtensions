//
//  NSArray+orNull.h
//  ObjectiveSQL
//
//  Created by Ethan Reesor on 11/20/12.
//  Copyright (c) 2012 Lens Flare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (orNull)

- (id)objectAtIndexOrNil:(NSUInteger)index;

@end
