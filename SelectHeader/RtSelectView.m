//
//  RtSelectView.m
//  SelectHeader
//
//  Created by RuanSTao on 15/12/9.
//  Copyright © 2015年 JJS-iMac. All rights reserved.
//

#import "RtSelectView.h"
#import <BlocksKit+UIKit.h>

@interface RtSelectView()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backGroundViewHeight;

@property (weak, nonatomic) IBOutlet UIView *headerTitlesView;
@property (weak, nonatomic) IBOutlet UITableView *firstTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;
@property (weak, nonatomic) IBOutlet UITableView *thirdTableView;

@property (assign, nonatomic) NSInteger tableViewCounts;
@property (assign, nonatomic) NSInteger headerTitlesCount;
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

    }

    return self;
}

- (void)initalizeUI
{
    [self addSubview:self.firstTableView];
    [self addSubview:self.secondTableView];
    [self addSubview:self.thirdTableView];
    [self reloadHeaderTitleViews];
    [self reloadAllTableViews];

}

- (void)reloadAllTableViews
{

    [self layoutAllTableViews];
    [self.firstTableView reloadData];
    [self.secondTableView reloadData];
    [self.thirdTableView reloadData];
}

- (void)reloadHeaderTitleViews
{
    self.headerTitlesCount = [self.rtDataSource headerTitlesCount];
    for (int i = 0; i < self.headerTitlesCount; i++) {
      UIView *titleView = [self.rtDataSource headerTitleViewWithIndex:i];
        __weak UIView *weakTitleView = titleView;
        [titleView bk_whenTapped:^{
            __strong UIView *strongTitleView = weakTitleView;
            if ([self.rtDelegate respondsToSelector:@selector(headerTitleView:didSelectIndex:)]) {
                [self.rtDelegate headerTitleView:strongTitleView didSelectIndex:i];
            }
        }];
        [self.headerTitlesView addSubview:titleView];
    }
}

- (void)layoutAllTableViews
{
    self.tableViewCounts = [self.rtDataSource tableViewCounts];
    [self setTableViewsFrame];
}

- (void)setTableViewsFrame
{
    switch (self.tableViewCounts) {
        case 0:{
    self.firstTableView.alpha  = 0;
    self.secondTableView.alpha = 0;
    self.thirdTableView.alpha  = 0;
        }
            break;
        case 1:{
    self.firstTableView.alpha  = 1;
    self.secondTableView.alpha = 0;
    self.thirdTableView.alpha  = 0;
    self.firstTableView.frame  = CGRectMake(0, CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width,TableViewHeight );
        }
            break;
        case 2:{
    self.firstTableView.alpha  = 1;
    self.secondTableView.alpha = 1;
    self.thirdTableView.alpha  = 0;
    self.firstTableView.frame  = CGRectMake(0, CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 2,TableViewHeight );
    self.secondTableView.frame = CGRectMake(self.frame.size.width / 2,CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 2,TableViewHeight );
        }
            break;
        case 3:{
    self.firstTableView.alpha  = 1;
    self.secondTableView.alpha = 1;
    self.thirdTableView.alpha  = 1;
    self.firstTableView.frame  = CGRectMake(0, CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 3,TableViewHeight );
    self.secondTableView.frame = CGRectMake(self.frame.size.width / 3,CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 3,TableViewHeight );
    self.thirdTableView.frame  = CGRectMake(self.frame.size.width / 3 * 2,CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 3,TableViewHeight );
        }
            break;

        default:{
            self.firstTableView.alpha  = 1;
            self.secondTableView.alpha = 1;
            self.thirdTableView.alpha  = 1;
        }
            break;
    }
}

- (void)rtSelectViewOpenSelf:(BOOL)open
{
    [UIView animateWithDuration:0.6 animations:^{
        if (open) {
            self.backGroundViewHeight.constant = CGRectGetHeight(self.headerTitlesView.frame) + TableViewHeight;
            self.firstTableView.alpha  = 1;
            self.secondTableView.alpha = 1;
            self.thirdTableView.alpha  = 1;
        }else{
            self.backGroundViewHeight.constant = CGRectGetHeight(self.headerTitlesView.frame);
            self.firstTableView.alpha  = 0;
            self.secondTableView.alpha = 0;
            self.thirdTableView.alpha  = 0;
        }
    }];
}
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.firstTableView) {
        return [self.rtDataSource tableViewType:RTTableViewType_FirstTableView tableView:tableView numberOfRowsInSection:section];
    }else if (tableView == self.secondTableView){
        return [self.rtDataSource tableViewType:RTTableViewType_SecondTableView tableView:tableView numberOfRowsInSection:section];
    }else if (tableView == self.thirdTableView){
        return [self.rtDataSource tableViewType:RTTableViewType_ThirdTableView tableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.firstTableView) {
        return [self.rtDataSource tableViewType:RTTableViewType_FirstTableView tableView:tableView cellForRowAtIndexPath:indexPath];
    }else if (tableView == self.secondTableView){
        return [self.rtDataSource tableViewType:RTTableViewType_SecondTableView tableView:tableView cellForRowAtIndexPath:indexPath];
    }else if (tableView == self.thirdTableView){
        return [self.rtDataSource tableViewType:RTTableViewType_ThirdTableView tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    UITableViewCell *cell      = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (nil == cell) {
    cell                       = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

#pragma mark -<UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.firstTableView) {
        [self.rtDelegate tableViewType:RTTableViewType_FirstTableView tableView:tableView didSelectRowAtIndexPath:indexPath];
    }else if (tableView == self.secondTableView){
        [self.rtDelegate tableViewType:RTTableViewType_SecondTableView tableView:tableView didSelectRowAtIndexPath:indexPath];
    }else if (tableView == self.thirdTableView){
        [self.rtDelegate tableViewType:RTTableViewType_ThirdTableView tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
