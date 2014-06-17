//
//  StoryCommentCellTableViewCell.h
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/7/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"
#import "NSObject_GlobalVariables.h"
#import "utilities.h"
#import "GBPathImageView.h"

//#import "SDWebImage/UIImageView+WebCache.h"


@interface StoryCommentCellTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel * message;
@property(nonatomic,strong)IBOutlet UIImageView * profileImageView;
@property(nonatomic,strong)IBOutlet UILabel * userName;
@property(nonatomic,strong)IBOutlet UILabel * date;

-(void)initWithComment:(Comment*)comment;
@end