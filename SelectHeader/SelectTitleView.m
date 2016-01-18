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

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    if (isSelected) {
        self.image.image = [UIImage imageNamed:@"selectViewColse"];
        self.title.textColor = [UIColor colorWithRed:17.0/255.0 green:125.0/255.0 blue:197.0/255.0 alpha:1];
    }else{
        self.image.image = [UIImage imageNamed:@"selectViewOpen"];
        self.title.textColor = [UIColor colorWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:1];
    }
}

@end
