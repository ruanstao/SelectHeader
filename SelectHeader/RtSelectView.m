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

//@property (assign, nonatomic) NSInteger tableViewCounts;
//@property (assign, nonatomic) NSInteger headerTitlesCount;
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
    [self.backGroundView addSubview:self.firstTableView];
    [self.backGroundView addSubview:self.secondTableView];
    [self.backGroundView addSubview:self.thirdTableView];
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
    NSInteger headerTitlesCount = [self.rtDataSource headerTitlesCount];
    for (int i = 0; i < headerTitlesCount; i++) {
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
    [self setTableViewsFrame];
}

- (void)setTableViewsFrame
{
    UIView *bottomView = [self.rtDataSource tableBottomView];
    CGFloat bottomViewHeight = 0;
    if (bottomView) {
        bottomViewHeight = CGRectGetHeight(bottomView.frame);
        bottomView.frame = CGRectMake(0, CGRectGetHeight(self.backGroundView.frame) - bottomViewHeight, CGRectGetWidth(self.backGroundView.frame), bottomViewHeight);
        [self.backGroundView addSubview:bottomView];
    }
    NSInteger tableViewCounts = [self.rtDataSource tableViewCounts];
    switch (tableViewCounts) {
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
    self.firstTableView.frame  = CGRectMake(0, CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width,TableViewHeight -bottomViewHeight );
        }
            break;
        case 2:{
    self.firstTableView.alpha  = 1;
    self.secondTableView.alpha = 1;
    self.thirdTableView.alpha  = 0;
    self.firstTableView.frame  = CGRectMake(0, CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 2,TableViewHeight - bottomViewHeight );
    self.secondTableView.frame = CGRectMake(self.frame.size.width / 2,CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 2,TableViewHeight - bottomViewHeight);
        }
            break;
        case 3:{
    self.firstTableView.alpha  = 1;
    self.secondTableView.alpha = 1;
    self.thirdTableView.alpha  = 1;
    self.firstTableView.frame  = CGRectMake(0, CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 3,TableViewHeight -bottomViewHeight );
    self.secondTableView.frame = CGRectMake(self.frame.size.width / 3,CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 3,TableViewHeight - bottomViewHeight);
    self.thirdTableView.frame  = CGRectMake(self.frame.size.width / 3 * 2,CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 3,TableViewHeight - bottomViewHeight);
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

- (void)rtSelectViewOpenSelf:(BOOL)open withAnimate:(BOOL)animate
{
    CGFloat duration = (animate)?0.2:0.0;
    [UIView animateWithDuration: duration animations:^{
        if (open) {
            self.backGroundView.frame =CGRectMake(0, 0, CGRectGetWidth(self.backGroundView.bounds), CGRectGetHeight(self.headerTitlesView.bounds) + TableViewHeight);
            NSLog(@"%@",self.backGroundView);
            self.firstTableView.alpha  = 1;
            self.secondTableView.alpha = 1;
            self.thirdTableView.alpha  = 1;
        }else{
            self.backGroundView.frame =CGRectMake(0, 0, CGRectGetWidth(self.backGroundView.bounds), CGRectGetHeight(self.headerTitlesView.bounds));
            self.firstTableView.alpha  = 0;
            self.secondTableView.alpha = 0;
            self.thirdTableView.alpha  = 0;
        }
    }completion:^(BOOL finished) {
        if (finished) {
            if (open) {
                self.backGroundViewHeight.constant = CGRectGetHeight(self.headerTitlesView.frame) + TableViewHeight;
            }else{
                self.backGroundViewHeight.constant = CGRectGetHeight(self.headerTitlesView.frame);
            }
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
