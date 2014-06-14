//
//  SetInfoViewController.m
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/14/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "SetInfoViewController.h"

@interface SetInfoViewController ()

@end

@implementation SetInfoViewController

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
    if ([utilities ReadProfilePlist:@"nickName"]!=nil&&[utilities ReadProfilePlist:@"sex"]!=nil) {
        [self performSegueWithIdentifier:@"InfoToMain" sender:self];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)changeProfileImageButtonClicked:(id)sender
{
    NSString *other1 = @"Camera";
    NSString *other2 = @"Photo Library";
    
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *theactionSheet = [[UIActionSheet alloc]
                                     initWithTitle:@"Pick your photo from:"
                                     delegate:self
                                     cancelButtonTitle:cancelTitle
                                     destructiveButtonTitle:nil
                                     otherButtonTitles:other1,other2, nil];
    [theactionSheet showInView:self.view];
}

-(IBAction)go:(id)sender
{
    NSDictionary * param = @{[NSNumber numberWithInt:UserParm_nickName]:_nickNameField.text,[NSNumber numberWithInt:UserParm_sex]:gender};
    if ([utilities UpdateUserAttributes:param]) {
        NSDictionary * dict = [utilities GetUserInfo];
        if([dict count]>1)
        {
            for(NSString* key in dict)
            {
                [utilities WriteToProfilePlist:key Value:[dict objectForKey:key]];
            }
            [self performSegueWithIdentifier:@"InfoToMain" sender:self];
            
        }else
        {
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Failed To Fetch User Info." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}

-(IBAction)maleButtonClicked:(id)sender
{
    gender = @"male";
}

-(IBAction)femaleButtonClicked:(id)sender
{
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
