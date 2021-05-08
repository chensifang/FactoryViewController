//
//  BaseTableViewController.h
//  TestProject
//
//  Created by chen on 7/6/18.
//  Copyright © 2018 fourye. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ADD_SECTION(title) [self addSectionTitle:title];
#define ADD_CELL(title, SEL) [self addCellWithTitle:title selector:@selector(SEL)]


@protocol FactoryViewControllerDelegateDelegate <NSObject>
@optional
- (void)reset;
@end

NS_ASSUME_NONNULL_BEGIN
@interface FactoryViewController : UIViewController <FactoryViewControllerDelegateDelegate>

@property (nonatomic, assign) BOOL partTable;
@property (nonatomic, assign) CGFloat topHeight;
@property (nonatomic, assign) BOOL inCenter;
@property (nonatomic, strong) NSObject *obj1;

- (void)selectValue:(void(^)(int first, int second))block;


- (instancetype)initWithTitle:(NSString *)title;
- (void)removeTopViews;
- (void)addSectionTitle:(NSString *)title;
- (void)addCellWithTitle:(NSString *)title nextVC:(NSString *)name;
- (void)addCellWithTitle:(NSString *)title func:(void(*)(void))func;
- (void)addCellWithTitle:(NSString *)title block:(void(^)(void))block;
- (void)addCellWithTitle:(NSString *)title selector:(SEL)sel;
void empty(void);
NS_ASSUME_NONNULL_END
@end


