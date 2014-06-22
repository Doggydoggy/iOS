//
//  InvisibleCellTableViewCell.h
//  PetFlickerWithStoryBoard
//
//  Created by He, Changchen on 5/8/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBPathImageView.h"
#import "Pet.h"
#import "utilities.h"
@interface InvisibleCellTableViewCell : UITableViewCell


@property(nonatomic,strong)IBOutlet UIImageView*doggyProfileImageView;

@property(nonatomic,strong)IBOutlet UIImageView* genderView;
@property(nonatomic,strong)IBOutlet UILabel* breedLabel;
@property(nonatomic,strong)IBOutlet UILabel * ageLabel;
@property(nonatomic,strong)IBOutlet UILabel *petNameLabel;


-(void)initCellWithPet:(Pet*)pet;
@end

