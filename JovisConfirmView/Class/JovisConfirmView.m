//
//  JovisConfirmView.m
//  JovisConfirmView
//
//  Created by Jovi on 15/9/5.
//
//

#import "JovisConfirmView.h"

#define _SELF_WIDTH CGRectGetWidth(self.frame)
#define _SELF_HEIGHT CGRectGetHeight(self.frame)

@implementation JovisConfirmView

- (instancetype)initWithTitle:(NSString*)title itemTitles:(NSArray*)items frame:(CGRect)frameRect identity:(NSString*)identity{
    self = [super init];
    if (self) {
        [self setFrame:frameRect];
        [self setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1]];
        [self createLabelWithTitle:title];
        [self setItemTitles:items];
        _identity = [NSString stringWithString:identity];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles {
    self = [super init];
    return self;
}

- (void)createLabelWithTitle:(NSString*)mainTitle{
    if (_labTitle == nil) {
        _labTitle = [[UILabel alloc]init];
        [_labTitle setFrame:CGRectMake(0, 0, _SELF_WIDTH, _SELF_HEIGHT / 2 - 1)];
        [_labTitle setBackgroundColor:[UIColor whiteColor]];
        [_labTitle setText:mainTitle];
        [_labTitle setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_labTitle];
    }
}

- (void)setMainTitle:(NSString*)title{
    if (_labTitle) {
        [_labTitle setText:title];
    }
}

- (void)setItemTitles:(NSArray*)titles{
    [_buttons removeAllObjects];
    for (NSInteger i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        UIButton *btn = [[UIButton alloc]init];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:title forState:UIControlStateNormal];
        CGFloat btnWidth = _SELF_WIDTH / titles.count - 1;
        if (i == titles.count - 1) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            btnWidth = _SELF_WIDTH / titles.count;
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [btn setFrame:CGRectMake((_SELF_WIDTH / titles.count) * i, _SELF_HEIGHT / 2, btnWidth, _SELF_HEIGHT / 2)];
        [btn addTarget:self action:@selector(itemButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:i];
        [_buttons addObject:btn];
        [self addSubview:btn];
    }
}

- (void)itemButtonPressed:(UIButton*)sender{
    NSLog(@"clicked");
    if (_delegate) {
        [_delegate confirmView:self didPressButton:sender];
    }
}

@end
