//
//  BaseCellModel.h
//  TestProject
//
//  Created by chen on 7/6/18.
//  Copyright © 2018 fourye. All rights reserved.
//

#import "UIView+YYAdd.h"
#import "UIColor+Extension.h"

@class BaseCellModel;
@interface BaseSectionModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray<BaseCellModel *> *cellModels;

@end

@interface BaseCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) Class vcClass;
@property (nonatomic, assign) BOOL hasNext;
@property (nonatomic, assign) BOOL isSwitch;
@property (nonatomic, copy) void(^block)(void);
@property (nonatomic, assign) SEL sel;
@property (nonatomic, assign) void(*func)(void);

@end


