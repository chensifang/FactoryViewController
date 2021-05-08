//
//  UIColor+Extension.h
//  TestProject
//
//  Created by chen on 7/1/18.
//  Copyright © 2018 fourye. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kRandomColor [UIColor randomColor]


NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)
+ (UIColor *)randomColor;
+ (UIColor *)hexColor:(long)hexColor;
@end

NS_ASSUME_NONNULL_END
