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

@interface utilities : NSObject

+(void)CreateLocalDBAndTable;
+(NSDictionary*)GetDetailAddressInfoFromLat:(NSString*)Lat andLongt:(NSString*)Longt;
+(NSString*)GetCityFromLat:(NSString*)Lat andLongt:(NSString*)Longt;
+(NSString *)CreateUUID;


@end
