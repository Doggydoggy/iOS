//
//  SelectionMenuButtonViewViewController.h
//  DearYou
//
//  Created by He, Changchen on 1/15/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectionMenuButtonViewViewController : UIViewController
{
    NSString * imageName;
    NSString * buttontitle;
    int buttontag;
}

-(id)initWIthButtonImageName:(NSString*)ImageName andTitle:(NSString*)title andTag:(int)tag;

@property(nonatomic,strong)IBOutlet UILabel * iconLabel;
@property(nonatomic,strong)IBOutlet UIImageView * buttonIconView;
@property(nonatomic,strong)IBOutlet UIImageView * statusView;

@property(nonatomic,strong)IBOutlet UIButton * clickButton;

-(void)TurnOnStatusView;
-(void)TurnOffStatusView;

@end
