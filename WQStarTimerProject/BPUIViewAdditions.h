//
//  BPUIViewAdditions.h
//  VGEUtil
//
//  Created by Hunter Huang on 11/23/11.
//  Copyright (c) 2011 vge design. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(ws)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;
@property (nonatomic) CGFloat cornerRadius;

@property (nonatomic, readonly) UIViewController *controller;
@property (nonatomic, readonly) UINavigationController *navigationController;

+ (void)drawGradientInRect:(CGRect)rect withColors:(NSArray*)colors;

//水平居中
- (void)xCenterInView:(UIView *)view;
//垂直居中
- (void)yCentetInView:(UIView *)view;


- (void)paddingRight:(CGFloat)padding toSuper:(UIView *)to;
- (void)paddingBottom:(CGFloat)padding toSuper:(UIView *)to;
- (void)paddingLeft:(CGFloat)padding;
- (void)paddingTop:(CGFloat)padding;



/**
 将view的内容保存成image，即对view进行截屏
 */
- (UIImage *)captureView;

- (UIView *)nextTextResponder;
- (UIView *)firstTextResponder;

@end
