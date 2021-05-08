//
//  BaseCell.h
//  Keep
//
//  Created by chen on 2018/10/28.
//  Copyright © 2018 Beijing Calorie Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NavHeight self.navigationController.navigationBar.height

#define ADD_SECTION(title) [self addSectionTitle:title];
#define ADD_CELL(title, SEL) [self addCellWithTitle:title selector:@selector(SEL)]
#define ADD_SWITCH(x) [self addSwitchCell:x]


@protocol BaseCollectionViewControllerDelegate <NSObject>
@optional
- (void)reset;
@end

NS_ASSUME_NONNULL_BEGIN
@interface BaseColletionViewController : UIViewController <BaseCollectionViewControllerDelegate>

@property (nonatomic, assign) BOOL partTable;
@property (nonatomic, assign) CGFloat topHeight;
@property (nonatomic, assign) BOOL inCenter;
@property (nonatomic, assign) BOOL dissmiss;
@property (nonatomic, assign) BOOL marginTop;


- (instancetype)initWithTitle:(NSString *)title;
- (void)removeTopViews;
- (void)addSectionTitle:(NSString *)title;
- (void)addCellWithTitle:(NSString *)title nextVC:(NSString *)name;
- (void)addCellWithTitle:(NSString *)title func:(void (*)(void))func;
- (void)addCellWithTitle:(NSString *)title block:(void (^)(void))block;
- (void)addCellWithTitle:(NSString *)title selector:(SEL)sel;
- (void)addSwitchCell:(NSString *)title;

NS_ASSUME_NONNULL_END
@end
