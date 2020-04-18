//
//  FNRunDelegate.h
//  FlexNode
//
//  Created by hao yin on 2020/4/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class FNRunDelegate;

@protocol FNRunDelegateDisplay <NSObject>

- (void)runDelegate:(FNRunDelegate *)rundelegate displayFrame:(CGRect)frame;

- (BOOL)autoDisplayRunDelegate:(FNRunDelegate *)rundelegate;
@end

extern NSString * const FNRunDelegateKey;

@interface FNRunDelegate : NSObject

@property(nonatomic,assign) CGFloat ascent;

@property(nonatomic,assign) CGFloat descent;

@property(nonatomic,assign) CGFloat width;

@property(nonatomic,readonly) UIImage *image;

@property(nonatomic,readonly) NSAttributedString *attributedString;

@property(nonatomic,readonly) UIEdgeInsets margin;

@property(nonatomic,nullable) id<FNRunDelegateDisplay>display;

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


@end

@interface NSAttributedString (FNRunDelegate)

- (instancetype) initWithRunDelegate:(FNRunDelegate *)runDelegate
                      paragraphStyle:(NSParagraphStyle * _Nullable)style;

- (instancetype) initWithRunDelegate:(FNRunDelegate *)runDelegate;


@end

NS_ASSUME_NONNULL_END