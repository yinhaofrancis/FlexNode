//
//  NSMutableAttributedString+FlexXml.m
//  FlexNode
//
//  Created by hao yin on 2020/4/2.
//

#import "NSMutableAttributedString+FlexXml.h"
#import "CALayer+FlexXml.h"
@implementation NSMutableAttributedString (FlexXml)

+ (nonnull instancetype)nodeWithXMLAttribute:(nonnull NSDictionary<NSString *,NSString *> *)attribute {
    NSString* string;
    NSMutableDictionary<NSAttributedStringKey,id> *att = [NSMutableDictionary new];
    for (NSString *key in attribute) {
        NSString* value = attribute[key];
        if([key isEqualToString:@"font"]){
            NSArray<NSString *> *key = [value componentsSeparatedByString:@":"];
            if(key.firstObject.length == 0){
                att[NSFontAttributeName] = [UIFont systemFontOfSize:key.lastObject.doubleValue];
            }else{
                att[NSFontAttributeName] = [UIFont fontWithName:key.firstObject size:key.lastObject.doubleValue];
            }
            
        }
        if([key isEqualToString:@"foregroundColor"]){
            uint32_t hex = 0;
            [[NSScanner scannerWithString:value] scanHexInt:&hex];
            att[NSForegroundColorAttributeName] = [[UIColor alloc] initWithHex:hex];
        }
        if([key isEqualToString:@"backgroundColor"]){
            uint32_t hex = 0;
            [[NSScanner scannerWithString:value] scanHexInt:&hex];
            att[NSBackgroundColorAttributeName] = [[UIColor alloc] initWithHex:hex];
        }
        if([key isEqualToString:@"ligature"]){
            att[NSLigatureAttributeName] = @(value.doubleValue);
        }
        if([key isEqualToString:@"kern"]){
            att[NSKernAttributeName] = @(value.doubleValue);
        }
        if([key isEqualToString:@"strikethroughStyle"]){
            NSDictionary<NSString*,NSNumber *>* attmap = @{
                           @"None":@(0x00),
                           @"Single": @(0x01),
                           @"Thick": @(0x02),
                           @"Double":@(0x09),
                           @"PatternSolid": @(0x0000),
                           @"PatternDot":@(0x0100),
                           @"PatternDash": @(0x0200),
                           @"PatternDashDot": @(0x0300),
                           @"DashDotDot": @(0x0400),
                           @"ByWord":@(0x8000)
                       };
            NSArray<NSString *> *values =  [value componentsSeparatedByString:@"|"];
            int32_t v = 0;
            for (NSString* a in values) {
               NSNumber* n = attmap[a];
               v = v | n.intValue;
            }
            att[NSStrikethroughStyleAttributeName] = @(v);
        }
        if([key isEqualToString:@"underlineStyle"]){
            NSDictionary<NSString*,NSNumber *>* attmap = @{
                @"None":@(0x00),
                @"Single": @(0x01),
                @"Thick": @(0x02),
                @"Double":@(0x09),
                @"PatternSolid": @(0x0000),
                @"PatternDot":@(0x0100),
                @"PatternDash": @(0x0200),
                @"PatternDashDot": @(0x0300),
                @"DashDotDot": @(0x0400),
                @"ByWord":@(0x8000)
            };
            NSArray<NSString *> *values =  [value componentsSeparatedByString:@"|"];
            int32_t v = 0;
            for (NSString* a in values) {
                NSNumber* n = attmap[a];
                v = v | n.intValue;
            }
            att[NSUnderlineStyleAttributeName] = @(v);
        }
        if([key isEqualToString:@"strokeColor"]){
            uint32_t hex = 0;
            [[NSScanner scannerWithString:value] scanHexInt:&hex];
            att[NSStrokeColorAttributeName] = [[UIColor alloc] initWithHex:hex];
        }
        if([key isEqualToString:@"strokeWidth"]){
           
            att[NSStrokeWidthAttributeName] = @(value.doubleValue);
        }
        if([key isEqualToString:@"textEffect"]){
           
            att[NSTextEffectAttributeName] = value;
        }
        if([key isEqualToString:@"url"]){
           
            att[NSLinkAttributeName] = value;
        }
        if([key isEqualToString:@"baselineOffset"]){
           
            att[NSBaselineOffsetAttributeName] = @(value.doubleValue);
        }
        if([key isEqualToString:@"underlineColor"]){
           
            uint32_t hex = 0;
            [[NSScanner scannerWithString:value] scanHexInt:&hex];
            att[NSUnderlineColorAttributeName] = [[UIColor alloc] initWithHex:hex];
        }
        if([key isEqualToString:@"strikethroughColor"]){
           
            uint32_t hex = 0;
            [[NSScanner scannerWithString:value] scanHexInt:&hex];
            att[NSUnderlineColorAttributeName] = [[UIColor alloc] initWithHex:hex];
        }
        if([key isEqualToString:@"obliqueness"]){
           
            att[NSObliquenessAttributeName] = @(value.doubleValue);
        }
        if([key isEqualToString:@"expansion"]){
           
            att[NSExpansionAttributeName] = @(value.doubleValue);
        }
        if([key isEqualToString:@"string"]){
           
            string = value;
        }
    }
    return [[NSMutableAttributedString alloc] initWithString:string ? string : @"" attributes:att];
    
}

+ (SEL)propertyNode:(nonnull NSString *)name {
    if([name isEqualToString:@"self.Shadow"]){
        return @selector(setShadow:);
    }
    if([name isEqualToString:@"self.ParagraphStyle"]){
        return @selector(setParamStyle:);
    }
    if([name isEqualToString:@"self.AttributeString"]){
        return @selector(appendAttributedStringContainBR:);
    }
    if ([name isEqualToString:@"self.Font"]) {
        return @selector(setFont:);
    }
    return nil;
}
- (void)appendAttributedStringContainBR:(NSAttributedString *)attrString{
    [self appendAttributedString:attrString];
}

- (void)setFont:(UIFont *)font{
    [self addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.length)];
}

- (void)setParamStyle:(NSParagraphStyle *)style{
    [self addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.length)];
}
- (void)setShadow:(NSShadow *)shadow{
    [self addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, self.length)];
}


@end

@implementation  NSMutableParagraphStyle (FlexXml)



+ (nonnull instancetype)nodeWithXMLAttribute:(nonnull NSDictionary<NSString *,NSString *> *)attribute {
    
    NSMutableParagraphStyle *paramStyle = [[NSMutableParagraphStyle alloc] init];
    for (NSString * key in attribute) {
        NSString* value = attribute[key];
        if([key isEqualToString:@"lineSpacing"]){
            paramStyle.lineSpacing = value.doubleValue;
        }
        if([key isEqualToString:@"paragraphSpacing"]){
            paramStyle.paragraphSpacing = value.doubleValue;
        }
        if([key isEqualToString:@"firstLineHeadIndent"]){
            paramStyle.firstLineHeadIndent = value.doubleValue;
        }
        if([key isEqualToString:@"headIndent"]){
            paramStyle.headIndent = value.doubleValue;
        }
        if([key isEqualToString:@"tailIndent"]){
            paramStyle.tailIndent = value.doubleValue;
        }
        if([key isEqualToString:@"minimumLineHeight"]){
            paramStyle.minimumLineHeight = value.doubleValue;
        }
        if([key isEqualToString:@"maximumLineHeight"]){
            paramStyle.maximumLineHeight = value.doubleValue;
        }
        if([key isEqualToString:@"lineHeightMultiple"]){
            paramStyle.lineHeightMultiple = value.doubleValue;
        }
        if([key isEqualToString:@"paragraphSpacingBefore"]){
            paramStyle.paragraphSpacingBefore = value.doubleValue;
        }
        if([key isEqualToString:@"hyphenationFactor"]){
            paramStyle.hyphenationFactor = value.doubleValue;
        }
        if([key isEqualToString:@"defaultTabInterval"]){
            paramStyle.defaultTabInterval = value.doubleValue;
        }
        if([key isEqualToString:@"allowsDefaultTighteningForTruncation"]){
            paramStyle.allowsDefaultTighteningForTruncation = value.boolValue;
        }
        if([key isEqualToString:@"alignment"]){
            if([value isEqualToString:@"Left"]){
                paramStyle.alignment = NSTextAlignmentLeft;
            }
            if([value isEqualToString:@"Right"]){
                paramStyle.alignment = NSTextAlignmentRight;
            }
            if([value isEqualToString:@"Center"]){
                paramStyle.alignment = NSTextAlignmentCenter;
            }
            if([value isEqualToString:@"Justified"]){
                paramStyle.alignment = NSTextAlignmentJustified;
            }
            if([value isEqualToString:@"Natural"]){
                paramStyle.alignment = NSTextAlignmentNatural;
            }
        }
        if([key isEqualToString:@"lineBreakMode"]){

            if([value isEqualToString:@"WordWrapping"]){
                paramStyle.lineBreakMode = NSLineBreakByWordWrapping;
            }
            if([value isEqualToString:@"CharWrapping"]){
                paramStyle.lineBreakMode = NSLineBreakByCharWrapping;
            }
            if([value isEqualToString:@"Clipping"]){
                paramStyle.lineBreakMode = NSLineBreakByClipping;
            }
            if([value isEqualToString:@"TruncatingHead"]){
                paramStyle.lineBreakMode = NSLineBreakByTruncatingHead;
            }
            if([value isEqualToString:@"TruncatingTail"]){
                paramStyle.lineBreakMode = NSLineBreakByTruncatingTail;
            }
            if([value isEqualToString:@"TruncatingMiddle"]){
                paramStyle.lineBreakMode = NSLineBreakByTruncatingMiddle;
            }
        }
        
    }
    return paramStyle;
}

+ (SEL)propertyNode:(nonnull NSString *)name {
    return nil;
}


@end

@implementation NSShadow (FlexXml)

+ (instancetype)nodeWithXMLAttribute:(NSDictionary<NSString *,NSString *> *)attribute{
    NSShadow* shadow = [[NSShadow alloc] init];
    for (NSString *key in attribute) {
        NSString* value = attribute[key];
        if([key isEqualToString:@"radius"]){
            shadow.shadowBlurRadius = value.doubleValue;
        }
        if([key isEqualToString:@"offset"]){
            shadow.shadowOffset = CGSizeFromString(value);
        }
        if([key isEqualToString:@"shadowColor"]){
            uint32_t hex = 0;
            [[NSScanner scannerWithString:value] scanHexInt:&hex];
            shadow.shadowColor = [[UIColor alloc] initWithHex:hex];
        }
    }
    return shadow;
}
+ (SEL)propertyNode:(NSString *)name{
    return nil;
}

@end


@implementation UIFont (FlexXml)



+ (nonnull instancetype)nodeWithXMLAttribute:(nonnull NSDictionary<NSString *,NSString *> *)attribute {
    NSString *fontName = @".SFUI";
    CGFloat fontSize = 16;
    NSString *weight = @"regular";
    for (NSString *key in attribute) {
        NSString *value = attribute[key];
        if ([key isEqualToString:@"fontName"]){
            fontName = value;
        }
        if ([key isEqualToString:@"fontSize"]){
            fontSize = value.doubleValue;
        }
        if ([key isEqualToString:@"weight"]){
            weight = value;
        }
    }
    UIFontDescriptor* fontd = [UIFontDescriptor fontDescriptorWithFontAttributes:@{
        UIFontDescriptorFamilyAttribute:fontName,
        UIFontDescriptorFaceAttribute:weight
    }];
    
    return [UIFont fontWithDescriptor:fontd size:fontSize];
}

+ (SEL)propertyNode:(nonnull NSString *)name {
    return nil;
}

@end
