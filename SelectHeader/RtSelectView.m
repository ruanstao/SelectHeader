//
//  RtSelectView.m
//  SelectHeader
//
//  Created by RuanSTao on 15/12/9.
//  Copyright © 2015年 JJS-iMac. All rights reserved.
//

#import "RtSelectView.h"

@interface RtSelectView()
@property (weak, nonatomic) IBOutlet UIScrollView *headerTitlesScrollView;
@property (weak, nonatomic) IBOutlet UITableView *firstTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;
@property (weak, nonatomic) IBOutlet UITableView *thirdTableView;

@property (assign, nonatomic) NSInteger tableViewCounts;

@end

@implementation RtSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubview:self.firstTableView];
        [self addSubview:self.secondTableView];
        [self addSubview:self.thirdTableView];
    }
    self.tableViewCounts = 3;
    [self layoutTableViews];
    return self;
}

- (void)initalizeUI
{
    self.tableViewCounts = [self.rtDataSource tableViewCounts];

}

- (void)layoutTableViews
{
    switch (self.tableViewCounts) {
        case 0:{
            self.firstTableView.alpha = 0;
            self.secondTableView.alpha = 0;
            self.thirdTableView.alpha = 0;
        }
            break;
        case 1:{
            self.firstTableView.alpha = 1;
            self.secondTableView.alpha = 0;
            self.thirdTableView.alpha = 0;
            self.firstTableView.frame = CGRectMake(0, 0, self.frame.size.width,TableViewHeight );
        }
            break;
        case 2:{
            self.firstTableView.alpha = 1;
            self.secondTableView.alpha = 1;
            self.thirdTableView.alpha = 0;
            self.firstTableView.frame = CGRectMake(0, 0, self.frame.size.width / 2,TableViewHeight );
            self.secondTableView.frame = CGRectMake(0, self.frame.size.width / 2, self.frame.size.width / 2,TableViewHeight );
        }
            break;
        case 3:{
            self.firstTableView.alpha = 1;
            self.secondTableView.alpha = 1;
            self.thirdTableView.alpha = 1;
            self.firstTableView.frame = CGRectMake(0, 0, self.frame.size.width / 3,TableViewHeight );
            self.secondTableView.frame = CGRectMake(0, self.frame.size.width / 3, self.frame.size.width / 3,TableViewHeight );
            self.thirdTableView.frame = CGRectMake(0, self.frame.size.width / 3 * 2, self.frame.size.width / 3,TableViewHeight );
        }
            break;

        default:
            break;
    }
}


@end
