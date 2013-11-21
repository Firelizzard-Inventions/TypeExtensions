//
//  NSObject+zeroingWeakReferenceProxy.h
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/25/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (zeroingWeakReferenceProxy)

- (id<NSObject>)zeroingWeakReferenceProxy;

@end