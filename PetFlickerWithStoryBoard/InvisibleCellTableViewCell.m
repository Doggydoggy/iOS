//
//  InvisibleCellTableViewCell.m
//  PetFlickerWithStoryBoard
//
//  Created by He, Changchen on 5/8/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "InvisibleCellTableViewCell.h"

@implementation InvisibleCellTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initCellWithPet:(Pet*)pet;
{
    
    // TODO: get pet image
    GBPathImageView *squareImage1 = [[GBPathImageView alloc] initWithFrame:self.doggyProfileImageView.frame image:[UIImage imageNamed:@"嬛嬛2.jpg"] pathType:GBPathImageViewTypeSquare pathColor:[UIColor orangeColor] borderColor:[UIColor redColor] pathWidth:3.0];
    //Or get from nib, set params (or leave default) and start the draw method
    [squareImage1 setPathColor:[UIColor whiteColor]];
    [squareImage1 setBorderColor:[UIColor whiteColor]];
    [squareImage1 setPathWidth:1.0];
    [squareImage1 setPathType:GBPathImageViewTypeCircle];
    [squareImage1 draw];
    self.doggyProfileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.doggyProfileImageView.image = squareImage1.image;
    
    self.petNameLabel.text = pet.pet_name;
    self.breedLabel.text = pet.dog_breed;
    self.genderView.image = [pet.sex isEqualToString:@"male"]?[UIImage imageNamed:@"male.png"]:[UIImage imageNamed:@"female.png"];
    //TODO: smartly set age label
    
    NSString *dateStr = [NSString stringWithFormat:@"%@",pet.DOB];
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyymmdd"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    NSDate *currentData = [NSDate date];
    NSTimeInterval diff = [currentData timeIntervalSinceDate:date];
    _ageLabel.text = [utilities TimeIntervalToStringWithInterval:diff];

    
}


@end
