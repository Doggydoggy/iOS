//
//  ExampleViewController.h
//  MHVideoPhotoGallery
//
//  Created by Mario Hahn on 30.09.13.
//  Copyright (c) 2013 Mario Hahn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstCell.h"
#import "MHGalleryGlobals.h"
#import "MenuCell.h"
#import "REFrostedViewController.h"
#import "InvisibleCellTableViewCell.h"
#import "BTGlassScrollView.h"
#import "WriteNewStoryViewController.h"
#import "testViewController.h"
#import "GBPathImageView.h"
#import "StoryViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ViewCommentsViewController.h"  
#import "Pet.h"

@interface UINavigationController (autoRotate)
@end


@interface UITabBarController (autoRotate)
@end



@interface ExampleViewControllerCollectionViewInTableView : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIViewControllerTransitioningDelegate,MenuCellDelegate>
{
    BOOL BlurSwitchoff;
    BTGlassScrollView *_glassScrollView;
}
@property (strong,nonatomic) IBOutlet UITableView *tableView;
@property (strong) UIImage* BGImage;
@property (strong) UIImage* BluredBGImage;
@property(strong,nonatomic)IBOutlet UIImageView *backGroundImageView;
@property (strong,nonatomic)NSMutableArray * cellHeightArray;
@property (strong,nonatomic)NSMutableArray * cellStoriesCacheArray;
@property (strong,nonatomic)NSMutableArray * storyArray;
@property (strong,nonatomic)Pet *dogInfo;
- (IBAction)showMenu;
@end
