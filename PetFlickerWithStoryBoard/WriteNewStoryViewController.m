//
//  WriteNewStoryViewController.m
//  DearYou
//
//  Created by VincentHe on 1/13/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import "WriteNewStoryViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "utilities.h"


@interface WriteNewStoryViewController ()

@end

@implementation WriteNewStoryViewController

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
    
    self.StoryBodyView.layer.borderWidth = 0.2;
    self.StoryBodyView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.StoryBodyView.layer.cornerRadius = 2;
    self.StoryBodyView.layer.masksToBounds = YES;
    self.title = @"New Story";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor]; //字体颜色
    [self.navigationController.navigationBar setUserInteractionEnabled:YES];

    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
    //                                                                          style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    
    self.StoryBodyView.text = @"Say something...";
    
    _photoButtons = [[NSMutableArray alloc] init];
    
    cursor = PhotoStartingX;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, 100, 1000);
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn setTitle:@"Hello, world!" forState:UIControlStateNormal];

    
    _photoFiles = [[NSMutableArray alloc] initWithObjects:@"Add", nil];
    _photoDict = [[NSMutableDictionary alloc] init];
    
    [self UpdateBackgroundView];
    
    [[CLLocationManager sharedManager] updateLocationWithDistanceFilter:1.0
                                                     andDesiredAccuracy:kCLLocationAccuracyBest
                                                     didUpdateLocations:^(NSArray *locations){
                                                         CLLocation * location = locations[0];
                                                         NSLog(@"locations : %f,%f",location.coordinate.latitude,location.coordinate.longitude);
                                                         self.lat =[NSString stringWithFormat:@"%f",location.coordinate.latitude];
                                                         self.longt=[NSString stringWithFormat:@"%f",location.coordinate.longitude];
                                                         NSDictionary * dict =[utilities GetDetailAddressInfoFromLat:self.lat andLongt:[NSString stringWithFormat:@"%f",location.coordinate.longitude]];
                                                         self.locationDescription  = [NSString stringWithFormat:@"%@,%@",[dict objectForKey:@"City"],[dict objectForKey:@"Neighborhood"]];
                                                         self.locationLabel.text = self.locationDescription;
                                                     }
                                                       didFailWithError:^(NSError *error){
                                                           NSLog(@"error : %@",error.localizedDescription);
                                                       }];
    
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)back:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(IBAction)onOrOFF:(id)sender
{
    if(self.locationSwitch.on) {
        // lights on
    }
    else {
        self.locationView.hidden = YES;
    }
}


-(IBAction)send:(id)sender
{
    
    NSString * message = _StoryBodyView.text;

    int intQid =((NSString*)[utilities ReadProfilePlist:@"qid"]).intValue;
    NSNumber * qid = [NSNumber numberWithInteger:intQid];
    NSString * userName = [utilities ReadProfilePlist:@"username"];
    // TODO: pics in a array
    NSDictionary * dict = @{[NSNumber numberWithInt:StoryParam_message]:message,[NSNumber numberWithInt:StoryParam_pid]:_pid,[NSNumber numberWithInt:StoryParam_username]:userName,[NSNumber numberWithInt:StoryParam_lat]:_lat==nil?[NSNumber numberWithFloat:0.0]:_lat,[NSNumber numberWithInt:StoryParam_longt]:_longt==nil?[NSNumber numberWithFloat:0.0]:_longt};
    [utilities CreateStory:qid Message:message OtherParms:dict];
    [self.navigationController popToRootViewControllerAnimated:YES];
    //_pid
    
    /*
    if ([self.StoryBodyView.text isEqualToString:@"Say something..."]||[self.StoryBodyView.text isEqualToString:@""]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please type some text" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    NSMutableArray * photoArray = [[NSMutableArray alloc] init];
    // TODO: 加活动指示器
    
    [MMProgressHUD setDisplayStyle:MMProgressHUDDisplayStyleBordered];
    [MMProgressHUD showWithTitle:@"Just a second" status:@"loading..."];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if (_photoFiles.count>1) {
            for (int i =0; i<_photoFiles.count-1; i++) {
                UIImage * image = [_photoDict objectForKey:[_photoFiles objectAtIndex:i]];
                NSString * filename = [_photoFiles objectAtIndex:i];
                [Utilities UploadPhotoToPhotoStoryGrage:image withImageName:filename];
                NSDictionary * photo = @{@"url":[NSString stringWithFormat:@"%@%@.png",S3StroyPhotoURL,filename],@"PhotoName":[NSString stringWithFormat:@"%@.png",filename]};
                [photoArray addObject:photo];
            }
        }
        NSString * UUID = [Utilities createUUID];
        NSTimeInterval  time =[[NSDate date] timeIntervalSince1970];
        if([Utilities addStoryToTable:[Utilities ReadProfilePlist:@"DYID"] To:[Utilities ReadProfilePlist:@"HerDYID"] StoryBody:self.StoryBodyView.text RelationShipID:[Utilities ReadProfilePlist:@"RelationID"] UUID:UUID Time:time PhotoInfo:photoArray VoicePath:nil VoiceURL:nil locationLat:self.locationSwitch.on?self.lat:nil locationLnt:self.locationSwitch.on?self.longt:nil locationDescription:self.locationSwitch.on?self.locationDescription:nil])
        {
            NSDictionary * GeoInfo = self.locationSwitch.on?@{@"locationLat": self.lat,@"locationLong": self.longt,@"locationDescription": self.locationDescription}:nil;
            [Utilities SendMessage:self.StoryBodyView.text  andPhotos:photoArray andUUID:UUID andVoiceURL:nil andGeoInfo:GeoInfo andTime:time];
            AppDelegate *thedelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            thedelegate.LocalStoryUpdated = YES;
        }
        [MMProgressHUD dismiss];
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
     */
}

-(void)UpdateBackgroundView
{
    int rows = floor(_photoFiles.count/4)+(_photoFiles.count%4==0?0:1);
    self.backgroundView.frame = CGRectMake(self.backgroundView.frame.origin.x, self.backgroundView.frame.origin.y, self.backgroundView.frame.size.width,(PhotoBackgroundHeight)*rows);
    int x = PhotoStartingX;
    int y = PhotoStartingY;
    int index = 1;
    int count = 0;
    for(NSString * photoFile in _photoFiles)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(x, y, PhotoButtonSize, PhotoButtonSize);
        //[btn setBackgroundColor:[UIColor blackColor]];
        //[btn setTitle:@"Hello, world!" forState:UIControlStateNormal];
        if ([photoFile isEqualToString:@"Add"]) {
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setBackgroundImage:[UIImage imageNamed:@"addphoto"] forState:UIControlStateNormal];
            [btn addTarget:self
                       action:@selector(addNewButton)
             forControlEvents:UIControlEventTouchUpInside];
        }else
        {
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setBackgroundImage:[_photoDict objectForKey:photoFile] forState:UIControlStateNormal];
            [btn setContentMode:UIViewContentModeScaleAspectFill];
            [btn addTarget:self
                    action:@selector(addClickOnPhotoButton:)
          forControlEvents:UIControlEventTouchUpInside];
            btn.tag = count;
        }
        if (index<4) {
            [self.backgroundView addSubview:btn];
            x+=PhotoMargin+PhotoButtonSize;
            index++;
        }else
        {
            index=1;
            y+=PhotoButtonSize+PhotoStartingY;
            x=PhotoStartingX;
            [self.backgroundView addSubview:btn];
        }
        count++;
    }
    _locationView.frame = CGRectMake(self.backgroundView.frame.origin.x, self.backgroundView.frame.origin.y+self.backgroundView.frame.size.height+8, self.locationView.frame.size.width,self.locationView.frame.size.height);
    
}

-(void)addClickOnPhotoButton:(UIButton*)SenderButton
{
    /*
    NSString * filename =[_photoFiles objectAtIndex:SenderButton.tag];
    UIImage * buttonImage = [_photoDict objectForKey:filename];
    TGRImageViewController *viewController = [[TGRImageViewController alloc] initWithImage:buttonImage];
    viewController.transitioningDelegate = self;
    [self presentViewController:viewController animated:YES completion:nil];
     */
}

-(void)addNewButton
{
    NSString *other1 = @"Camera";
    NSString *other2 = @"Photo Library";

    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Pick your photo from:"
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:other1,other2, nil];
    [actionSheet showInView:self.view];

}

-(void)addOneMorePhotoButtonWithFileName:(NSString*)FileName
{
    if (_photoFiles.count<16) {
        [_photoFiles insertObject:FileName atIndex:0];
        [self UpdateBackgroundView];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if  ([buttonTitle isEqualToString:@"Camera"]) {
        [self photoFromCamera];
    }
    if ([buttonTitle isEqualToString:@"Photo Library"]) {
        [self photoFromPhotoAlbum];
    }
}

-(void)photoFromCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    //picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    
}
-(void)photoFromPhotoAlbum
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark -
#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    /*
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString * imageFileName = [NSString stringWithFormat:@"%@-%@",[Utilities ReadProfilePlist:@"RelationID"],[Utilities createUUID]];
    [self.photoDict setObject:image forKey:imageFileName];
    [self addOneMorePhotoButtonWithFileName:imageFileName];

    //[self.photoArray insertObject:image atIndex:0];
    //AppDelegate *thedelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //[thedelegate startIndicator:@"Loading"];
    //[Utilities StartUploadToPhotoGrage:image withComment:nil];
    [picker dismissViewControllerAnimated:YES completion:nil];
    //[thedelegate StopIndicator];
     */
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
#pragma mark TextView Delegate Methods
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Say something..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Say something...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
