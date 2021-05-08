//
//  BaseCell.m
//  TestProject
//
//  Created by chen on 7/6/18.
//  Copyright © 2018 fourye. All rights reserved.
//

#import "FactoryCell.h"
#import "UIView+YYAdd.h"
#import "UIColor+Extension.h"

@interface FactoryCell()
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation FactoryCell
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
////    [super touchesBegan:touches withEvent:event];
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = [UIColor hexColor:0xDAEEF9];
    [super touchesBegan:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.backgroundColor = [UIColor whiteColor];
    });
    [super touchesCancelled:touches withEvent:event];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.backgroundColor = [UIColor whiteColor];
    });
    [super touchesEnded:touches withEvent:event];
}

static const float margin = 10;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textAlignment = NSTextAlignmentLeft;
//    self.textLabel.backgroundColor = kRandomColor;
    self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, frame.size.height)];
    self.line.left = self.width - self.line.width;
    self.line.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
    self.bottomLine.top = self.height - self.bottomLine.height;
    self.bottomLine.backgroundColor = [UIColor.lightGrayColor colorWithAlphaComponent:0.3];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.bottomLine];
    [self.contentView addSubview:self.textLabel];
    return self;
}

- (void)updateWithModel:(FactoryCellModel *)model center:(BOOL)center {
//    self.backgroundColor = kRandomColor;
    self.textLabel.text = model.title;
    self.textLabel.font = [UIFont systemFontOfSize:15];
    self.textLabel.width = self.width - 2 * margin;
    self.textLabel.numberOfLines = 0;
    self.textLabel.textColor = [UIColor hexColor:0x66FF];
    if (center) {
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self.textLabel sizeToFit];
        self.textLabel.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    } else {
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        [self.textLabel sizeToFit];
        self.textLabel.center = CGPointMake(self.width * 0.5, self.height * 0.5);
        self.textLabel.left = margin;
    }
    
    self.line.hidden = self.hiddenLine ? : NO;
    self.bottomLine.width = self.longBottomLine ? kScreenWidth : self.width;
}



@end
