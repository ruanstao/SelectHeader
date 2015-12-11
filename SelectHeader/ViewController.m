//
//  ViewController.m
//  SelectHeader
//
//  Created by RuanSTao on 15/12/9.
//  Copyright © 2015年 JJS-iMac. All rights reserved.
//

#import "ViewController.h"
#import "RtSelectView.h"

@interface ViewController ()<RtSelectViewDataSource>
@property (weak, nonatomic) IBOutlet RtSelectView *selectView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.selectView = [[[NSBundle mainBundle] loadNibNamed:@"RtSelectView" owner:self options:nil] firstObject];
    self.selectView.frame = (CGRect){0,100,320,500};
    self.selectView.rtDataSource = self;
    [self.selectView initalizeUI];
    [self.view addSubview:self.selectView];
    [self performSelector:@selector(a) withObject:nil afterDelay:2];

}
static NSInteger a = 2;
- (void)a
{
    a =3;
    [self.selectView reloadAllTableViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger )tableViewCounts
{
    return a;
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
