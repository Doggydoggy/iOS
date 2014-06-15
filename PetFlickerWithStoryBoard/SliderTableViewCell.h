//
//  SliderTableViewCell.h
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/14/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SliderTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView * iconView;
@property(nonatomic,strong)IBOutlet UILabel * titleLabel;
@property(nonatomic,strong)IBOutlet UILabel * attributeLabel;
@end
