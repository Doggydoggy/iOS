//
//  PetFlickerWithStoryBoardTests.m
//  PetFlickerWithStoryBoardTests
//
//  Created by VincentHe on 4/10/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "utilities.h"
#import "NSObject_GlobalVariables.h"

@interface PetFlickerWithStoryBoardTests : XCTestCase

@end

@implementation PetFlickerWithStoryBoardTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

-(void)testUtilDB
{
    [utilities CreateLocalDBAndTable];
    NSAssert(true, @"");
}

-(void)testReigisterNewUser
{
    BOOL rfalse = [utilities RegisterNewUser:@"yhfy2006" andPassword:@"123456"];
    NSAssert(NO ==rfalse, @"");
}

-(void)testUserlogin
{
    NSDictionary* rfalse = [utilities LoginUser:@"test1" andPassword:@"test1"];
    NSAssert(rfalse !=nil, @"");
}


-(void)testCreatePlist
{
    NSAssert([utilities SetupUserPlist]==true, @"");
}

-(void)testWritingToPlist
{
    NSArray * array = @[@"a",@"b"];
    NSAssert([utilities WriteToProfilePlist:@"Test" Value:array]==true, @"");
}

-(void)testGetUserInfo
{
    NSDictionary* rfalse =[utilities GetUserInfo];
    NSAssert(true==true, @"");
}

-(void)testStaticArray
{
    NSAssert([@"username" isEqualToString:[USERUPDATPARM objectAtIndex:0]], @"");
}

-(void)testUpdateUserInfo
{
    NSAssert([utilities UpdateOneUserAttribute:UserParm_nickName Value:@"male"]==YES, @"");
}

-(void)testUpdateMutiUserInfo
{
    NSDictionary * dict = @{[NSNumber numberWithInt: UserParm_firstName]: @"Changchen",[NSNumber numberWithInt: UserParm_age]:@"2",[NSNumber numberWithInt: UserParm_pet_name]:@"Leona"};
    NSAssert([utilities UpdateUserAttributes:dict]==YES, @"");
}

-(void)testFollowingAndUnFollowingOthers
{
    NSAssert([utilities Follow:[NSNumber numberWithInt:9]  OtherQid:[NSNumber numberWithInt:7] ]==YES, @"");
    NSAssert([utilities UnFollow:[NSNumber numberWithInt:9] OtherQid:[NSNumber numberWithInt:7]]==YES, @"");
}

-(void)testCreatingAStory
{
    NSAssert([utilities CreateStory:[NSNumber numberWithInt:9] Message:@"Hello my name is Leona" OtherParms:nil]>0,@"");
}

-(void)testCreatingAPet
{
    NSAssert([utilities CreatePetWithUserName:@"test1" OtherParms:nil]==YES,@"");
}

-(void)testAsiHttps
{
    [utilities testASIHTTPS];
    NSAssert(true==true, @"");

}

-(void)testReadingJsonFile
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DoggyStoriesSample" ofType:@"json"];

    [utilities GetStoriesFromFiles:filePath];
    NSAssert(true==true, @"");
}
@end
