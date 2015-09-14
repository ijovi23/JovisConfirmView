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

- (instancetype)initWithItemlists:(NSArray*)itemlists identity:(NSString*)identity{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]];
        _identity = identity;
        [self updateWithItemlists:itemlists];
    }
    return self;
}

- (void)updateWithItemlists:(NSArray*)itemlists{
    if (itemlists) {
        _itemlists = [NSMutableArray arrayWithArray:itemlists];
    }
    if (_itemlists) {
        [self updateComponents];
    }
}

- (void)updateComponents{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_itemlists enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        JovisConfirmViewSection *sectionView = [JovisConfirmViewSection sectionWithItemlist:(NSArray*)obj];
        [sectionView setDelegate:self];
        [sectionView setIndex:idx];
        [self addSubview:sectionView];
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger sectionCount = self.subviews.count;
    for (JovisConfirmViewSection *sectionView in self.subviews) {
        CGFloat secHeight = _SELF_HEIGHT / sectionCount - 1;
        if (sectionView.index == sectionCount - 1) {
            secHeight = secHeight + 1;
        }
        [sectionView setFrame:CGRectMake(0, (_SELF_HEIGHT / sectionCount) * sectionView.index, _SELF_WIDTH, secHeight)];
    }
}

- (void)confirmViewSection:(JovisConfirmViewSection *)confirmViewSection didPressedButton:(UIButton *)button atIndex:(NSInteger)index{
    if (_delegate) {
        [_delegate confirmView:self didPressButton:button atIndexPath:[NSIndexPath indexPathForRow:index inSection:confirmViewSection.index]];
    }
}

@end

@implementation JovisConfirmViewSection

+ (JovisConfirmViewSection*)sectionWithItemlist:(NSArray*)itemlist{
    JovisConfirmViewSection *instance = [[JovisConfirmViewSection alloc]init];
    if (instance) {
        instance.itemlist = itemlist;
        [instance setBackgroundColor:[UIColor clearColor]];
        [instance setupItems];
    }
    return instance;
}

- (void)setupItems{
    if (!_itemlist) {
        return;
    }
    [_itemlist enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        JovisConfirmViewItem *item = (JovisConfirmViewItem*)obj;
        [btn setTitle:item.title forState:UIControlStateNormal];
        switch (item.type) {
            case JovisConfirmViewItemTypeLabel:
                [btn setUserInteractionEnabled:NO];
                break;
            case JovisConfirmViewItemTypeButton:
                [btn setUserInteractionEnabled:YES];
                break;
            default:
                break;
        }
        [btn setTitleColor:item.textColor forState:UIControlStateNormal];
        [btn setTag:idx];
        [btn addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSUInteger itemsCount = self.subviews.count;
    for (UIButton *btn in self.subviews) {
        CGFloat btnWidth = _SELF_WIDTH / itemsCount - 1;
        if (btn.tag == itemsCount - 1) {
            btnWidth = btnWidth + 1;
        }
        [btn setFrame:CGRectMake((_SELF_WIDTH / itemsCount) * btn.tag, 0, btnWidth, _SELF_HEIGHT)];
    }
}

- (void)itemPressed:(UIButton*)sender{
    if (_delegate) {
        [_delegate confirmViewSection:self didPressedButton:sender atIndex:sender.tag];
    }
}

@end

@implementation JovisConfirmViewItem

+ (JovisConfirmViewItem*)itemWithTitle:(NSString*)title type:(JovisConfirmViewItemType)type textColor:(UIColor*)textColor{
    JovisConfirmViewItem *instance = [[JovisConfirmViewItem alloc]init];
    if (instance) {
        instance.title = title;
        instance.type = type;
        instance.textColor = textColor;
    }
    return instance;
}

@end