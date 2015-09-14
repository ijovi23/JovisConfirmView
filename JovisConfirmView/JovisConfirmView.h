//
//  JovisConfirmView.h
//  JovisConfirmView
//
//  Created by Jovi on 15/9/5.
//
//

#import <UIKit/UIKit.h>

@class JovisConfirmView, JovisConfirmViewSection;

typedef enum : NSUInteger {
    JovisConfirmViewItemTypeLabel = 0,
    JovisConfirmViewItemTypeButton,
} JovisConfirmViewItemType;

@protocol JovisConfirmViewDelegate <NSObject>

@optional
- (void)confirmView:(JovisConfirmView*)confirmView didPressButton:(UIButton*)button atIndexPath:(NSIndexPath*)indexPath;

@end

@protocol JovisConfirmViewSectionDelegate <NSObject>

@optional
- (void)confirmViewSection:(JovisConfirmViewSection*)confirmViewSection didPressedButton:(UIButton*)button atIndex:(NSInteger)index;

@end


@interface JovisConfirmViewItem : NSObject
@property (strong, nonatomic) NSString *title;
@property (assign, nonatomic) JovisConfirmViewItemType type;
@property (strong, nonatomic) UIColor *textColor;
+ (JovisConfirmViewItem*)itemWithTitle:(NSString*)title type:(JovisConfirmViewItemType)type textColor:(UIColor*)textColor;
@end

@interface JovisConfirmViewSection : UIView
@property (strong, nonatomic) id<JovisConfirmViewSectionDelegate> delegate;
@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSArray *itemlist;
+ (JovisConfirmViewSection*)sectionWithItemlist:(NSArray*)itemlist;
@end


@interface JovisConfirmView : UIView <JovisConfirmViewSectionDelegate>

@property (strong, nonatomic) NSString *identity;
@property (strong, nonatomic) id<JovisConfirmViewDelegate> delegate;
@property (strong, nonatomic) UILabel *labTitle;
@property (strong, nonatomic) NSMutableArray *itemlists;

- (instancetype)initWithItemlists:(NSArray*)itemlists identity:(NSString*)identity;
- (void)updateWithItemlists:(NSArray*)itemlists;

@end