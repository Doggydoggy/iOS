//
//  Pet.h
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/15/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pet : NSObject
@property(nonatomic, strong) NSNumber *pid;
@property(nonatomic, strong) NSNumber *qid;
@property(nonatomic, strong) NSString *dog_breed;
@property(nonatomic, strong) NSNumber *lat;
@property(nonatomic, strong) NSNumber *longt;
@property(nonatomic, strong) NSString *pet_name;
@property(nonatomic, strong) NSNumber *DOB;
@property(nonatomic, strong) NSString *sex;
@property(nonatomic, strong) NSString *profile_img;
@property(nonatomic, strong) NSString *description;
@property(nonatomic, strong) NSString *adopting;
@property(nonatomic, strong) NSString *boarding;

@end
