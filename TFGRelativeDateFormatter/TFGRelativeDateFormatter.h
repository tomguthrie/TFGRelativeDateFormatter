//
// TFGRelativeDateFormatter.h
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

#import <Foundation/Foundation.h>

/**
 * Instances of TFGRelativeDateFormatter can be used to get a localized relative date string
 * similar to how iOS' Mail.app displays the date of a mail.
 *
 * @warning TFGRelativeDateFormatter is not thread safe due to its use of NSDateFormatter.
 */
@interface TFGRelativeDateFormatter : NSObject

/**
 * Returns a shared instance of TFGRelativeDateFormatter for use on the main thread.
 */
+ (instancetype)sharedFormatter;

/**
 * Specifies the locale used to format strings. Defaults to the current system locale.
 */
@property (nonatomic) NSLocale *locale;

/**
 * Specifies the calendar used in date calculations. Defaults to the current system calendar.
 */
@property (nonatomic) NSCalendar *calendar;

/**
 * Returns a string representation of the date relative to the current date using the receiver's current settings.
 *
 * @param date The date to be used relative to the current date. Cannot be in the future.
 */
- (NSString *)stringForDate:(NSDate *)date;

/**
 * Returns a string representation of the date relative to the specifed `fromDate` using the receiver's current settings.
 *
 * @param date The date to be used relative to `fromDate`. Cannot be later than `fromDate`.
 * @param fromDate The date that `date` is relative to.
 */
- (NSString *)stringForDate:(NSDate *)date fromDate:(NSDate *)fromDate;

@end
