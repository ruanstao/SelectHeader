//
//  RtSelectView.h
//  SelectHeader
//
//  Created by RuanSTao on 15/12/9.
//  Copyright © 2015年 JJS-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RtSelectViewDelegate <NSObject>
@optional

- (void)RtSelectViewOpenSelf:(BOOL)open;

@end

@protocol RtSelectViewDataSource <NSObject>

@required
- (NSInteger )tableViewCounts;

@optional

@end

typedef NS_ENUM(NSInteger, RTSelectViewTableViewFrameSetting) {
    TableViewHeight = 300,
};

@interface RtSelectView : UIView

@property (nonatomic,assign) id <RtSelectViewDelegate>rtDelegate;

@property (nonatomic,assign) id <RtSelectViewDataSource>rtDataSource;

- (void)initalizeUI;


@end

