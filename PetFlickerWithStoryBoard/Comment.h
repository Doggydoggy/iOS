//
//  Comment.h
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/7/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * message;
@property(nonatomic,strong)NSString * profileImageUrl;
@property(nonatomic,strong)NSDate* date;
-(id)initWithName:(NSString*)name Message:(NSString*)message ProfileImageURL:(NSString*)profileImageUrl Date:(NSDate*)date;
@end
