//
//  utilities.h
//  PetFlickerWithStoryBoard
//
//  Created by He, Changchen on 5/9/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject_GlobalVariables.h"
#import "ASIS3ObjectRequest.h"
#import "ASIS3BucketRequest.h"
#import "ASIFormDataRequest.h"

@interface utilities : NSObject

+(void)CreateLocalDBAndTable;
+(NSDictionary*)GetDetailAddressInfoFromLat:(NSString*)Lat andLongt:(NSString*)Longt;
+(NSString*)GetCityFromLat:(NSString*)Lat andLongt:(NSString*)Longt;
+(NSString *)CreateUUID;
+(BOOL)RegisterNewUser:(NSString*)username andPassword:(NSString*)password;
+(NSDictionary*)LoginUser:(NSString*)username andPassword:(NSString*)password;
+(BOOL)SetupUserPlist;
+(BOOL)WriteToProfilePlist:(NSString*)Key Value:(NSObject*)value;


@end
