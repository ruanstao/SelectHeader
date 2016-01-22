//
//  RtSelectView.m
//  SelectHeader
//
//  Created by RuanSTao on 15/12/9.
//  Copyright © 2015年 JJS-iMac. All rights reserved.
//

#import "RtSelectView.h"
#import <BlocksKit+UIKit.h>
#define Tag_TitlesView 8200

@interface RtSelectView()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backGroundViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *halfAlphaBackGroundViewHeight;
@property (weak, nonatomic) IBOutlet UIView *halfAlphaBackGroundView;

@property (weak, nonatomic) IBOutlet UIView *headerTitlesView;

@property (weak, nonatomic) IBOutlet UITableView *firstTableView;

@property (weak, nonatomic) IBOutlet UITableView *secondTableView;
@property (weak, nonatomic) IBOutlet UITableView *thirdTableView;

//@property (assign, nonatomic) NSInteger tableViewCounts;
//@property (assign, nonatomic) NSInteger headerTitlesCount;
@property (nonatomic,strong) UIView *bottomView;

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
        [self resetTableIndex];
    }

    return self;
}

- (void)resetTableIndex
{
    self.firstTableIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    self.secondTableIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    self.thirdTableIndex = [NSIndexPath indexPathForRow:0 inSection:0];
}
- (void)initalizeUI
{
    [self.backGroundView addSubview:self.thirdTableView];
    [self.backGroundView addSubview:self.secondTableView];
    [self.backGroundView addSubview:self.firstTableView];
    [self reloadHeaderTitleViews];

}

- (void)reloadTitlesView
{
    [self reloadHeaderTitleViews];
    [self reloadAllTableViews];
}

- (void)reloadAllTableViews
{
    [self layoutAllTableViews];
    [self layoutTitlesView];
    [self.firstTableView reloadData];
    [self.secondTableView reloadData];
    [self.thirdTableView reloadData];
}

- (void)backGroundViewClick
{
    [self rtSelectViewOpenSelf:NO withAnimate:YES];
    if ([self.rtDelegate respondsToSelector:@selector(backGroundViewClick)]) {
        [self.rtDelegate backGroundViewClick];
    }
}

- (void)reloadHeaderTitleViews
{
    __weak typeof(self) weakSelf = self;
    [self.halfAlphaBackGroundView bk_whenTapped:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf backGroundViewClick];
    }];
    NSInteger headerTitlesCount = [self.rtDataSource headerTitlesCount];
    for (int i = 0; i < headerTitlesCount; i++) {
      UIView *titleView = [self.rtDataSource headerTitleViewWithIndex:i];
        __weak UIView *weakTitleView = titleView;
        titleView.tag = Tag_TitlesView + i;
        [titleView bk_whenTapped:^{
            __strong UIView *strongTitleView = weakTitleView;
            if ([self.rtDelegate respondsToSelector:@selector(headerTitleView:didSelectIndex:)]) {
                [self.rtDelegate headerTitleView:strongTitleView didSelectIndex:i];
            }
        }];
        [self.headerTitlesView addSubview:titleView];
    }
}

- (void)layoutTitlesView
{
    [self.headerTitlesView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.rtDelegate respondsToSelector:@selector(layoutTitlesView:Index:)]) {
            [self.rtDelegate layoutTitlesView:obj Index:obj.tag - Tag_TitlesView];
        }
    }];
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
        [self.bottomView removeFromSuperview];
        self.bottomView = bottomView;
        [self.backGroundView addSubview:bottomView];
    }else{
        [self.bottomView removeFromSuperview];
        self.bottomView = nil;
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
            self.firstTableView.frame  = CGRectMake(0, CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 8 * 3 ,TableViewHeight - bottomViewHeight );
            self.secondTableView.frame = CGRectMake(self.frame.size.width / 8 * 3,CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 8 * 5,TableViewHeight - bottomViewHeight);
        }
            break;
        case 3:{
            self.firstTableView.alpha  = 1;
            self.secondTableView.alpha = 1;
            self.thirdTableView.alpha  = 1;
            self.firstTableView.frame  = CGRectMake(0, CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 4,TableViewHeight -bottomViewHeight );
            self.secondTableView.frame = CGRectMake(self.frame.size.width / 4,CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 8 * 3,TableViewHeight - bottomViewHeight);
            self.thirdTableView.frame  = CGRectMake(self.frame.size.width / 8 * 5,CGRectGetMaxY(self.headerTitlesView.frame), self.frame.size.width / 8 * 3,TableViewHeight - bottomViewHeight);
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
    if (open) {
        [self resetTableIndex];
        self.backGroundViewHeight.constant = CGRectGetHeight(self.headerTitlesView.frame) + TableViewHeight;
        self.halfAlphaBackGroundViewHeight.constant = [UIScreen mainScreen].bounds.size.height;
        self.firstTableView.alpha  = 1;
        self.secondTableView.alpha = 1;
        self.thirdTableView.alpha  = 1;
    }else{
        self.backGroundViewHeight.constant = CGRectGetHeight(self.headerTitlesView.frame);
        self.halfAlphaBackGroundViewHeight.constant = 32;
        self.firstTableView.alpha  = 0;
        self.secondTableView.alpha = 0;
        self.thirdTableView.alpha  = 0;
    }
    [UIView animateWithDuration: duration animations:^{
        if (open) {
            self.backGroundView.frame =CGRectMake(0, 0, CGRectGetWidth(self.backGroundView.bounds), CGRectGetHeight(self.headerTitlesView.bounds) + TableViewHeight);
            self.halfAlphaBackGroundView.alpha = 0.3;
        }else{
            self.backGroundView.frame =CGRectMake(0, 0, CGRectGetWidth(self.backGroundView.bounds), CGRectGetHeight(self.headerTitlesView.bounds));
            self.halfAlphaBackGroundView.alpha = 0;
        }

    }completion:^(BOOL finished) {
        if (finished) {

        }
    }];
}
#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    [self setExtraCellLineHidden:tableView];
    return 1;
}

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.rtDataSource respondsToSelector:@selector(tableViewType:tableView:heightForRowAtIndexPath:)]) {
        if (tableView == self.firstTableView) {
            return [self.rtDataSource tableViewType:RTTableViewType_FirstTableView tableView:tableView heightForRowAtIndexPath:indexPath];
        }else if (tableView == self.secondTableView){
            return [self.rtDataSource tableViewType:RTTableViewType_SecondTableView tableView:tableView heightForRowAtIndexPath:indexPath];
        }else if (tableView == self.thirdTableView){
            return [self.rtDataSource tableViewType:RTTableViewType_ThirdTableView tableView:tableView heightForRowAtIndexPath:indexPath];
        }
    }
    return 40;
}

#pragma mark -<UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.firstTableView) {
        self.firstTableIndex = indexPath;
        self.secondTableIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        self.thirdTableIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.rtDelegate tableViewType:RTTableViewType_FirstTableView tableView:tableView didSelectRowAtIndexPath:indexPath];
        [self.firstTableView reloadData];
        [self.secondTableView reloadData];
        [self.thirdTableView reloadData];
    }else if (tableView == self.secondTableView){
        self.secondTableIndex = indexPath;
        self.thirdTableIndex = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.rtDelegate tableViewType:RTTableViewType_SecondTableView tableView:tableView didSelectRowAtIndexPath:indexPath];
        [self.secondTableView reloadData];
        [self.thirdTableView reloadData];
    }else if (tableView == self.thirdTableView){
        self.thirdTableIndex = indexPath;
        [self.rtDelegate tableViewType:RTTableViewType_ThirdTableView tableView:tableView didSelectRowAtIndexPath:indexPath];
        [self.thirdTableView reloadData];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return [self.self.halfAlphaBackGroundView pointInside:point withEvent:event];
}

- (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
@end


