//
//  TFGRelativeDateFormatterTests.m
//  TFGRelativeDateFormatterExample
//
//  Created by Thomas on 21/03/2014.
//  Copyright (c) 2014 Thomas Guthrie. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <TFGRelativeDateFormatter/TFGRelativeDateFormatter.h>

@interface TFGRelativeDateFormatterTests : XCTestCase {
    NSCalendar *calendar;
    NSDateComponents *components;
    NSDate *fromDate;
    TFGRelativeDateFormatter *formatter;
}

@end

@implementation TFGRelativeDateFormatterTests

- (void)setUp
{
    [super setUp];

    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    components = [[NSDateComponents alloc] init];
    [components setYear:2013];
    [components setMonth:1];
    [components setDay:8];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    fromDate = [calendar dateFromComponents:components];

    formatter = [[TFGRelativeDateFormatter alloc] init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];
    formatter.calendar = calendar;
}

- (void)testReturnsTimeWhenSameDay
{
    NSDate *date = [calendar dateFromComponents:components];
    NSString *string = [formatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(string, @"00:00");
}

- (void)testReturnsYesterdayWhenLessThanADayAgo
{
    [components setDay:7];
    NSDate *date = [calendar dateFromComponents:components];
    NSString *string = [formatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(string, @"Yesterday");
}

- (void)testReturnsDayOfWeekIfLessThanAWeekAgo
{
    [components setDay:2];
    NSDate *date = [calendar dateFromComponents:components];
    NSString *string = [formatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(string, @"Wednesday");
}

- (void)testReturnsTheDayOfTheMonthIfSameYear
{
    [components setDay:1];
    NSDate *date = [calendar dateFromComponents:components];
    NSString *string = [formatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(string, @"1 Jan");
}

- (void)testReturnsFullDateIfLastYear
{
    [components setDay:0];
    NSDate *date = [calendar dateFromComponents:components];
    NSString *string = [formatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(string, @"31/12/2012");
}

@end
