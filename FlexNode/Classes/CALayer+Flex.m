//
//  CALayer+FlexXml.m
//  FlexNode
//
//  Created by hao yin on 2020/4/1.
//

#import "CALayer+Flex.h"
#import <CoreText/CoreText.h>
@implementation CALayer (FlexXml)

+ (SEL)propertyNode:(nonnull NSString *)name {
    return nil;
}

- (CGSize)FlexNodeContentSize:(CGSize)constaintSize{
    if(self.contents){
        CGImageRef img = (__bridge CGImageRef)(self.contents);
        CGSize size = CGSizeMake(CGImageGetWidth(img) / UIScreen.mainScreen.scale  , CGImageGetHeight(img) / UIScreen.mainScreen.scale );
        return CGSizeMake(MIN(size.width, constaintSize.width), MIN(size.height, constaintSize.height));
    }
    return constaintSize;
}
@end

@implementation CATextLayer (FlexXml)


- (CGSize)FlexNodeContentSize:(CGSize)constaintSize{
    
    if(self.string && [self.string isKindOfClass:NSAttributedString.class]){
        NSAttributedString* str = self.string;
        CTFramesetterRef setting = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)str);
        CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(setting, CFRangeMake(0, str.length), nil, constaintSize, nil);
        CFRelease(setting);
        return size;
        
    }else if (self.string){
        NSAttributedString* str = [[NSAttributedString alloc] initWithString:self.string attributes:@{
            NSFontAttributeName: [(UIFont *)self.font fontWithSize:self.fontSize]
        }];
        CTFramesetterRef setting = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)str);
        CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(setting, CFRangeMake(0, str.length), nil, constaintSize, nil);
        CFRelease(setting);
        return size;
    }
    return CGSizeMake(0, 0);
}
- (void)setAttributeString:(NSAttributedString *)str{
    self.string = str;
}

@end




