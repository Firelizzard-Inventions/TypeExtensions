//
//  NSObject_KVCUndefined.h
//  TypeExtensions
//
//  Created by Ethan Reesor on 2/5/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject_KVCUndefined : NSObject

@property BOOL tryLowerCase;
@property BOOL observeLowerCase;

- (NSArray *)redefinedKeys;

@end
