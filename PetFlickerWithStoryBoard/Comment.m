//
//  Comment.m
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/7/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "Comment.h"

@implementation Comment

-(id)initWithName:(NSString*)nickName Message:(NSString*)message ProfileImageURL:(NSString*)profile_img Date:(NSNumber*)postedTime sid:(NSNumber*)sid qid:(NSNumber*)qid
{
    _nickName = nickName;
    _message = message;
    _profile_img = profile_img;
    _posted=postedTime;
    _sid = sid;
    _qid = qid;
    return  self;
}
@end
