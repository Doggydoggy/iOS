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

-(void)mockTableData
{
    _dataArray = [[NSMutableArray alloc] init];
    _heightArray = [[NSMutableArray alloc] init];
    Comment * selfMessage = [[Comment alloc] initWithName:@"Vincent" Message:@"connection"
                                          ProfileImageURL:@"http://Tetsurl.com" Date:[NSDate date]];
    NSArray * mockDataSource  = @[selfMessage,selfMessage,selfMessage,selfMessage,selfMessage,selfMessage];
    for (Comment * comment in mockDataSource) {
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
    
    //[_dataArray addObject:selfMessage];
    //[_dataArray addObject:selfMessage];
    //[_dataArray addObject:selfMessage];
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
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    StoryCommentCellTableViewCell *cell = (StoryCommentCellTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibArray=[[NSBundle mainBundle] loadNibNamed:@"StoryCommentCellTableViewCell" owner:self options:nil];
        cell = (StoryCommentCellTableViewCell *)[nibArray objectAtIndex:0];
        [cell initWithComment:[_dataArray objectAtIndex:indexPath.row]];
        [cell setNeedsDisplay];
    }
    return cell;
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
