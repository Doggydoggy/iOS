//
//  StoryViewCell.h
//  PetFlickerWithStoryBoard
//
//  Created by VincentHe on 6/7/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h" 
#import "NSObject_GlobalVariables.h"
#import "StoryCommentCellTableViewCell.h"
#import "Story.h"

@interface StoryCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong,nonatomic) IBOutlet UITableView * commontView;
@property (strong,nonatomic) NSMutableArray * candidateDataArray;
@property (strong,nonatomic) NSString * OriginalString;
@property (strong,nonatomic) NSMutableArray * dataArray;
@property (strong,nonatomic) NSMutableArray * heightArray;
@property (nonatomic)float commentViewTotoalHeight;
@property (nonatomic,strong) Story * story;

-(void)mockTableData;
-(void)initStoryCellWithStory:(Story*)story;

@end
