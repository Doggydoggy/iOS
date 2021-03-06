//
//  UserLoginViewController.h
//  PetFlickerWithStoryBoard
//
//  Created by He, Changchen on 5/10/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "ViewController.h"
#import "utilities.h"

@interface UserLoginViewController : ViewController

@property(nonatomic,strong)IBOutlet UITextField * userNameField;
@property(nonatomic,strong)IBOutlet UITextField * userPassWordField;
@property(nonatomic,strong)IBOutlet UIButton * goButton;
@property(nonatomic,strong)IBOutlet UIButton * registerButton;

-(IBAction)Go:(id)sender;
-(IBAction)Register:(id)sender;


@end
