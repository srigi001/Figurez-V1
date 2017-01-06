//
//  UIColor_Extensions.h
//  Mobli
//
//  Created by Ariel Krieger on 8/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColor_Extensions)

+ (UIColor *)colorFromHexString:(NSString *)hex;
+ (UIColor *)colorFromHexString:(NSString *)hex alpha:(CGFloat)alpha;

+ (UIColor *)groupTableViewBackgroundColor;

- (UIImage *)imageWithSize:(CGSize)size;

@end
