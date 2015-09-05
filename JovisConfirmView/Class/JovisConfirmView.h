//
//  JovisConfirmView.h
//  JovisConfirmView
//
//  Created by Jovi on 15/9/5.
//
//

#import <UIKit/UIKit.h>

@class JovisConfirmView;
@protocol JovisConfirmViewDelegate <NSObject>

@optional
- (void)confirmView:(JovisConfirmView*)confirmView didPressButton:(UIButton*)button;

@end

@interface JovisConfirmView : UIView

@property (strong, nonatomic) NSString *identity;
@property (strong, nonatomic) id<JovisConfirmViewDelegate> delegate;
@property (strong, nonatomic) UILabel *labTitle;
@property (strong, nonatomic) NSMutableArray *buttons;

- (instancetype)initWithTitle:(NSString*)title itemTitles:(NSArray*)items frame:(CGRect)frameRect identity:(NSString*)identity;


@end