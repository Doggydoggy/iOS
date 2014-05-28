//
//  PetFlickerWithStoryBoardTests.m
//  PetFlickerWithStoryBoardTests
//
//  Created by VincentHe on 4/10/14.
//  Copyright (c) 2014 VincentHe. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "utilities.h"

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
    NSAssert(false ==rfalse, @"");
}

-(void)testUserlogin
{
    NSDictionary* rfalse = [utilities LoginUser:@"yhfy2006" andPassword:@"1234"];
    NSAssert(false ==rfalse, @"");
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

@end
