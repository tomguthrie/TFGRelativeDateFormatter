# TFGRelativeDateFormatter
[![Build
Status](https://travis-ci.org/tomguthrie/TFGRelativeDateFormatter.svg?branch=master)](https://travis-ci.org/tomguthrie/TFGRelativeDateFormatter)

**Mail.app style relative date formatter.**

## Usage

```objective-c
#import "TFGRelativeDateFormatter.h"

NSDate *date = ...;
TFGRelativeDateFormatter *formatter = [[TFGRelativeDateFormatter alloc] init];
NSString *relativeString = [formatter stringForDate:date];
```

## Installation

TFGRelativeDateFormatter is available through
[CocoaPods](http://cocoapods.org), to install it simply add the following line
to your Podfile:

    pod 'TFGRelativeDateFormatter'

## Contact

[Thomas Guthrie](https://github.com/tomguthrie)
[@tomguthrie](https://twitter.com/tomguthrie)

## License

TFGRelativeDateFormatter is available under the MIT license. See the LICENSE
file for more info.
