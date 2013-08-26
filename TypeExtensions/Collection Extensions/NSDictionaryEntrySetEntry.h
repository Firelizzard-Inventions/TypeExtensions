//
//  NSDictionaryEntry.h
//  TypeExtensions
//
//  Created by Ethan Reesor on 12/9/12.
//  Copyright (c) 2012 Lens Flare. Some rights reserved, see license.
//

#import <Foundation/Foundation.h>

@interface NSDictionaryEntrySetEntry : NSObject


/*******************************************************************************
 * Model Properties
 */

// The key object
@property (readonly) NSObject * key;

// The value object
@property (readonly) NSObject * object;


/*******************************************************************************
 * Lifecycle Methods
 */

// Initialize a dictionary entry reference
- (id)initWithKey:(NSObject *)key forDictionary:(NSDictionary *)dictionary;


/*******************************************************************************
 * Class Methods
 */

// Create a dictionary entry reference
+ (NSDictionaryEntrySetEntry *)dictionaryEntryWithKey:(NSObject *)key forDictionary:(NSDictionary *)dictionary;

@end
