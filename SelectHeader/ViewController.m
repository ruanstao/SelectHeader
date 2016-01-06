//
//  ViewController.m
//  SelectHeader
//
//  Created by RuanSTao on 15/12/9.
//  Copyright © 2015年 JJS-iMac. All rights reserved.
//

#import "ViewController.h"
#import "RtSelectView.h"
#import "RtSelectViewTitleModel.h"
#import "RtSelectViewTableCellItem.h"
#import "SelectTitleView.h"

@interface ViewController ()<RtSelectViewDataSource,RtSelectViewDelegate>
@property (weak, nonatomic) IBOutlet RtSelectView *selectView;

@property (nonatomic,strong) NSArray *rtselectViewContent;
@property (nonatomic,assign) NSInteger titleSelectIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        [self analysisData];
    self.selectView = [[[NSBundle mainBundle] loadNibNamed:@"RtSelectView" owner:self options:nil] firstObject];
    self.selectView.frame = (CGRect){0,100,320,500};
    self.selectView.rtDataSource = self;
    self.selectView.rtDelegate = self;
    [self.selectView initalizeUI];
    [self.view addSubview:self.selectView];
//    [self performSelector:@selector(a) withObject:nil afterDelay:2];


}

- (void)analysisData
{

    RtSelectViewTableCellItem *itemA = [[RtSelectViewTableCellItem alloc] init];
    RtSelectViewTableCellItem *itemB = [[RtSelectViewTableCellItem alloc] init];
    RtSelectViewTableCellItem *itemC = [[RtSelectViewTableCellItem alloc] init];
    itemA.currentModel = @"A";
    itemB.currentModel = @"B";
    itemC.currentModel = @"C";
    itemA.subModelArr = @[itemB,itemC];
    itemB.subModelArr = @[itemC];
    RtSelectViewTitleModel *titleA = [[RtSelectViewTitleModel alloc] init];
    RtSelectViewTitleModel *titleB = [[RtSelectViewTitleModel alloc] init];
    RtSelectViewTitleModel *titleC = [[RtSelectViewTitleModel alloc] init];
    RtSelectViewTitleModel *titleD = [[RtSelectViewTitleModel alloc] init];
    titleA.title = @"A";
    titleB.title = @"B";
    titleC.title = @"C";
    titleA.subItemArray = @[itemA,itemB,itemC];
    titleB.subItemArray = @[itemB,itemC];
    titleC.subItemArray = @[itemC];
    titleB.isNeedBottomButton = YES;
    self.rtselectViewContent = @[titleA,titleB,titleC,titleD];
}

//@[title]
//static NSInteger a = 2;
//- (void)a
//{
//    a =3;
//    [self.selectView reloadAllTableViews];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)headerTitlesCount
{
   return self.rtselectViewContent.count;
}

- (instancetype)getClassObjectFormNib:(NSString *)nibString
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:nibString owner:nil options:nil];
    for (id anyObject in nibs) {
        if ([anyObject isKindOfClass:NSClassFromString(nibString)]) {
            return anyObject;
        }
    }
    return nil;
}

- (UIView *)headerTitleViewWithIndex:(NSInteger)index
{
    NSInteger width = [UIScreen mainScreen].bounds.size.width / self.rtselectViewContent.count;
    RtSelectViewTitleModel *titleModel = [self.rtselectViewContent objectAtIndex:index];
    SelectTitleView *selectTitleView = (SelectTitleView *)[self getClassObjectFormNib:@"SelectTitleView"];
    selectTitleView.frame = CGRectMake(index * width, 0, width, 32);
    selectTitleView.title.text = titleModel.title;
    return selectTitleView;
}

- (void) headerTitleView:(UIView *) titleView didSelectIndex:(NSInteger)index
{
    RtSelectViewTitleModel *indexModel = [self.rtselectViewContent objectAtIndex:index];
    RtSelectViewTitleModel *originalIndexModel = [self.rtselectViewContent objectAtIndex:self.titleSelectIndex];
    if (self.titleSelectIndex == index) {
        indexModel.select = !indexModel.select;
        if (indexModel.select) {
            [self.selectView rtSelectViewOpenSelf:YES withAnimate:YES];
            [self.selectView reloadAllTableViews];
        }else{
            [self.selectView rtSelectViewOpenSelf:NO withAnimate:YES];
        }
    }else{
        self.titleSelectIndex = index;
        originalIndexModel.select = NO;
        indexModel.select = !indexModel.select;
        if (indexModel.select) {
            [self.selectView rtSelectViewOpenSelf:YES withAnimate:!originalIndexModel.select];
            [self.selectView reloadAllTableViews];
        }else{
            [self.selectView rtSelectViewOpenSelf:NO withAnimate:!originalIndexModel.select];
        }
    }



}

- (NSInteger )tableViewCounts
{
    RtSelectViewTitleModel *titleModel = [self.rtselectViewContent objectAtIndex:self.titleSelectIndex];

    return titleModel.subItemArray.count;
}

- (NSInteger)tableViewType:(RTTableViewType)tableViewType tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableViewType:(RTTableViewType)tableViewType tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

- (UIView *)tableBottomView
{
    RtSelectViewTitleModel *titleModel = [self.rtselectViewContent objectAtIndex:self.titleSelectIndex];
    if (titleModel.isNeedBottomButton) {
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 50)];
        bottomView.backgroundColor = [UIColor brownColor];
        return bottomView;
    }else{
        return nil;
    }

}

- (void)tableViewType:(RTTableViewType)tableViewType tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tableViewType:%@ %@ %@ ",@(tableViewType),@(indexPath.section),@(indexPath.row));
}
@end
