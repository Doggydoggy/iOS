//
//  Story.h
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/8/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Comment.h"
@interface Story : NSObject

@property(nonatomic, strong) NSNumber *sid;
@property(nonatomic, strong) NSNumber *qid;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSArray *pics;
@property(nonatomic, strong) NSArray *comments;
@property(nonatomic, strong) NSNumber *pid;
@property(nonatomic, strong) NSString *pet_name;
@property(nonatomic, strong) NSNumber *posted;
@property(nonatomic)int likes;
@property(nonatomic)int numberOfComments;

-(id)initWithMessage:(NSString *)message Comments:(NSMutableArray*)commentArray DateString:(NSString*)dataString numberOfLikes:(int)likes;

@end
