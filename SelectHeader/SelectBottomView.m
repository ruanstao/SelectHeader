//
//  SelectBottomView.m
//  JJSOA
//
//  Created by RuanSTao on 16/1/7.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "SelectBottomView.h"

@implementation SelectBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)buttonClick:(id)sender {
    if (self.block) {
        self.block();
    }
}

@end
