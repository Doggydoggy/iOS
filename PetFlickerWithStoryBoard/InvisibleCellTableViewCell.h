//
//  InvisibleCellTableViewCell.h
//  PetFlickerWithStoryBoard
//
//  Created by He, Changchen on 5/8/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBPathImageView.h"
@interface InvisibleCellTableViewCell : UITableViewCell


@property(nonatomic,strong)IBOutlet UIImageView*doggyProfileImageView;

-(void)initCell;
@end

