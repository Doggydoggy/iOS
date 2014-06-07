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
    Comment * selfMessage = [[Comment alloc] initWithName:@"Vincent" Message:@"connection with the File’s Owner. We are doing this because we changed the File’s Owner class to our UITableViewController subclass. So our cell’s outlet in the tableview controller header will be connected to the custom cell that we created"
                                          ProfileImageURL:@"http://Tetsurl.com" Date:[NSDate date]];
    [_dataArray addObject:selfMessage];
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
    Comment * currentComment = [_dataArray objectAtIndex:indexPath.row];
    NSString *text = currentComment.message;
    float cellheight =[utilities getLabelHeightByText:text];
    if ([_dataArray count]==1&&cellheight>COMMENTCELLINITHEIGHT) {
        self.commontView.frame = CGRectMake(_commontView.frame.origin.x,_commontView.frame.origin.y,_commontView.frame.size.width,cellheight);
    }
    return cellheight;
}

@end
