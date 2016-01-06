//
//  SelectTitleVIew.h
//  JJSOA
//
//  Created by RuanSTao on 16/1/5.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectTitleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic,assign)BOOL open;
@end
