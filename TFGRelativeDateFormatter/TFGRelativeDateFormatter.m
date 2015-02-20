//
// TFGRelativeDateFormatter.m
//
// Copyright (c) 2014 Thomas Guthrie
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "TFGRelativeDateFormatter.h"

@interface TFGRelativeDateFormatter ()

@property (nonatomic, readonly) NSDateFormatter *dateFormatter;
@property (nonatomic, readonly) NSDateFormatter *timeFormatter;
@property (nonatomic, readonly) NSDateFormatter *weekFormatter;
@property (nonatomic, readonly) NSDateFormatter *monthFormatter;

@end

@implementation TFGRelativeDateFormatter

- (id)init
{
    self = [super init];

    if (self) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
        _timeFormatter = [[NSDateFormatter alloc] init];
        [_timeFormatter setTimeStyle:NSDateFormatterShortStyle];
        _weekFormatter = [[NSDateFormatter alloc] init];
        [_weekFormatter setDateFormat:@"EEEE"];
        _monthFormatter = [[NSDateFormatter alloc] init];

        _calendar = [NSCalendar currentCalendar];
        self.locale = [NSLocale currentLocale];
    }

    return self;
}

#pragma mark - Class methods

+ (instancetype)sharedFormatter
{
    static TFGRelativeDateFormatter *__sharedFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedFormatter = [[TFGRelativeDateFormatter alloc] init];
    });

    return __sharedFormatter;
}

#pragma mark - Properties

- (void)setLocale:(NSLocale *)locale
{
    if (_locale == locale) {
        return;
    }

    _locale = locale;

    [self.dateFormatter setLocale:locale];
    [self.timeFormatter setLocale:locale];
    [self.weekFormatter setLocale:locale];
    [self.monthFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"d MMM" options:0 locale:_locale]];
}

#pragma mark - Formatting

- (NSString *)stringForDate:(NSDate *)date
{
    return [self stringForDate:date fromDate:[NSDate date]];
}

- (NSString *)stringForDate:(NSDate *)date fromDate:(NSDate *)fromDate
{
    NSAssert([date compare:fromDate] <= NSOrderedSame, @"date must be earlier than fromDate");

    NSDateComponents *components = [self.calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:fromDate];
    [components setHour:-[components hour]];
    [components setMinute:-[components minute]];
    [components setSecond:-[components second]];
    NSDate *today = [self.calendar dateByAddingComponents:components toDate:fromDate options:0];

    if ([date compare:today] >= NSOrderedSame) {
        return [self.timeFormatter stringFromDate:date];
    }

    components = [[NSDateComponents alloc] init];
    [components setDay:-1];
    NSDate *yesterday = [self.calendar dateByAddingComponents:components toDate:today options:0];

    if ([date compare:yesterday] >= NSOrderedSame) {
        return NSLocalizedString(@"yesterday", nil);
    }

    [components setDay:-6];
    NSDate *lastWeek = [self.calendar dateByAddingComponents:components toDate:today options:0];

    if ([date compare:lastWeek] >= NSOrderedSame) {
        return [self.weekFormatter stringFromDate:date];
    }

    components = [self.calendar components:(NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:fromDate];
    [components setMonth:1 - [components month]];
    [components setDay:1 - [components day]];
    NSDate *endOfYear = [self.calendar dateByAddingComponents:components toDate:fromDate options:0];

    if ([date compare:endOfYear] >= NSOrderedSame) {
        return [self.monthFormatter stringFromDate:date];
    }

    return [self.dateFormatter stringFromDate:date];
}

@end
