//
//  ViewCommentsViewController.h
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/12/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"
#import "StoryCommentCellTableViewCell.h"
#import "SeeMoreCell.h"
#import "NSObject_GlobalVariables.h"

@interface ViewCommentsViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    float totalCellHeight;
}
@property(strong,nonatomic)Story *story;
@property (strong,nonatomic) NSMutableArray * dataArray;
@property (strong,nonatomic) NSMutableArray * heightArray;
@property(strong,nonatomic)IBOutlet UITableView * CommentTableView;
-(IBAction)back:(id)sender;

@end
