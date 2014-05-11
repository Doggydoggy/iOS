//
//  PersonalInfoViewController.m
//  DearYou
//
//  Created by VincentHe on 1/4/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "SelectionMenuCell.h"
#import "SelectionMenuButtonViewViewController.h"
#define  buttonViewgap 1
@interface SelectionMenuCell()

@end

@implementation SelectionMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

-(void)initCell
{
    NSDictionary * button1 = @{@"ImageName": @"PicIcon",@"Title":@"Stories"};
    NSDictionary * button2 = @{@"ImageName": @"PicIcon",@"Title":@"Chat"};
    NSDictionary * button3 = @{@"ImageName": @"PicIcon",@"Title":@"Photos"};
    NSArray * buttonArray = @[button1,button2,button3];
    CGRect frame ;
    NSMutableArray * buttonViewArray = [[NSMutableArray alloc] init];
    int index = 0;
    for(NSDictionary * buttonInfo in buttonArray)
    {
        SelectionMenuButtonViewViewController * buttonView = [[SelectionMenuButtonViewViewController alloc] initWIthButtonImageName:[buttonInfo objectForKey:@"ImageName"] andTitle:[buttonInfo objectForKey:@"Title"] andTag:index];
        frame = buttonView.view.frame;
        
        if ([[buttonInfo objectForKey:@"ImageName"] isEqualToString:@"chatIcon"]) {
            chatButtonView = buttonView;
        }
        
        [buttonViewArray addObject:buttonView];
        index++;
    }
    
    self.scrollView.contentSize =CGSizeMake((frame.size.width+buttonViewgap)*buttonArray.count, self.scrollView.frame.size.height);
    
    float startX=0;
    float startY=0;
    index=0;
    
    for(SelectionMenuButtonViewViewController * AbuttonView in buttonViewArray)
    {
        
        AbuttonView.view.frame = CGRectMake(startX,startY,AbuttonView.view.frame.size.width, AbuttonView.view.frame.size.width);
        [self.scrollView addSubview:AbuttonView.view];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button addTarget:self
                   action:@selector(selectionButtonClicked:)
         forControlEvents:UIControlEventTouchDown];
        //[button setTitle:@"Show View" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor clearColor]];
        button.frame = AbuttonView.view.frame;
        button.tag =index;
        [self.scrollView addSubview:button];
        startX+=frame.size.width+buttonViewgap;
        index++;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateUnreadStatus:) name: @"ChatUnreadStatus" object:nil];
}

-(void)UpdateUnreadStatus:(NSNotification *) notification
{
    NSString * receivedStatus = [notification.userInfo objectForKey:@"Status"];
    if ([receivedStatus isEqualToString:@"ON"]) {
        [chatButtonView TurnOnStatusView];
    }
    if ([receivedStatus isEqualToString:@"OFF"]) {
        [chatButtonView TurnOffStatusView];
    }
}

-(void)selectionButtonClicked:(UIButton*)button
{
    return;
    switch (button.tag) {
        case 0:
            [self.SelectionCellDelegate WriteStoryButtonClicked];
            break;
        case 1:
            [self.SelectionCellDelegate ChatButtonClicked];
            break;
        case 2:
            [self.SelectionCellDelegate PhotosButtonClicked];
            break;
        case 3:
            [self.SelectionCellDelegate TheWorldButtonClicked];
            break;
        case 4:
            [self.SelectionCellDelegate ProfileButtonClicked];
            break;
        case 5:
            [self.SelectionCellDelegate GiftsButtonClicked];
            break;
        case 6:
            [self.SelectionCellDelegate SettingsButtonClicked];
            break;
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (IBAction)changePage {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

@end
