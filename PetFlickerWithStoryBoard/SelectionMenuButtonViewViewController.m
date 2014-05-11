//
//  SelectionMenuButtonViewViewController.m
//  DearYou
//
//  Created by He, Changchen on 1/15/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "SelectionMenuButtonViewViewController.h"

@interface SelectionMenuButtonViewViewController ()

@end

@implementation SelectionMenuButtonViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWIthButtonImageName:(NSString*)ImageName andTitle:(NSString*)title andTag:(int)tag
{
    self = [super init];
    if (self) {
        imageName = ImageName;
        buttontitle = title;
        buttontag = tag;
    }
    return  self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.iconLabel.text = buttontitle;
    self.buttonIconView.image = [UIImage imageNamed:imageName];
    self.clickButton.tag = buttontag;
    self.statusView.hidden = YES;
    // Do any additional setup after loading the view from its nib.
}

-(void)TurnOnStatusView
{
    self.statusView.hidden = NO;
}

-(void)TurnOffStatusView
{
    self.statusView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
