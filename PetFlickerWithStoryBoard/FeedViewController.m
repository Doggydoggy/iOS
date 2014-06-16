//
//  FeedViewController.m
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/15/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "FeedViewController.h"
#import "REFrostedViewController.h"
#import "NSObject_GlobalVariables.h"


@interface FeedViewController ()

@end

@implementation FeedViewController

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
    
    self.title = @"TimeLine";
    //self.navigationController.navigationBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    UINavigationBar* navigationBar = self.navigationController.navigationBar;
    UIColor *navigationBarColor=UINAVIGATIONBARCOLOR;
    [navigationBar setBackgroundColor:navigationBarColor];
    [navigationBar setBarTintColor:[UIColor colorWithRed:0.0f green:0.0f blue:90.0f/255.0f alpha:1]];
    // set status bar color
    const CGFloat statusBarHeight = 20;    //  Make this dynamic in your own code...
    UIView* underlayView = [[UIView alloc] initWithFrame:CGRectMake(0, -statusBarHeight, navigationBar.frame.size.width,statusBarHeight)];
    [underlayView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [underlayView setBackgroundColor:navigationBarColor];
    [navigationBar insertSubview:underlayView atIndex:0];
    
    
    UIButton *buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonLeft.frame = CGRectMake(0, 0, 21, 21);
    [buttonLeft setImage:[UIImage imageNamed:@"list view.png"] forState:UIControlStateNormal];
    [buttonLeft addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:buttonLeft];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)showMenu
{
    [self.frostedViewController presentMenuViewController];
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
