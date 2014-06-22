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
#import "Comment.h"
#import "Pet.h"

@interface utilities : NSObject

+(NSMutableArray*)GetStoriesFromFiles:(NSString*)file;
+(NSMutableArray*)SavePetsToInfoListFromFile:(NSString*)file;

+(void)testASIHTTPS;
+(NSMutableArray*)GetPetsFromInfoList;
+(float)getLabelHeightByText:(NSString*)text;
+(void)CreateLocalDBAndTable;
+(NSDictionary*)GetDetailAddressInfoFromLat:(NSString*)Lat andLongt:(NSString*)Longt;
+(NSString*)GetCityFromLat:(NSString*)Lat andLongt:(NSString*)Longt;
+(NSString *)CreateUUID;
+(BOOL)RegisterNewUser:(NSString*)username andPassword:(NSString*)password;
+(NSDictionary*)LoginUser:(NSString*)username andPassword:(NSString*)password;
+(NSDictionary*)GetUserInfo;
+(BOOL)WriteToProfilePlist:(NSString*)Key Value:(NSObject*)value;
+(NSString*)ReadProfilePlist:(NSString*)Key;
+(BOOL)UserIsRegisted;
+(BOOL)SetupUserPlist;
+(BOOL)UpdateOneUserAttribute:(enum UserUpdateParms)Key Value:(NSObject*)value;
+(BOOL)UpdateUserAttributes:(NSDictionary*)dict;
+(BOOL)Follow:(NSNumber*)thisQid OtherQid:(NSNumber*)otherQid;
+(BOOL)UnFollow:(NSNumber*)thisQid OtherQid:(NSNumber*)otherQid;
+(int)CreateStory:(NSNumber*)qid Message:(NSString*)message OtherParms:(NSDictionary*)params;
+(BOOL)DeleteStory:(NSNumber*)qid Sid:(NSNumber*)sid;
+(BOOL)CreatePetWithUserName:(NSString*)userName OtherParms:(NSDictionary*)params;
+(BOOL)UpdatePetWithUpdateParams:(NSDictionary*)dict;
+(NSMutableArray*)GetPetStories:(NSNumber* )pid;
+(BOOL)GetPetInfoWriteToPList:(NSString*)qid;
+(NSDictionary*)RenderAImgNameAndURL;
+(NSString *)TimeIntervalToStringWithInterval:(NSTimeInterval)interval;



@end
