//
//  FNRunDelegate.h
//  FlexNode
//
//  Created by hao yin on 2020/4/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const FNRunDelegateKey;

@interface FNRunDelegate : NSObject
@property(nonatomic,assign) CGFloat ascent;
@property(nonatomic,assign) CGFloat descent;
@property(nonatomic,assign) CGFloat width;
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,assign) CGFloat cornerRadius;
- (instancetype)initWithFont:(UIFont *)font;

- (instancetype)initWithFont:(UIFont *)font withImage:(UIImage *)image;
- (void)draw:(CGContextRef)ctx rect:(CGRect)rect;
@end

@interface NSAttributedString (FNRunDelegate)

- (instancetype) initWithRunDelegate:(FNRunDelegate *)runDelegate
                      paragraphStyle:(NSParagraphStyle * _Nullable)style;

- (instancetype) initWithRunDelegate:(FNRunDelegate *)runDelegate;

@end

NS_ASSUME_NONNULL_END
