//
//  NSObject+varargsArray.h
//  TypeExtensions
//
//  Created by Ethan Reesor on 2/16/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (varargsArray)

- (NSArray *)varargsArrayNilTerminatedWithFirstArg:(id)firstArg, ...;

@end
