//
//  RtSelectViewTitleModel.h
//  SelectHeader
//
//  Created by RuanSTao on 15/12/11.
//  Copyright © 2015年 JJS-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RtSelectViewTitleModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) BOOL select;
@property (nonatomic,assign) BOOL isNeedBottomButton;
@property (nonatomic,strong) NSArray *subItemArray;

@end
