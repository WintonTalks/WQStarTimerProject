//
//  BPUIViewAdditions.m
//  VGEUtil
//
//  Created by Hunter Huang on 11/23/11.
//  Copyright (c) 2011 vge design. All rights reserved.
//

#import "BPUIViewAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView(ws)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    if (cornerRadius>0) {
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    } else {
        self.layer.shouldRasterize = NO;
        self.layer.rasterizationScale = 1.0f;
    }
}

//水平居中
-(void)xCenterInView:(UIView *)view
{
    if (view == nil) {
        return;
    }
    
    CGFloat x = (view.width - self.width)/2;
    self.frame =  CGRectMake(x , self.top, self.width, self.height);
}

//垂直居中
-(void)yCentetInView:(UIView *)view
{
    if (view == nil) {
        return;
    }
    CGFloat y = (view.height - self.height)/2;
    self.frame =  CGRectMake(self.left , y, self.width, self.height);
}


- (void)paddingRight:(CGFloat)padding toSuper:(UIView *)to;
{
    if (!to) {
        return;
    }
    self.right = to.width - padding;
}

- (void)paddingLeft:(CGFloat)padding
{
    self.left = padding;
}

- (void)paddingTop:(CGFloat)padding
{
    self.top = padding;
}

- (void)paddingBottom:(CGFloat)padding toSuper:(UIView *)to;
{
    if (!to) {
        return;
    }
    self.bottom = to.height - padding;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (UIViewController *)controller
{
    UIResponder *next = self;
    do {
        next = [next nextResponder];
        if ([next isKindOfClass:[UIViewController class]]) {
            break;
        }
    } while (next!=nil&&![next isKindOfClass:[UIWindow class]]);
    if ([next isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)next;
    } else {
        return nil;
    }
}

- (UINavigationController *)navigationController
{
    UIResponder *next = self;
    do {
        next = [next nextResponder];
        if ([next isKindOfClass:[UINavigationController class]]) {
            break;
        }
    } while (next!=nil&&![next isKindOfClass:[UIWindow class]]);
    if ([next isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)next;
    } else {
        return nil;
    }
}

+ (void)drawGradientInRect:(CGRect)rect withColors:(NSArray*)colors
{	
	NSMutableArray *ar = [NSMutableArray array];
	for(UIColor *c in colors){
		[ar addObject:(id)c.CGColor];
	}
	
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	
	CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)ar, NULL);
	
	
	CGContextClipToRect(context, rect);
	
	CGPoint start = CGPointMake(0.0, 0.0);
	CGPoint end = CGPointMake(0.0, rect.size.height);
	
	CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
	
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
}

- (UIImage *)captureView {
    CGRect rect = self.frame;
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)findTextView:(NSArray *)subviews list:(NSMutableArray *)list
{
    for (UIView *view in subviews) {
        if ([view isKindOfClass:[UITextField class]]||[view isKindOfClass:[UITextView class]]) {
            [list addObject:view];
        }
        [self findTextView:view.subviews list:list];
    }
}

- (UIView *)nextTextResponder
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    [self findTextView:self.subviews list:list];
    
    [list sortUsingComparator:^NSComparisonResult(UIView *obj1, UIView *obj2) {
        CGPoint point1 = [self convertPoint:CGPointZero fromView:obj1];
        CGPoint point2 = [self convertPoint:CGPointZero fromView:obj2];
        if (point1.y>point2.y) {
            return NSOrderedDescending;
        } else if (point1.y==point2.y) {
            if (point1.x>point2.x) {
                return NSOrderedDescending;
            } else if (point1.x==point2.x) {
                return NSOrderedSame;
            } else {
                return NSOrderedAscending;
            }
        } else {
            return NSOrderedAscending;
        }
    }];
    
    BOOL findCurrentText = NO;
    
    for (UIView *view in list) {
        if ([view isFirstResponder]) {
            findCurrentText = YES;
        } else {
            if (findCurrentText) {
                return view;
                break;
            }
        }
    }
    
    return nil;
}

+ (UIView *)firstTextResponderWithRootView:(UIView *)rootView findFirstResponder:(BOOL *)findFirstResponder
{
    if ([rootView isFirstResponder]) {
        *findFirstResponder = YES;
        if ([rootView isKindOfClass:[UITextField class]]||[rootView isKindOfClass:[UITextView class]] || [rootView isKindOfClass:[UISearchBar class]]) {
            return rootView;
        } else {
            return nil;
        }
    }
    for (UIView *view in rootView.subviews) {
        UIView *result = [self firstTextResponderWithRootView:view findFirstResponder:findFirstResponder];
        if (*findFirstResponder) {
            return result;
        }
    }
    return nil;
}

- (UIView *)firstTextResponder
{
    BOOL findFirstResponder = NO;
    return [UIView firstTextResponderWithRootView:self findFirstResponder:&findFirstResponder];
}

@end
