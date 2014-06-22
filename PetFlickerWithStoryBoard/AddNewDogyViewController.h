//
//  AddNewDogyViewController.h
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/21/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewDogyViewController : UIViewController
{
    NSString * gender;
}
@property(nonatomic,strong) IBOutlet UITextField * nameFeild;
@property(nonatomic,strong) IBOutlet UITextField * DOBFeild;
@property(nonatomic,strong) IBOutlet UITextField * BreedFeild;
@property(nonatomic,strong) IBOutlet UITextView * discriptionView;
@property(nonatomic,strong) IBOutlet UIButton * maleButton;
@property(nonatomic,strong) IBOutlet UIButton * femaleButton;
@property(nonatomic,strong) IBOutlet UIImageView * profileImageView;
@property(nonatomic,strong) IBOutlet UIButton * goButton;


-(IBAction)go:(id)sender;
-(IBAction)genderSelection:(id)sender;



@end
