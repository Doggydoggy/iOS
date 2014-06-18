//
//  UserLoginViewController.m
//  PetFlickerWithStoryBoard
//
//  Created by He, Changchen on 5/10/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "UserLoginViewController.h"

@interface UserLoginViewController ()

@end

@implementation UserLoginViewController

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
    self.navigationController.navigationBarHidden = YES;
    //if([utilities UserIsRegisted])
    //    [self performSegueWithIdentifier:@"LoginToSetInfo" sender:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)Go:(id)sender
{
    NSString * userName = _userNameField.text;
    NSString * passWord = _userPassWordField.text;
    if (userName==nil||passWord==nil||[userName length]==0||[passWord length]==0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill in your info" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    NSDictionary * dict = [utilities LoginUser:userName andPassword:passWord];
    if([dict count]>1)
    {
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"Success!" message:@"LoginSuccess" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        for(NSString* key in dict)
        {
            [utilities WriteToProfilePlist:key Value:[dict objectForKey:key]];
        }
        [utilities WriteToProfilePlist:@"password" Value:passWord];
        [self performSegueWithIdentifier:@"LoginToSetInfo" sender:self];
        
    }else
    {
        UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Login error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}

-(IBAction)Register:(id)sender
{
    [self performSegueWithIdentifier:@"LoginToRegister" sender:self];
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
