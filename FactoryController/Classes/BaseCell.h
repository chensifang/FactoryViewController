//
//  BaseCell.h
//  Keep
//
//  Created by chen on 2018/10/28.
//  Copyright © 2018 Beijing Calorie Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCellModel.h"

@interface BaseCell : UICollectionViewCell

@property (nonatomic, assign) BOOL hiddenLine;
@property (nonatomic, assign) BOOL longBottomLine;

- (void)updateWithModel:(BaseCellModel *)model center:(BOOL)center;

@end


