//
//  LFBinarySearchTreeDictionary.h
//  TypeExtensions
//
//  Created by Ethan Reesor on 11/18/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary_BinarySearchTree : NSDictionary

@property (readonly) NSUInteger count;

- (id)balancedCopy;

@end
