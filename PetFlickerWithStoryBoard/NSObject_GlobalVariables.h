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
#define USER @"user"
#define SERVERADDRESS @"http://107.170.115.138/"
#define USERUPDATPARM @[@"username",@"id",@"firstName",@"lastName",@"DOB",@"email",@"age",@"sex",@"nickName",@"profile_img",@"geoLocation",@"pet_name",@"pet_DOB",@"pet_profile_img",@"pet_sex",@"pet_geoLocation"]


enum UserUpdateParms
{
    UserParm_username, // == 0 (by default)
    UserParm_id, // == 1 (incremented by 1 from previous)
    UserParm_firstName, // == 2
    UserParm_lastName,
    UserParm_DOB,
    UserParm_email,
    UserParm_age,
    UserParm_sex,
    UserParm_nickName,
    UserParm_profile_img,
    UserParm_geoLocation,
    UserParm_pet_name,
    UserParm_pet_DOB,
    UserParm_pet_profile_img,
    UserParm_pet_sex,
    UserParm_pet_geoLocation
};
@end
