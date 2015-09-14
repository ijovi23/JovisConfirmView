//
//  ViewController.m
//  JovisConfirmViewProj
//
//  Created by Jovi on 15/9/14.
//  Copyright (c) 2015年 Jovistudio. All rights reserved.
//

#import "ViewController.h"
#import "JovisConfirmView.h"

#define __ScreenWidth [[UIScreen mainScreen]bounds].size.width

@interface ViewController () <JovisConfirmViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    NSMutableArray *itemlists = [[NSMutableArray alloc]init];
    JovisConfirmViewItem *item0 = [JovisConfirmViewItem itemWithTitle:@"Title" type:JovisConfirmViewItemTypeLabel textColor:[UIColor blackColor]];
    JovisConfirmViewItem *item1 = [JovisConfirmViewItem itemWithTitle:@"Button1" type:JovisConfirmViewItemTypeButton textColor:[UIColor blackColor]];
    JovisConfirmViewItem *item2 = [JovisConfirmViewItem itemWithTitle:@"Button2" type:JovisConfirmViewItemTypeButton textColor:[UIColor blackColor]];
    JovisConfirmViewItem *item3 = [JovisConfirmViewItem itemWithTitle:@"Cancel" type:JovisConfirmViewItemTypeButton textColor:[UIColor redColor]];
    [itemlists addObject:@[item0]];
    [itemlists addObject:@[item1, item2]];
    [itemlists addObject:@[item3]];
    JovisConfirmView *cfV = [[JovisConfirmView alloc]initWithItemlists:itemlists identity:@"a"];
    [cfV setDelegate:self];
    [cfV setFrame:CGRectMake(0, 100, __ScreenWidth, 100)];
    [self.view addSubview:cfV];
}

- (void)confirmView:(JovisConfirmView *)confirmView didPressButton:(UIButton *)button atIndexPath:(NSIndexPath *)indexPath{
    if ([confirmView.identity isEqualToString:@"a"]) {
        NSLog(@"Pressed section%ld row%ld title%@", indexPath.section, indexPath.row, button.titleLabel.text);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
