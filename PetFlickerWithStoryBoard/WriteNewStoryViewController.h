//
//  WriteNewStoryViewController.h
//  DearYou
//
//  Created by VincentHe on 1/13/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLLocationManager+Block.h"
#import "NSObject_GlobalVariables.h"

#define PhotoStartingX 9
#define PhotoStartingY 7
#define PhotoMargin 10
#define PhotoBackgroundHeight 73
#define PhotoButtonSize 62


#define  S3StroyPhotoURL @"https://s3.amazonaws.com/appdearyou/StoryPhotos/"

@interface WriteNewStoryViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIViewControllerTransitioningDelegate,UITextViewDelegate>
{
    int cursor;
}

@property(nonatomic,strong)NSNumber * pid;

@property(nonatomic,strong)IBOutlet UITextView * StoryBodyView;
@property(strong)NSMutableArray * photoButtons;
@property(strong)NSMutableArray * photoFiles;
@property(strong)NSMutableDictionary * photoDict;
@property(strong)IBOutlet UISwitch * locationSwitch;
@property(strong)IBOutlet UILabel * locationLabel;
@property(strong)IBOutlet UIView * locationView;

@property(nonatomic,strong)IBOutlet UIBarButtonItem * backButton;

@property(strong)NSString * lat;
@property(strong)NSString * longt;
@property(strong)NSString * locationDescription;


@property(nonatomic,strong)IBOutlet UIView * backgroundView;


-(IBAction)send:(id)sender;
-(IBAction)back:(id)sender;
-(IBAction)onOrOFF:(id)sender;
@end
