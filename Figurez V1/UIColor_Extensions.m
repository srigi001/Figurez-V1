//
//  UIColor_Extensions.m
//  Mobli
//
//  Created by Ariel Krieger on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIColor_Extensions.h"

@implementation UIColor (UIColor_Extensions)

- (UIImage *)imageWithSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIColor *)colorFromHexString:(NSString *)hex {
    return [UIColor colorFromHexString:hex alpha:1.0];
}

+ (UIColor *)colorFromHexString:(NSString *)hex alpha:(CGFloat)alpha {
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6, 7 or 8 characters
    if ([cString length] < 6) {
        return [UIColor blackColor];  
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor blackColor];
    }
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:alpha];
}

// @or: http://stackoverflow.com/a/12671813/413289
+ (UIColor *)groupTableViewBackgroundColor
{
    __strong static UIImage* tableViewBackgroundImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(7.f, 1.f), NO, 0.0);
        CGContextRef c = UIGraphicsGetCurrentContext();
        [[self colorWithRed:185/255.f green:192/255.f blue:202/255.f alpha:1.f] setFill];
        CGContextFillRect(c, CGRectMake(0, 0, 4, 1));
        [[self colorWithRed:185/255.f green:193/255.f blue:200/255.f alpha:1.f] setFill];
        CGContextFillRect(c, CGRectMake(4, 0, 1, 1));
        [[self colorWithRed:192/255.f green:200/255.f blue:207/255.f alpha:1.f] setFill];
        CGContextFillRect(c, CGRectMake(5, 0, 2, 1));
        tableViewBackgroundImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    });
    return [self colorWithPatternImage:tableViewBackgroundImage];
}


@end
