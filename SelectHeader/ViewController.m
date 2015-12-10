//
//  ViewController.m
//  SelectHeader
//
//  Created by RuanSTao on 15/12/9.
//  Copyright © 2015年 JJS-iMac. All rights reserved.
//

#import "ViewController.h"
#import "RtSelectView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet RtSelectView *selectView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.selectView = [[[NSBundle mainBundle] loadNibNamed:@"RtSelectView" owner:self options:nil] firstObject];
    self.selectView.frame = (CGRect){0,100,320,500};
    [self.view addSubview:self.selectView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
