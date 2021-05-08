//
//  UIColor+Extension.m
//  TestProject
//
//  Created by chen on 7/1/18.
//  Copyright © 2018 fourye. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
- (NSUInteger)hash {
    NSLog(@"%s", __func__);
    return [super hash];
}
+ (UIColor *)randomColor {
    // rgb 值均为 1，则为白色，让所有值为 0.6以上，则颜色较浅
    int start = 60;
    int length = 40;
    CGFloat r = (CGFloat)(1 + start + arc4random() % length) / 100 ;
    CGFloat g = (CGFloat)(1 + start + arc4random() % length) / 100 ;
    CGFloat b = (CGFloat)(1 + start + arc4random() % length) / 100 ;
    return [self colorWithRed:r green:g blue:b alpha:1];
}

+ (UIColor *)hexColor:(long)hexColor {
    return [UIColor colorWithHex:hexColor alpha:1.];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity {
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

@end
