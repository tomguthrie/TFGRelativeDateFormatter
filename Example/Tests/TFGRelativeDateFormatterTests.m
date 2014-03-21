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
    TFGRelativeDateFormatter *gbFormatter;
    NSString *result;
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
    fromDate = [calendar dateFromComponents:components];

    formatter = [[TFGRelativeDateFormatter alloc] init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    formatter.calendar = calendar;

    gbFormatter = [[TFGRelativeDateFormatter alloc] init];
    gbFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];
    gbFormatter.calendar = calendar;
}

- (void)testDateIsSameDayReturnsTime
{
    NSDate *date = [calendar dateFromComponents:components];
    result = [formatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(result, @"12:00 AM");

    result = [gbFormatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(result, @"00:00");
}

- (void)testDateIsYesterdayReturnsYesterday
{
    [components setDay:7];
    NSDate *date = [calendar dateFromComponents:components];
    result = [formatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(result, @"Yesterday");

    result = [gbFormatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(result, @"Yesterday");
}

- (void)testDateIsSameWeekReturnsDayOfWeek
{
    [components setDay:2];
    NSDate *date = [calendar dateFromComponents:components];
    result = [formatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(result, @"Wednesday");

    result = [gbFormatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(result, @"Wednesday");
}

- (void)testDateIsSameYearReturnsDayAndMonth
{
    [components setDay:1];
    NSDate *date = [calendar dateFromComponents:components];
    result = [formatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(result, @"Jan 1");

    result = [gbFormatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(result, @"1 Jan");
}

- (void)testDateIsNotTheSameYearReturnsTheFullDate
{
    [components setDay:0];
    NSDate *date = [calendar dateFromComponents:components];
    result = [formatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(result, @"12/31/12");

    result = [gbFormatter stringForDate:date fromDate:fromDate];
    XCTAssertEqualObjects(result, @"31/12/2012");
}

@end
