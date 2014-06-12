//
//  Story.m
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/8/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "Story.h"

@implementation Story
-(id)initWithMessage:(NSString *)message Comments:(NSMutableArray*)commentArray DateString:(NSString*)dataString numberOfLikes:(int)likes
{
    //_commentArray = commentArray;
    _message=message;
    //TODO: get date from String
   // _date = [NSDate date];
    _likes = likes;
    _numberOfComments=(int)[commentArray count];
    return self;
}

@end
