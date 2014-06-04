//
//  RegisterViewController.h
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/2/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utilities.h"
@interface RegisterViewController : UIViewController
@property(nonatomic,strong)IBOutlet UITextField * userNameField;
@property(nonatomic,strong)IBOutlet UITextField * userPassWordField;
@property(nonatomic,strong)IBOutlet UITextField * userPassWordConfirmField;
@property(nonatomic,strong)IBOutlet UIButton * registerButton;
-(IBAction)GoRegister:(id)sender;
@end
