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

@interface ViewController ()<RtSelectViewDataSource>
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

    self.rtselectViewContent = @[titleA,titleB,titleC,titleD];
}

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

- (UIView *)headerTitleViewWithIndex:(NSInteger)index
{
    NSInteger width = [UIScreen mainScreen].bounds.size.width / self.rtselectViewContent.count;
    RtSelectViewTitleModel *titleModel = [self.rtselectViewContent objectAtIndex:index];
    UILabel * l = [[UILabel alloc] initWithFrame:CGRectMake(index * width, 0, width, 50)];
    l.text = titleModel.title;
    l.userInteractionEnabled = YES;
    return l;
}
- (void) headerTitleView:(UIView *) titleView didSelectIndex:(NSInteger)index
{
    self.titleSelectIndex = index;
    [self.selectView reloadAllTableViews];
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
@end
