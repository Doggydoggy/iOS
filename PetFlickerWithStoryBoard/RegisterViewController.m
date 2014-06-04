//
//  RegisterViewController.m
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/2/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)GoRegister:(id)sender
{
    NSString * userName = _userNameField.text;
    NSString * passWord = _userPassWordField.text;
    NSString * passWordComfirm = _userPassWordConfirmField.text;

    if (userName==nil||passWord==nil||passWordComfirm==nil||[userName length]==0||[passWord length]==0||[passWordComfirm length]==0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please fill in your info" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    if (![passWord isEqualToString:passWordComfirm]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check your password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    if([utilities RegisterNewUser:userName andPassword:passWord])
    {
        // login
        // TODO: md5 hash password
        NSDictionary * dict = [utilities LoginUser:userName andPassword:passWord];
        if([dict count]>1)
        {
            //TODO: add to user plist
            //RegisterToMain
            [self performSegueWithIdentifier:@"RegisterToMain" sender:self];
        }
    }
    

    
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
