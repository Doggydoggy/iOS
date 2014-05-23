//
//  NSObject_GlobalVariables.h
//  PetFlickerWithStoryBoard
//
//  Created by He, Changchen on 5/9/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject ()

#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }
#define LOCALDBFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/doggy.db"]
#define SERVERADDRESS @"http://107.170.115.138/"
@end
