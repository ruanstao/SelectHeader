//
//  RtSelectViewTableCellItem.h
//  SelectHeader
//
//  Created by RuanSTao on 15/12/11.
//  Copyright © 2015年 JJS-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RtSelectViewTableCellItem : NSObject

@property (nonatomic,assign) NSInteger currentType;

@property (nonatomic,strong) NSArray *subModelArr;

@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic,assign) NSInteger subModeSelectIndex;

@end
