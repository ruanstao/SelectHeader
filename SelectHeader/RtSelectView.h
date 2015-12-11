//
//  RtSelectView.h
//  SelectHeader
//
//  Created by RuanSTao on 15/12/9.
//  Copyright © 2015年 JJS-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RTSelectViewTableViewFrameSetting) {
    TableViewHeight = 300,

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
- (void) headerTitleView:(UIView *) titleView didSelectIndex:(NSInteger)index;
@end

@protocol RtSelectViewDataSource <NSObject>

@required
- (NSInteger )tableViewCounts;

- (NSInteger)tableViewType:(RTTableViewType)tableViewType tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableViewType:(RTTableViewType)tableViewType tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

//------------------
- (NSInteger)headerTitlesCount;
- (UIView *)headerTitleViewWithIndex:(NSInteger)i;

@optional

@end



@interface RtSelectView : UIView

@property (nonatomic,assign) id <RtSelectViewDelegate>rtDelegate;

@property (nonatomic,assign) id <RtSelectViewDataSource>rtDataSource;

- (void)initalizeUI;
- (void)reloadAllTableViews;
- (void)layoutAllTableViews;
- (void)rtSelectViewOpenSelf:(BOOL)open;
@end

