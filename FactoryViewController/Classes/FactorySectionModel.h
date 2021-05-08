//
//  FactoryCellModel.h
//  TestProject
//
//  Created by chen on 7/6/18.
//  Copyright © 2018 fourye. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class FactoryCellModel;
@interface FactorySectionModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray<FactoryCellModel *> *cellModels;
@end

@interface FactoryCellModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) Class vcClass;
@property (nonatomic, assign) BOOL hasNext;
@property (nonatomic, copy) void(^block)(void);
@property (nonatomic, assign) SEL sel;
@property (nonatomic, assign) void(*func)(void);
@end

NS_ASSUME_NONNULL_END
