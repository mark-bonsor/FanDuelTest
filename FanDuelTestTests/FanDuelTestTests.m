//
//  FanDuelTestTests.m
//  FanDuelTestTests
//
//  Created by mark.bonsor on 03/04/2018.
//  Copyright © 2018 MiB. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface FanDuelTestTests : XCTestCase

@end

@implementation FanDuelTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


- (void)testLoad_playerJSON_when_viewLoads {
    
    ViewController* testee = [[ViewController alloc]init];
    BOOL testValue = [testee load_playerJSON];
    XCTAssertEqual(testValue, TRUE, @"Player JSON failed to load");
    
    testee = nil;
    
}

- (void)testSelectRandomPlayers_when_viewLoads {
    
    ViewController* testee = [[ViewController alloc]init];
    [testee selectRandomPlayers_withNoDraw];
    
    testee = nil;
    
}

@end
