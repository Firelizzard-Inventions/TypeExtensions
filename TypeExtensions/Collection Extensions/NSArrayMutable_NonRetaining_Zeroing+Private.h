//
//  NSArray_NonRetaining_Zeroing_Private.h
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/24/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "NSArray_NonRetaining_Zeroing.h"

@protocol __NSArray_NonRetaining_Zeroing__Container <NSObject>

- (id)object;

@end

@interface NSArray_NonRetaining_Zeroing ()

+ (id)nonRetainingZeroingEntityForObject:(id)object;
+ (void)nonRetainingZeroingEntities:(id **)entities forObjects:(const id [])objects count:(NSUInteger)cnt;

@end
