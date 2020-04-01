//
//  CALayer+FlexXml.m
//  FlexNode
//
//  Created by hao yin on 2020/4/1.
//

#import "CALayer+FlexXml.h"

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
            l.shadowColor = [[UIColor alloc] initWithHex:value.intValue].CGColor;
        }
        if([key isEqualToString:@"shadowOffset"]){
            l.shadowOffset = CGSizeFromString(value);
        }
        if([key isEqualToString:@"contents"]){
            UIImage* img = [UIImage imageWithXmlValue:value];
            l.contents = (__bridge id _Nullable)(img.CGImage);
        }
    }
    l.contentsScale = UIScreen.mainScreen.scale;
    return l;
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
