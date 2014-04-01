# [TFGRelativeDateFormatter](https://github.com/tomguthrie/TFGRelativeDateFormatter)
[![Build Status](https://travis-ci.org/tomguthrie/TFGRelativeDateFormatter.svg?branch=master)](https://travis-ci.org/tomguthrie/TFGRelativeDateFormatter)
[![Version](https://cocoapod-badges.herokuapp.com/v/TFGRelativeDateFormatter/badge.png)](http://cocoadocs.org/docsets/TFGRelativeDateFormatter)
[![Platform](https://cocoapod-badges.herokuapp.com/p/TFGRelativeDateFormatter/badge.png)](http://cocoadocs.org/docsets/TFGRelativeDateFormatter)

Mail.app style relative date formatter.

## Examples

|           | en_GB      | en_US     |
|-----------|:----------:|:---------:|
| Same Day  | 13:45      | 1:45 PM   |
| Yesterday | Yesterday  | Yesterday |
| Same Week | Monday     | Monday    |
| Same Year | 15 Mar     | Mar 15    |
| Last Year | 22/04/2013 | 4/22/13   |

## Usage

```objective-c
NSDate *date = ...;
TFGRelativeDateFormatter *formatter = [[TFGRelativeDateFormatter alloc] init];
NSString *relativeString = [formatter stringForDate:date];
```

`TFGRelativeDateFormatter` has similar cavets to a `NSDateFormatter` (it is used
internally) meaning its a good idea to cache instances and not modify the locale.
A handy class method `+sharedFormatter` is provided to get around this for the
common case where locale is never changed.

```objective-c
NSDate *date = ...;
NSString *relativeString = [[TFGRelativeDateFormatter sharedFormatter] stringForDate:date];
```

**Thread Safety**: `TFGRelativeDateFormatter` is fully thread safe on iOS 7 and
OS X 10.9 (Mordern 64-bit apps). Earlier versions are not however and its recommended
to only use an instance per thread. (More information about thread safety can be
found by reading the [NSDateFormatter][0] class reference.)

## Installation

TFGRelativeDateFormatter is available through
[CocoaPods](http://cocoapods.org), to install it simply add the following line
to your Podfile:

    pod 'TFGRelativeDateFormatter'

Alternatively, simply drag `TFGRelativeDateFormatter.h` and `TFGRelativeDateFormatter.m` to your project.

## Contact

[Thomas Guthrie](https://github.com/tomguthrie)
[@tomguthrie](https://twitter.com/tomguthrie)

## License

TFGRelativeDateFormatter is available under the MIT license. See the LICENSE
file for more info.

[0]: https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/Classes/NSDateFormatter_Class/Reference/Reference.html#//apple_ref/occ/cl/NSDateFormatter
