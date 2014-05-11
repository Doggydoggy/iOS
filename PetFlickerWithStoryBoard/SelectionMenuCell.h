//
//  PersonalInfoViewController.h
//  DearYou
//
//  Created by VincentHe on 1/4/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionMenuButtonViewViewController.h"

@class SelectionMenuCell;
@protocol SelectionMenuCellDelegate <NSObject>
@required
- (void)WriteStoryButtonClicked;
- (void)ChatButtonClicked;
- (void)PhotosButtonClicked;
- (void)TheWorldButtonClicked;
- (void)ProfileButtonClicked;
- (void)GiftsButtonClicked;
- (void)SettingsButtonClicked;
@end

@interface SelectionMenuCell : UITableViewCell
{
    __weak id <SelectionMenuCellDelegate> SelectionCellDelegate;
    SelectionMenuButtonViewViewController * chatButtonView;
}

@property (nonatomic, weak) id <SelectionMenuCellDelegate> SelectionCellDelegate;
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl* pageControl;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (IBAction)changePage;
-(void)initCell;

@end
