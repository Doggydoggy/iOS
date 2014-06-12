//
//  ExampleViewController.m
//  MHVideoPhotoGallery
//
//  Created by Mario Hahn on 30.09.13.
//  Copyright (c) 2013 Mario Hahn. All rights reserved.
//

#import "ExampleViewControllerCollectionViewInTableView.h"
#import "MHOverViewController.h"
#import "UIImage+StackBlur.h"

@implementation UITabBarController (autoRotate)
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
- (NSUInteger)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}
@end


@implementation UINavigationController (autoRotate)

- (BOOL)shouldAutorotate {
    return [self.viewControllers.lastObject shouldAutorotate];
}
- (NSUInteger)supportedInterfaceOrientations {
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

@end



@interface ExampleViewControllerCollectionViewInTableView ()
@property(nonatomic,strong) NSArray *galleryDataSource;
@end

@implementation ExampleViewControllerCollectionViewInTableView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //setup BGImage and BluredBGImage
    self.BGImage = [UIImage imageNamed:@"嬛嬛2.jpg"];
    self.BluredBGImage =[[UIImage imageNamed:@"嬛嬛2.jpg"] stackBlur:130/2];
    UIImageView * navigationBGImageView = [[UIImageView alloc] initWithFrame:self.navigationController.view.frame];
    [navigationBGImageView setImage:self.BluredBGImage];
    [self.navigationController.navigationController.navigationBar setHidden:YES];
    [self.navigationController.view insertSubview:navigationBGImageView atIndex:0];
    self.backGroundImageView.image = self.BluredBGImage;
    BlurSwitchoff=YES;
    
    
    self.title = @"TimeLine";
    //self.navigationController.navigationBar.hidden = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    
    UINavigationBar* navigationBar = self.navigationController.navigationBar;
    UIColor *navigationBarColor =[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:0.36f];
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
    
    //self.navigationController.navigationBar.shadowImage = [UIImage new];
    //self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; //字体颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    
    MHGalleryItem *youtube = [[MHGalleryItem alloc]initWithURL:@"http://www.youtube.com/watch?v=YSdJtNen-EA"
                                                   galleryType:MHGalleryTypeVideo];
    
    MHGalleryItem *vimeo0 = [[MHGalleryItem alloc]initWithURL:@"http://vimeo.com/35515926"
                                                  galleryType:MHGalleryTypeVideo];
    MHGalleryItem *vimeo1 = [[MHGalleryItem alloc]initWithURL:@"http://vimeo.com/50006726"
                                                  galleryType:MHGalleryTypeVideo];
    MHGalleryItem *vimeo3 = [[MHGalleryItem alloc]initWithURL:@"http://vimeo.com/66841007"
                                                  galleryType:MHGalleryTypeVideo];
   
    MHGalleryItem *landschaft = [[MHGalleryItem alloc]initWithURL:@"http://alles-bilder.de/landschaften/HD%20Landschaftsbilder%20(47).jpg"
                                                 galleryType:MHGalleryTypeImage];
    
    MHGalleryItem *landschaft1 = [[MHGalleryItem alloc]initWithURL:@"http://de.flash-screen.com/free-wallpaper/bezaubernde-landschaftsabbildung-hd/hd-bezaubernde-landschaftsder-tapete,1920x1200,56420.jpg"
                                                      galleryType:MHGalleryTypeImage];
    
    MHGalleryItem *landschaft2 = [[MHGalleryItem alloc]initWithURL:@"http://alles-bilder.de/landschaften/HD%20Landschaftsbilder%20(64).jpg"
                                                       galleryType:MHGalleryTypeImage];
    
    MHGalleryItem *landschaft3 = [[MHGalleryItem alloc]initWithURL:@"http://www.dirks-computerseite.de/wp-content/uploads/2013/06/purpleworld1.jpg"
                                                       galleryType:MHGalleryTypeImage];
    
    MHGalleryItem *landschaft4 = [[MHGalleryItem alloc]initWithURL:@"http://alles-bilder.de/landschaften/HD%20Landschaftsbilder%20(42).jpg"
                                                       galleryType:MHGalleryTypeImage];
    
    MHGalleryItem *landschaft5 = [[MHGalleryItem alloc]initWithURL:@"http://woxx.de/wp-content/uploads/sites/3/2013/02/8X2cWV3.jpg"
                                                       galleryType:MHGalleryTypeImage];
    
    MHGalleryItem *landschaft6 = [[MHGalleryItem alloc]initWithURL:@"http://kwerfeldein.de/wp-content/uploads/2012/05/Sharpened-version.jpg"
                                                       galleryType:MHGalleryTypeImage];
    
    MHGalleryItem *landschaft7 = [[MHGalleryItem alloc]initWithURL:@"http://eswalls.com/wp-content/uploads/2014/01/sunset-glow-trees-beautiful-scenery.jpg"
                                                       galleryType:MHGalleryTypeImage];
    
    MHGalleryItem *landschaft8 = [[MHGalleryItem alloc]initWithURL:@"http://eswalls.com/wp-content/uploads/2014/01/beautiful_scenery_wallpaper_The_Eiffel_Tower_at_night_.jpg"
                                                       galleryType:MHGalleryTypeImage];
    
    MHGalleryItem *landschaft9 = [[MHGalleryItem alloc]initWithURL:@"http://p1.pichost.me/i/40/1638707.jpg"
                                                       galleryType:MHGalleryTypeImage];
    
    MHGalleryItem *landschaft10 = [[MHGalleryItem alloc]initWithURL:@"http://4.bp.blogspot.com/-8O0ZkAgb6Bo/Ulf_80tUN6I/AAAAAAAAH34/I1L2lKjzE9M/s1600/Beautiful-Scenery-Wallpapers.jpg"
                                                       galleryType:MHGalleryTypeImage];

    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:@"Awesome!!\nOr isn't it?"];
    
    [string setAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} range:NSMakeRange(0, string.length)];
    [string setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:17]} range:NSMakeRange(0, 9)];
    
    landschaft10.attributedString = string;
    
    
    self.galleryDataSource = @[@[landschaft10,landschaft8,landschaft7,landschaft9,landschaft6,landschaft5,landschaft4,landschaft3,landschaft2,landschaft,landschaft1,landschaft10,landschaft8,landschaft7,landschaft9,landschaft6,landschaft5,landschaft4,landschaft3,landschaft2,landschaft,landschaft1,landschaft10,landschaft8,landschaft7,landschaft9,landschaft6,landschaft5,landschaft4,landschaft3,landschaft2,landschaft,landschaft1],
                               @[vimeo3,youtube,vimeo0,vimeo1,landschaft9,landschaft6,landschaft5,landschaft4,landschaft3,landschaft2,landschaft,landschaft1],
                               @[landschaft9,landschaft6,landschaft5,landschaft4,landschaft3,landschaft2,landschaft,landschaft1],
                               @[landschaft9,landschaft6,landschaft5,landschaft4,landschaft3,landschaft2,landschaft,landschaft1],
                               @[landschaft9,landschaft6,landschaft5,landschaft4,landschaft3,landschaft2,landschaft,landschaft1],
                               @[landschaft9,landschaft6,landschaft5,landschaft4,landschaft3,landschaft2,landschaft,landschaft1],
                               @[landschaft9,landschaft6,landschaft5,landschaft4,landschaft3,landschaft2,landschaft,landschaft1],
                               @[landschaft9,landschaft6,landschaft5,landschaft4,landschaft3,landschaft2,landschaft,landschaft1]
                               ];
    //self.tableView.backgroundColor = [UIColor colorWithRed:0.83 green:0.84 blue:0.86 alpha:1];
    _cellHeightArray = [[NSMutableArray alloc] init];
    [_cellHeightArray addObject:[NSNumber numberWithFloat:430.0]];
    [_cellHeightArray addObject:[NSNumber numberWithFloat:75.0]];
    
    [self.tableView setContentOffset:CGPointMake(0,-1000) animated:NO];

    // first two data
    _cellStoriesCacheArray = [[NSMutableArray alloc]init];
    NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"InvisibleCellTableViewCell" owner:self options:nil];
    InvisibleCellTableViewCell * cell1 = (InvisibleCellTableViewCell *)[nibArray objectAtIndex:0];
    [cell1 initCell];
    [_cellStoriesCacheArray addObject:cell1];
    

    nibArray = [[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:self options:nil];
    MenuCell *cell2 = (MenuCell *)[nibArray objectAtIndex:0];
    cell2.menuCellDelegate = self;
    [_cellStoriesCacheArray addObject:cell2];

    // init mock data
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DoggyStoriesSample" ofType:@"json"];
    NSMutableArray * StoryArray =[utilities GetStoriesFromFiles:filePath];
    [self addNewStoryCellsWithStories:StoryArray];
}


-(void)addNewStoryCellsWithStories:(NSArray*)storyArray
{
    int index = 0;
    for (Story* story in storyArray) {
        StoryCell *cell = (StoryCell *)[self.tableView dequeueReusableCellWithIdentifier:@"StoryCell"];
        if(cell==nil)
            cell = [[StoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StoryCell"];
        
        [_cellHeightArray addObject:[NSNumber numberWithFloat:cell.commentViewTotoalHeight+STORYCELLINITSIZE]];
        cell.backView.layer.masksToBounds = NO;
        cell.backView.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.backView.layer.borderWidth = 1.0f;
        cell.backView.layer.shadowOffset = CGSizeMake(0, 0);
        cell.backView.layer.shadowRadius = 0.0;
        cell.backView.layer.shadowColor = [UIColor clearColor].CGColor;
        cell.backView.layer.shadowOpacity = 1.0;
        cell.backView.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.backView.bounds].CGPath;
        cell.backView.layer.cornerRadius = 2.0;
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 25, 0, 25);
        layout.itemSize = CGSizeMake(270, 225);
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing = 15;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        cell.collectionView.collectionViewLayout = layout;
        
        [cell.collectionView registerClass:[MHGalleryOverViewCell class] forCellWithReuseIdentifier:@"MHGalleryOverViewCell"];
        
        cell.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        
        [cell.collectionView setShowsHorizontalScrollIndicator:NO];
        [cell.collectionView setDelegate:self];
        [cell.collectionView setDataSource:self];
        [cell.collectionView setTag:index];
        [cell.collectionView reloadData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell initStoryCellWithStory:story];
        [_cellStoriesCacheArray addObject:cell];
        index++;
    }
    [self.tableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_cellStoriesCacheArray count];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.galleryDataSource[collectionView.tag] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //First table cell is invisible
    if (indexPath.section==0&&indexPath.row==0)
    {
       return 430;
    }else if(indexPath.section==1&&indexPath.row==0)
    {
        return 75;
    }else
    {
        if([_cellHeightArray objectAtIndex:indexPath.row]==nil)
            return 349;
        else
        {
            NSNumber * height = [_cellHeightArray objectAtIndex:indexPath.row];
            return [height floatValue];
        }
    }
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [_cellStoriesCacheArray objectAtIndex:indexPath.section];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell =nil;
    NSString *cellIdentifier = @"MHGalleryOverViewCell";
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSIndexPath *indexPathNew = [NSIndexPath indexPathForRow:indexPath.row inSection:collectionView.tag];
    [self makeOverViewDetailCell:(MHGalleryOverViewCell*)cell atIndexPath:indexPathNew];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [MHGallerySharedManager sharedManager].ivForPresentingAndDismissingMHGallery = [(MHGalleryOverViewCell*)[collectionView cellForItemAtIndexPath:indexPath] iv];
    
    NSArray *galleryData = self.galleryDataSource[collectionView.tag];
    
    [self presentMHGalleryWithItems:galleryData
                           forIndex:indexPath.row
                     finishCallback:^(UINavigationController *galleryNavMH, NSInteger pageIndex, UIImage *image) {
                         
                         NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:pageIndex inSection:0];
                         CGRect cellFrame  = [[collectionView collectionViewLayout] layoutAttributesForItemAtIndexPath:newIndexPath].frame;
                         [collectionView scrollRectToVisible:cellFrame
                                                    animated:NO];
                         
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [collectionView reloadItemsAtIndexPaths:@[newIndexPath]];
                             [collectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                             
                             MHGalleryOverViewCell *cell = (MHGalleryOverViewCell*)[collectionView cellForItemAtIndexPath:newIndexPath];
                             [MHGallerySharedManager sharedManager].ivForPresentingAndDismissingMHGallery = cell.iv;
                             
                             [galleryNavMH dismissViewControllerAnimated:YES completion:^{
                                 MPMoviePlayerController *player = [MHGallerySharedManager sharedManager].interactiveDismissMHGallery.moviePlayer;
                                 player.controlStyle = MPMovieControlStyleEmbedded;
                                 player.view.frame = cell.bounds;
                                 player.scalingMode = MPMovieScalingModeAspectFill;
                                 [cell.contentView addSubview:player.view];
                             }];
                         });
                         
                     } customAnimationFromImage:YES];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(BOOL)shouldAutorotate{
    return YES;
}


-(void)makeOverViewDetailCell:(MHGalleryOverViewCell*)cell atIndexPath:(NSIndexPath*)indexPath{
    MHGalleryItem *item = self.galleryDataSource[indexPath.section][indexPath.row];
    [cell.iv setContentMode:UIViewContentModeScaleAspectFill];
    
    cell.iv.layer.shadowOffset = CGSizeMake(0, 0);
    cell.iv.layer.shadowRadius = 1.0;
    cell.iv.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.iv.layer.shadowOpacity = 0.5;
    cell.iv.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.iv.bounds].CGPath;
    cell.iv.layer.cornerRadius = 2.0;
    
    cell.iv.image = nil;
    if (item.galleryType == MHGalleryTypeImage) {
        [cell.iv setImageWithURL:[NSURL URLWithString:item.urlString]];
    }else{
        [[MHGallerySharedManager sharedManager] startDownloadingThumbImage:item.urlString
                                                              successBlock:^(UIImage *image, NSUInteger videoDuration, NSError *error,NSString *newURL) {
                                                                  cell.iv.image = image;
                                                    }];
    }
}


-(void)TurnOnBlur
{
    if(BlurSwitchoff==YES)
    {
        [UIView transitionWithView:self.backGroundImageView duration:1  options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.backGroundImageView.image=self.BluredBGImage;
            
        } completion:nil
         ];
    }
    BlurSwitchoff = NO;
    
}

-(void)TurnOffBlur
{
    //[self SetBackGroundImage];
    
    if(BlurSwitchoff==NO)
    {
        [UIView transitionWithView:self.backGroundImageView duration:1  options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.backGroundImageView.image=self.BGImage;
            
        } completion:nil
         ];
    }
    BlurSwitchoff = YES;
    
}

#pragma mark - uiscrollerview delegate methond
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    float offset = scrollView.contentOffset.y;
    //if(offset > 20.0)
        //[self TurnOnBlur];
    //else
       // [self TurnOffBlur];
}



- (void)newStoryButtonClicked
{
    //WriteNewStoryViewController *WNSController =[[WriteNewStoryViewController alloc] init];
    //[self.navigationController pushViewController:WNSController animated:YES];
    [self performSegueWithIdentifier:@"MainToNewStory" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MainToNewStory"])
    {
        WriteNewStoryViewController *vc = [segue destinationViewController];
        //vc.dataThatINeedFromTheFirstViewController = self.theDataINeedToPass;
    }
}

- (void)settingsButtonClicked
{

}

- (void)timeBackButtonClicked
{
    
}


- (IBAction)showMenu
{
    [self.frostedViewController presentMenuViewController];
}



@end
