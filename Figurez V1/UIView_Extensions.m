//
//  UIView_Extensions.m
//  Mobli
//
//  Created by Emmanuel Merali on 09/12/2010.
//  Copyright 2010 Mobli. All rights reserved.
//

#import "UIView_Extensions.h"
//#import "CALayer_Extensions.h"

typedef enum {
    kUIViewBorderTagTop    = 1030501,
    kUIViewBorderTagLeft   = 1030502,
    kUIViewBorderTagBottom = 1030503,
    kUIViewBorderTagRight  = 1030504
} kUIViewBorderTag;

@implementation UIView (Extensions)

- (void)logViewHierarchyAtLevel:(NSInteger)level {
	NSString *padding = @"";
	for (int i = 0; i < level; i++) {
		padding = [padding stringByAppendingFormat:@"    "];
	}
	NSLog(@"%@%@ (layer: %@)", padding, self, self.layer);
	for (UIView *aView in self.subviews) {
		[aView logViewHierarchyAtLevel:(level+1)];
	}
}

- (void)logViewHierarchy {
	[self logViewHierarchyAtLevel:0];
}

- (void)findMisbehavingScrollViewsIn:(UIView *)view
{
    if ([view isKindOfClass:[UIScrollView class]])
    {
        NSLog(@"Found UIScrollView: %@", view);
        if ([(UIScrollView *)view scrollsToTop])
        {
            NSLog(@"scrollsToTop = YES!");
            NSLog(@"%@",((UITableView *)view).delegate);
        }
    }
    for (UIView *subview in [view subviews])
    {
        [self findMisbehavingScrollViewsIn:subview];
    }
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY {
    CGFloat y = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
        
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
        
    } else {
        return nil;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterToSuperViewCenter:(UIView *)aSuperView {
    self.center = CGPointMake(floorf(aSuperView.width / 2.0), floorf(aSuperView.height / 2.0));
}

+ (CGAffineTransform)transformForOrientation:(UIInterfaceOrientation)orientation {
    CGFloat angle = 0;
    switch (orientation) {
        case UIDeviceOrientationPortrait:
            angle = 0;
            break;
        case UIDeviceOrientationLandscapeLeft:
            angle = M_PI / 2;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            angle = M_PI;
            break;
        case UIDeviceOrientationLandscapeRight:
            angle = 3 * M_PI / 2;
            break;
        default:
            break;
    }
    
    CGAffineTransform t = CGAffineTransformMakeRotation(angle);
    return t;
}

+ (CGAffineTransform)transformForStatusBarOrientation {
    return [self transformForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

- (void)addViewBorder:(kUIViewBorder)border withColor:(UIColor *)color lineWidth:(CGFloat)lineWidth {
    if (border & kUIViewBorderTop) {
        UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, lineWidth)];
        borderView.backgroundColor = color;
        borderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        borderView.tag = kUIViewBorderTagTop;
        [self addSubview:borderView];
    }
    if (border & kUIViewBorderBottom) {
        UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - lineWidth, self.width, lineWidth)];
        borderView.backgroundColor = color;
        borderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        borderView.tag = kUIViewBorderTagBottom;
        [self addSubview:borderView];
    }
    if (border & kUIViewBorderLeft) {
        UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lineWidth, self.height)];
        borderView.backgroundColor = color;
        borderView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        borderView.tag = kUIViewBorderTagLeft;
        [self addSubview:borderView];
    }
    if (border & kUIViewBorderRight) {
        UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(self.width - lineWidth, 0, lineWidth, self.height)];
        borderView.backgroundColor = color;
        borderView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        borderView.tag = kUIViewBorderTagRight;
        [self addSubview:borderView];
    }
}

- (void)removeViewBorders {
    [[self viewWithTag:kUIViewBorderTagTop]     removeFromSuperview];
    [[self viewWithTag:kUIViewBorderTagBottom]  removeFromSuperview];
    [[self viewWithTag:kUIViewBorderTagLeft]    removeFromSuperview];
    [[self viewWithTag:kUIViewBorderTagRight]   removeFromSuperview];
}

@end
