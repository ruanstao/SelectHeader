//
//  RtSelectView.h
//  SelectHeader
//
//  Created by RuanSTao on 15/12/9.
//  Copyright © 2015年 JJS-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RtSelectViewTitleModel.h"
#import "RtSelectViewTableCellItem.h"

typedef NS_ENUM(NSInteger, RTSelectViewTableViewFrameSetting) {
    TableViewHeight = 250,

};

typedef NS_ENUM(NSInteger, RTTableViewType) {
    RTTableViewType_FirstTableView  = 1,
    RTTableViewType_SecondTableView = 2,
    RTTableViewType_ThirdTableView  = 3,

};

@protocol RtSelectViewDelegate <NSObject>
@optional


- (void)tableViewType:(RTTableViewType)tableViewType tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

//------------------
- (void)headerTitleView:(UIView *) titleView didSelectIndex:(NSInteger)index;
- (void)layoutTitlesView:(UIView *) titleView Index:(NSInteger)index;
- (void)backGroundViewClick;

@end

@protocol RtSelectViewDataSource <NSObject>

@required
- (NSInteger )tableViewCounts;

- (NSInteger)tableViewType:(RTTableViewType)tableViewType tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableViewType:(RTTableViewType)tableViewType tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

//------------------
- (NSInteger)headerTitlesCount;
- (UIView *)headerTitleViewWithIndex:(NSInteger)index;

@optional

- (UIView *)tableBottomView;

- (CGFloat)tableViewType:(RTTableViewType)tableViewType tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)tableViewHeight;
@end



@interface RtSelectView : UIView

@property (nonatomic,strong) NSIndexPath *firstTableIndex;

@property (nonatomic,strong) NSIndexPath *secondTableIndex;

@property (nonatomic,strong) NSIndexPath *thirdTableIndex;

@property (nonatomic,assign) id <RtSelectViewDelegate>rtDelegate;

@property (nonatomic,assign) id <RtSelectViewDataSource>rtDataSource;

- (void)initalizeUI;
- (void)reloadTitlesView;
- (void)layoutTitlesView;
- (void)reloadAllTableViews;
- (void)layoutAllTableViews;
- (void)rtSelectViewOpenSelf:(BOOL)open withAnimate:(BOOL)animate;
@end

