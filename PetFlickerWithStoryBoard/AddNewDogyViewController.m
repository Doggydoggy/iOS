//
//  AddNewDogyViewController.m
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/21/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "AddNewDogyViewController.h"
#import "utilities.h"
#import "NSObject_GlobalVariables.h"

@interface AddNewDogyViewController ()

@end

@implementation AddNewDogyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    gender =@"none";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)go:(id)sender
{
    
    NSString * name = _nameFeild.text;
    NSString * dob = _DOBFeild.text;
    NSString * breed = _BreedFeild.text;
    NSDictionary * imgInfo = [utilities RenderAImgNameAndURL];
    NSString * imgName = [imgInfo objectForKey:@"Img_name"];
    NSString * imgUrl = [imgInfo objectForKey:@"Img_url"];
    NSString * description = _discriptionView.text;
    //PetParam_pet_name
    [utilities CreatePetWithUserName:[utilities ReadProfilePlist:@"username"] OtherParms:@{[NSNumber numberWithInt:PetParam_breed]:breed,[NSNumber numberWithInt:PetParam_DOB]:dob,[NSNumber numberWithInt:PetParam_sex]:gender,[NSNumber numberWithInt:PetParam_profileImg]:imgUrl,[NSNumber numberWithInt:PetParam_qid]:[utilities ReadProfilePlist:@"qid"],[NSNumber numberWithInt:PetParam_description]:description,[NSNumber numberWithInt:PetParam_pet_name]:name}];
     
    // retrieve updated pet info
    [utilities GetPetInfoWriteToPList:[utilities ReadProfilePlist:@"qid"]];
}

-(IBAction)genderSelection:(id)sender
{
    if (((UIButton*)sender).tag==0) {
        gender = @"male";
    }else
        gender = @"female";
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
