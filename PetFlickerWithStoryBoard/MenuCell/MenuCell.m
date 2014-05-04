//
//  MenuCell.m
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 4/21/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)cameraClicked:(id)sender
{
    [menuCellDelegate newStoryButtonClicked];
}
-(IBAction)settingsClicked:(id)sender
{
    [menuCellDelegate settingsButtonClicked];
}
-(IBAction)timeBackClicked:(id)sender
{
    [menuCellDelegate timeBackButtonClicked];
}



@end
