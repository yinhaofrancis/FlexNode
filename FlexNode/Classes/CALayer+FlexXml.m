//
//  CALayer+FlexXml.m
//  FlexNode
//
//  Created by hao yin on 2020/4/1.
//

#import "CALayer+FlexXml.h"
#import <CoreText/CoreText.h>
@implementation CALayer (FlexXml)
+ (instancetype)nodeWithXMLAttribute:(NSDictionary<NSString *,NSString *> *)attribute{
    CALayer* l = [[self alloc] init];
    for (NSString* key in attribute) {
        NSString* value = attribute[key];
        
        if([key isEqualToString:@"zPosition"]){
            l.zPosition = value.doubleValue;
        }
        if([key isEqualToString:@"backgroundColor"]){
            uint32_t hex = 0;
            [[NSScanner scannerWithString:value] scanHexInt:&hex];
            l.backgroundColor = [[UIColor alloc] initWithHex:hex].CGColor;
        }
        
        if([key isEqualToString:@"contentsGravity"]){
            l.contentsGravity = value;
        }
        if([key isEqualToString:@"masksToBounds"]){
            l.masksToBounds = value.boolValue;
        }
        if([key isEqualToString:@"cornerRadius"]){
            l.cornerRadius = value.doubleValue;
        }
        if([key isEqualToString:@"shadowRadius"]){
            l.shadowRadius = value.doubleValue;
        }
        if([key isEqualToString:@"shadowOpacity"]){
            l.shadowOpacity = value.doubleValue;
        }
        if([key isEqualToString:@"shadowColor"]){
            uint32_t hex = 0;
            [[NSScanner scannerWithString:value] scanHexInt:&hex];
            l.shadowColor = [[UIColor alloc] initWithHex:hex].CGColor;
        }
        if([key isEqualToString:@"shadowOffset"]){
            l.shadowOffset = CGSizeFromString(value);
        }
        if([key isEqualToString:@"contents"]){
            UIImage* img = [UIImage imageWithXmlValue:value];
            l.contents = (__bridge id _Nullable)(img.CGImage);
        }
        if([key isEqualToString:@"name"]){
            l.name = value;
        }
    }
    l.contentsScale = UIScreen.mainScreen.scale;
    return l;
}

+ (nonnull SEL)propertyNode:(nonnull NSString *)name {
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

+ (instancetype)nodeWithXMLAttribute:(NSDictionary<NSString *,NSString *> *)attribute{
    CATextLayer *layer = [super nodeWithXMLAttribute:attribute];
    for (NSString* key in attribute) {
        NSString* value = attribute[key];
        if([key isEqualToString:@"string"]){
            layer.string = value;
        }
        if([key isEqualToString:@"fontSize"]){
            layer.fontSize = value.doubleValue;
        }
        if([key isEqualToString:@"font"]){
            layer.font = (__bridge CFTypeRef _Nullable)([UIFont fontWithName:value size:10]);
        }
        if([key isEqualToString:@"foregroundColor"]){
            uint32_t hex = 0;
            [[NSScanner scannerWithString:value] scanHexInt:&hex];
            layer.foregroundColor = [[UIColor alloc] initWithHex:hex].CGColor;
        }
        if([key isEqualToString:@"wrapped"]){
            layer.wrapped = value.boolValue;
        }
        if([key isEqualToString:@"truncationMode"]){
            layer.truncationMode = value;
        }
        if ([key isEqualToString:@"alignmentMode"]){
            layer.alignmentMode = value;
        }
    }
    return layer;
}
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

@implementation UIColor (FlexXml)
- (instancetype)initWithHex:(uint32_t)hexColor{
    uint32_t r = (hexColor & 0xff000000) >> 24;
    uint32_t g = (hexColor & 0x00ff0000) >> 16;
    uint32_t b = (hexColor & 0x0000ff00) >> 8;
    uint32_t a = hexColor & 0x000000ff;
    
    return [self initWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a / 255.0];
}

@end


@implementation UIImage (FlexXml)
+ (instancetype)imageWithXmlValue:(NSString *)imageValue{
    if([imageValue hasPrefix:@"base64:"]){
        NSData* data = [[NSData alloc] initWithBase64EncodedString:[imageValue substringFromIndex:7] options:NSDataBase64DecodingIgnoreUnknownCharacters];
        return [self.alloc initWithData:data];
    }else if([imageValue hasPrefix:@"file:"]){
        return [[self alloc] initWithContentsOfFile:[imageValue substringFromIndex:5]];
    }else if ([imageValue hasPrefix:@"name:"]){
        return [self imageNamed:[imageValue substringFromIndex:5]];
    }
    return nil;
}
@end




