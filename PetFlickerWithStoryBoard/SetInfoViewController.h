//
//  SetInfoViewController.h
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/14/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject_GlobalVariables.h"
#import "utilities.h"

@interface SetInfoViewController : UIViewController<UIActionSheetDelegate>
{
    NSString * gender;
    NSString * nickName;
}
@property(nonatomic,strong)IBOutlet UITextField * nickNameField;
@property(nonatomic,strong)IBOutlet UIButton * maleButton;
@property(nonatomic,strong)IBOutlet UIButton * femalebutton;
@property(nonatomic,strong)IBOutlet UIImageView * profileImageView;
@property(nonatomic,strong)IBOutlet UIButton * profileImageButton;


-(IBAction)changeProfileImageButtonClicked:(id)sender;
-(IBAction)go:(id)sender;
-(IBAction)maleButtonClicked:(id)sender;
-(IBAction)femaleButtonClicked:(id)sender;

@end
