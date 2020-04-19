//
//  FNRunDelegate.h
//  FlexNode
//
//  Created by hao yin on 2020/4/5.
//

#import <Foundation/Foundation.h>
#import "FNLine.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FNRunDelegateJustify) {
    FNRunDelegateJustifyStart,
    FNRunDelegateJustifyCenter,
    FNRunDelegateJustifyEnd,
    FNRunDelegateJustifyEvenly,
    FNRunDelegateJustifyAround,
    FNRunDelegateJustifyBetween
};

@class FNRunDelegate;

@protocol FNRunDelegateDisplay <NSObject>

- (UIView*) runDelegateView;

@end

extern NSString * const FNRunDelegateKey;

@interface FNRunDelegate : NSObject

@property(nonatomic,assign) CGFloat ascent;

@property(nonatomic,assign) CGFloat descent;

@property(nonatomic,assign) CGFloat width;

@property(nonatomic,readonly) UIImage *image;

@property(nonatomic,readonly) NSAttributedString *attributedString;

@property(nonatomic,readonly) UIEdgeInsets margin;

@property(weak,nullable) id<FNRunDelegateDisplay>display;

@property(nullable,nonatomic) UIView* displayView;

@property(nonatomic,weak) FNFrame *frame;

@property(nonatomic,weak) FNLine *line;

@property(nonatomic,weak) FNRun *run;

@property(nonatomic,assign) FNRunDelegateJustify justify;

- (instancetype)initWithFont:(UIFont *)font;

- (instancetype)initWithFont:(UIFont *)font withImage:(UIImage *)image;

- (instancetype)initwithImage:(UIImage *)image;

- (instancetype)initWithSize:(CGSize)size 
                      margin:(UIEdgeInsets)margin
         WithAttributeString:(NSAttributedString *)attribute;

- (instancetype)initWithSize:(CGSize)size
         WithAttributeString:(NSAttributedString *)attribute;

- (instancetype)initWithAttributeString:(NSAttributedString *)attribute;

- (instancetype)initWithSize:(CGSize)size
                      margin:(UIEdgeInsets)margin
                   withImage:(UIImage *)image;

- (instancetype)initWithSize:(CGSize)size
                   withImage:(UIImage *)image;

- (void)draw:(CGContextRef)ctx rect:(CGRect)rect containerSize:(CGSize)containerSize;

- (CGRect)viewFrameFromContextFrame:(CGRect)rect WithContainer:(CGSize)containerSize;

@end

@interface NSAttributedString (FNRunDelegate)

- (instancetype) initWithRunDelegate:(FNRunDelegate *)runDelegate
                      paragraphStyle:(NSParagraphStyle * _Nullable)style;

- (instancetype) initWithRunDelegate:(FNRunDelegate *)runDelegate;


@end

NS_ASSUME_NONNULL_END
