//
//  MenuCell.h
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 4/21/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuCell;
@protocol MenuCellDelegate <NSObject>
@required
- (void)newStoryButtonClicked;
- (void)settingsButtonClicked;
- (void)timeBackButtonClicked;
@end

@interface MenuCell : UITableViewCell
{
    __weak id <MenuCellDelegate> menuCellDelegate;

}

@property(nonatomic,strong)IBOutlet UIButton * takePicButton;
@property(nonatomic,strong)IBOutlet UIButton * timeBackButton;
@property(nonatomic,strong)IBOutlet UIButton * settingsButton;
@property (nonatomic, weak) id <MenuCellDelegate> menuCellDelegate;

-(IBAction)cameraClicked:(id)sender;
-(IBAction)settingsClicked:(id)sender;
-(IBAction)timeBackClicked:(id)sender;

@end
