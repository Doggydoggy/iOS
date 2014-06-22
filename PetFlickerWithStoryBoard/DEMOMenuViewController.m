//
//  DEMOMenuViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "DEMOHomeViewController.h"
#import "DEMOSecondViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "Colours.h"

@interface DEMOMenuViewController ()

@end

@implementation DEMOMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:26.0f/255.0f green:25.0f/255.0f blue:25.0f/255.0f alpha:0.15];//[UIColor robinEggColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"avatar.jpg"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text = [utilities ReadProfilePlist:@"nickName"];
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];//[UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
    
    // title data set
    NSNumber * numberOfMessages = [NSNumber numberWithInt:3];
    functionTitleArray = @[@[@"whiteStar.png",@"Feeds",[NSNumber numberWithInt:0],[UIColor pastelBlueColor]],@[@"read_message",@"Messages",numberOfMessages,[UIColor peachColor]], @[@"conference.png",@"Social",[NSNumber numberWithInt:0],[UIColor coralColor]]];
    
    
    dogsArray = [[NSMutableArray alloc] initWithArray:@[@[@"AddCell"]]];
    NSMutableArray * dogsData = [utilities GetPetsFromInfoList];
    for (Pet * pet in dogsData) {
        [dogsArray  insertObject:@[@"DogCell",pet] atIndex:0];
    }
    
    
    // pets array
    
    
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];//[UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    if (sectionIndex == 0)
    {
        label.text = @"Have much funs!";
    }
    else
    {
        label.text = @"My Dogs";
    }

    
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UINavigationController *navigationController = (UINavigationController *)self.frostedViewController.contentViewController;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        DEMOHomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedViewController"];
        navigationController.viewControllers = @[homeViewController];
    }else if (indexPath.section==1)
    {
        NSArray * infoArry = [dogsArray objectAtIndex:indexPath.row];
        if (![[infoArry objectAtIndex:0] isEqualToString:@"AddCell"]) {
            ExampleViewControllerCollectionViewInTableView * dogTimeline =[self.storyboard instantiateViewControllerWithIdentifier:@"dogTimeLine"];
            dogTimeline.dogInfo = [infoArry objectAtIndex:1];
            navigationController.viewControllers = @[dogTimeline];
        }else
        {
            //createNewPet
            AddNewDogyViewController *  addNewDogView = [self.storyboard instantiateViewControllerWithIdentifier:@"createNewPet"];
            navigationController.viewControllers = @[addNewDogView];
        }
        
    }
    else {
        DEMOSecondViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"secondController"];
        navigationController.viewControllers = @[secondViewController];
    }
    
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (sectionIndex==0) {
        return [functionTitleArray count];
    }else return [dogsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSArray * titleArray = [functionTitleArray objectAtIndex:indexPath.row];
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"SliderTableViewCell" owner:self options:nil];
        SliderTableViewCell * cell = (SliderTableViewCell *)[nibArray objectAtIndex:0];
        cell.iconView.image = [UIImage imageNamed:[titleArray objectAtIndex:0]];
        cell.titleLabel.text  = [titleArray objectAtIndex:1];
        cell.attributeLabel.text = [((NSNumber*)[titleArray objectAtIndex:2]) intValue]>0? [NSString stringWithFormat:@"%@",[titleArray objectAtIndex:2]]:@"";
        [cell.contentView setBackgroundColor:[titleArray objectAtIndex:3]];
        cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
        return cell;
    } else {
        NSArray * infoArray = [dogsArray objectAtIndex:indexPath.row];
        if ([[infoArray objectAtIndex:0] isEqualToString:@"AddCell"]) {
            NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"AddDogTableViewCell" owner:self options:nil];
            AddDogTableViewCell * cell = (AddDogTableViewCell *)[nibArray objectAtIndex:0];
            cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
            return cell;
        }else
        {
            NSArray * titleArray = [dogsArray objectAtIndex:indexPath.row];
            NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"SliderTableViewCell" owner:self options:nil];
            SliderTableViewCell * cell = (SliderTableViewCell *)[nibArray objectAtIndex:0];
            cell.iconView.image = [UIImage imageNamed:@"paw.png"];
            Pet* pet =[titleArray objectAtIndex:1];
            cell.titleLabel.text  = pet.pet_name;
            cell.attributeLabel.text = @"";
            [cell.contentView setBackgroundColor:[UIColor warmGrayColor]];
            cell.separatorInset = UIEdgeInsetsMake(0.f, 0.f, 0.f, cell.bounds.size.width);
            return cell;
        }
    }
    
    return cell;
}
 
@end
