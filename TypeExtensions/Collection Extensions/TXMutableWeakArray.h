//
//  NSArray_NonRetaining_Zeroing.h
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/24/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSObject+DeallocListener.h"

@interface TXMutableWeakArray : NSMutableArray <DeallocListener>

@end
