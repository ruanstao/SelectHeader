//
//  SelectBottomView.h
//  JJSOA
//
//  Created by RuanSTao on 16/1/7.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectBottomButtonClick)(void);

@interface SelectBottomView : UIView

@property (nonatomic,copy) SelectBottomButtonClick block;

@end
