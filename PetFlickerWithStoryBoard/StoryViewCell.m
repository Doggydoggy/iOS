//
//  StoryViewCell.m
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/7/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "StoryViewCell.h"


@implementation StoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initStoryCellWithStory:(Story*)story
{
    _dataArray = [[NSMutableArray alloc] init];
    _heightArray = [[NSMutableArray alloc] init];
    NSMutableArray * commentsArray = [[NSMutableArray alloc] initWithArray:story.comments];
    //TODO: to get information from plist
    Comment * firstMyMessageComment = [[Comment alloc] initWithName:@"Vincent" Message:story.message ProfileImageURL:@"" Date:story.posted sid:nil qid:nil];
    [commentsArray insertObject:firstMyMessageComment atIndex:0];
    BOOL hasComment =[commentsArray count]>1;
    if (hasComment) {
        _commentViewTotoalHeight+=STORYCOMMENTSEEMORECOMMENTSVIEWHEIGHT;
    }
    for (Comment * comment in commentsArray) {
        float cellheight =[utilities getLabelHeightByText:comment.message];
        if ((_commentViewTotoalHeight+cellheight)<STORYCOMMENTVIEWMAXHEIGHT) {
            [_heightArray addObject:[NSNumber numberWithFloat:cellheight]];
            [_dataArray addObject:comment];
            _commentViewTotoalHeight +=cellheight;
        }else
        {
            break;
        }
    }
    
    if (hasComment) {
        [_heightArray addObject:[NSNumber numberWithFloat:44.0]];
    }
    
    self.commontView.frame = CGRectMake(_commontView.frame.origin.x,_commontView.frame.origin.y,_commontView.frame.size.width,_commentViewTotoalHeight);
    self.commontView.backgroundColor = [UIColor clearColor];
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [_dataArray count]>1?[_dataArray count]+1:[_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    if([_dataArray count]>=(indexPath.row+1))
    {
        StoryCommentCellTableViewCell *cell = (StoryCommentCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nibArray=[[NSBundle mainBundle] loadNibNamed:@"StoryCommentCellTableViewCell" owner:self options:nil];
            cell = (StoryCommentCellTableViewCell *)[nibArray objectAtIndex:0];
            [cell initWithComment:[_dataArray objectAtIndex:indexPath.row]];
            [cell setNeedsDisplay];
        }
        return cell;
    }else
    {
        NSArray *nibArray=[[NSBundle mainBundle] loadNibNamed:@"SeeMoreCell" owner:self options:nil];
        SeeMoreCell *cell = (SeeMoreCell *)[nibArray objectAtIndex:0];
        return cell;
    }

}


#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber * height =[_heightArray objectAtIndex:indexPath.row];
    return [height floatValue];
    
    /*
    Comment * currentComment = [_dataArray objectAtIndex:indexPath.row];
    NSString *text = currentComment.message;
    float cellheight =[utilities getLabelHeightByText:text];
    if ([_dataArray count]!=1) {
        self.commontView.frame = CGRectMake(_commontView.frame.origin.x,_commontView.frame.origin.y,_commontView.frame.size.width,cellheight);
    }
    _commentViewTotoalHeight+=cellheight;
    return cellheight;
     
     */
}


- (void)tableViewWillFinishLoading:(UITableView *)tableView
{
    NSLog(@"finished loading height=%f",_commentViewTotoalHeight);
}
@end
