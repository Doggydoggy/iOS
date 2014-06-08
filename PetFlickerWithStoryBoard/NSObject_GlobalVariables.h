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
#define COMMENTCELLINITHEIGHT 80.0
#define COMMENTMESSAGEFONT [UIFont fontWithName:@"Helvetica Neue" size:14.0]
#define COMMENTUSERNAMEANDDATEHEIGHT 33.0
#define STORYCELLINITSIZE 349.0
#define STORYCELLMAXSIZE 450
#define STORYCOMMENTVIEWMAXHEIGHT (STORYCELLMAXSIZE-STORYCELLINITSIZE)
#define USER @"user"
#define SERVERADDRESS @"http://107.170.115.138/"
#define USERUPDATPARM @[@"username",@"id",@"firstName",@"lastName",@"DOB",@"email",@"age",@"sex",@"nickName",@"profile_img",@"geoLocation",@"pet_name",@"pet_DOB",@"pet_profile_img",@"pet_sex",@"pet_geoLocation"]
#define STORYUPDATPARM @[@"message",@"pic",@"qid",@"pid",@"username",@"lat",@"longt"]
#define PETUPDATPARM @[@"username",@"dog_breed",@"pet_name",@"DOB",@"sex",@"profile_img",@"lat",@"longt"]

#define TESTTOKEN @"WyJ0ZXN0MSIsInRlc3QxIl0.BnJypg.ZUxaafsMIuBfc_HMBi-6PDUSjZU"

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

enum StoryUpdateParams
{
    StoryParam_message, // == 0 (by default)
    StoryParam_pic, // == 1 (incremented by 1 from previous)
    StoryParam_qid, // == 2
    StoryParam_pid,
    StoryParam_username,
    StoryParam_lat,
    StoryParam_longt
};


enum PetUpdateParams
{
    PetParam_username, // == 0 (by default)
    PetParam_breed, // == 2
    PetParam_pet_name,
    PetParam_DOB,
    PetParam_sex,
    PetParam_profileImg,
    PetParam_lat,
    PetParam_longt
};

@end
