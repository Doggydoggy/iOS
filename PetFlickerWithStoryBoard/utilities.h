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
+(NSDictionary*)GetUserInfo:(NSString*)token;
+(BOOL)WriteToProfilePlist:(NSString*)Key Value:(NSObject*)value;
+(NSString*)ReadProfilePlist:(NSString*)Key;
+(BOOL)UserIsRegisted;
+(BOOL)SetupUserPlist;
+(BOOL)UpdateOneUserAttribute:(enum UserUpdateParms)Key Value:(NSObject*)value Token:(NSString*)token;
+(BOOL)UpdateUserAttributes:(NSDictionary*)dict Token:(NSString*)token;
+(BOOL)Follow:(NSNumber*)thisQid OtherQid:(NSNumber*)otherQid Token:(NSString*)token;
+(BOOL)UnFollow:(NSNumber*)thisQid OtherQid:(NSNumber*)otherQid Token:(NSString*)token;
+(int)CreateStory:(NSNumber*)qid Message:(NSString*)message OtherParms:(NSDictionary*)params Token:(NSString*)token;
+(BOOL)DeleteStory:(NSNumber*)qid Sid:(NSNumber*)sid Token:(NSString*)token;
+(BOOL)CreatePetWithUserName:(NSString*)userName OtherParms:(NSDictionary*)params Token:(NSString*)token;
+(BOOL)UpdatePetWithUpdateParams:(NSDictionary*)dict Token:(NSString*)token;


@end
