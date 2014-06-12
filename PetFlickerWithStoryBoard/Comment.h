//
//  Comment.h
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/7/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property(nonatomic,strong)NSNumber * qid;
@property(nonatomic,strong)NSString * profile_img;
@property(nonatomic,strong)NSNumber * sid;
@property(nonatomic,strong)NSString * message;
@property(nonatomic,strong)NSString * nickName;
@property(nonatomic,strong)NSNumber* posted;


-(id)initWithName:(NSString*)nickName Message:(NSString*)message ProfileImageURL:(NSString*)profile_img Date:(NSNumber*)postedTime sid:(NSNumber*)sid qid:(NSNumber*)qid ;
@end
