//
//  SelectTitleVIew.m
//  JJSOA
//
//  Created by RuanSTao on 16/1/5.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "SelectTitleView.h"

@implementation SelectTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setOpen:(BOOL)open
{
    _open = open;
    if (open) {
        self.image.image = [UIImage imageNamed:@"selectViewColse"];
    }else{
        self.image.image = [UIImage imageNamed:@"selectViewOpen"];
    }
}

@end
