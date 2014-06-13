//
//  ViewCommentsViewController.m
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/12/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "ViewCommentsViewController.h"

@interface ViewCommentsViewController ()

@end

@implementation ViewCommentsViewController

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
    _dataArray = [[NSMutableArray alloc] init];
    _heightArray = [[NSMutableArray alloc] init];
    _CommentTableView.backgroundColor = [UIColor clearColor];
    NSMutableArray * commentsArray = [[NSMutableArray alloc] initWithArray:_story.comments];
    //TODO: to get information from plist
    Comment * firstMyMessageComment = [[Comment alloc] initWithName:@"Vincent" Message:_story.message ProfileImageURL:@"" Date:_story.posted sid:nil qid:nil];
    [commentsArray insertObject:firstMyMessageComment atIndex:0];
    for (Comment * comment in commentsArray) {
        float cellheight =[utilities getLabelHeightByText:comment.message];
        totalCellHeight+=cellheight;
        [_heightArray addObject:[NSNumber numberWithFloat:cellheight]];
        [_dataArray addObject:comment];
    }
    totalCellHeight+=STORYCOMMENTSEEMORECOMMENTSVIEWHEIGHT;
    
    _CommentTableView.frame = CGRectMake(_CommentTableView.frame.origin.x, _CommentTableView.frame.origin.y, _CommentTableView.frame.size.width, totalCellHeight);
    
    // Do any additional setup after loading the view.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return [_dataArray count]+1;
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:16.0];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        cell.textLabel.text = @"                            Refresh";
        cell.backgroundColor = [UIColor clearColor];
        cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
        return cell;
    }
    
}


#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([_dataArray count]>=(indexPath.row+1))
    {
        NSNumber * height =[_heightArray objectAtIndex:indexPath.row];
        return [height floatValue];
    }else return 25.0;

    
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







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
