//
//  StoryCommentCellTableViewCell.m
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/7/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "StoryCommentCellTableViewCell.h"

@implementation StoryCommentCellTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithComment:(Comment*)comment
{
    _message.text = comment.message;
    _userName.text = comment.name;
    _message.frame = CGRectMake(_message.frame.origin.x, _message.frame.origin.y, _message.frame.size.width,[utilities getLabelHeightByText:comment.message]);
    
    //TODO: get date from comment
    NSDate *date = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString  = [df stringFromDate:date];
    _date.text =dateString;
    //TODO: get image from url
    //[_profileImageView setImageWithURL:<#(NSURL *)#>];
    
}



@end
