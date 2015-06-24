//
//  CustomView.m
//  LearnCoreGraphics
//
//  Created by Hanying Zhang on 15/5/28.
//  Copyright (c) 2015年 myself. All rights reserved.
//


#import "CustomView.h"

IB_DESIGNABLE
@implementation CustomView

- (void)drawRect:(CGRect)rect
{
    [self drawCircle];
    [self drawCurve];
}

- (void)drawCircle;
{
    CGRect rect = CGRectMake(0, 0, self.frame.size.width * 0.5, self.frame.size.width * 0.5);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ref, rect);
    CGContextSetFillColorWithColor(ref, [UIColor redColor].CGColor);
    CGContextFillPath(ref);
}

- (void)drawCurve
{
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ref);
    CGContextMoveToPoint(ref, 0, self.frame.size.width * 0.5);
    //CGContextAddLineToPoint(ref, self.frame.size.width, self.frame.size.height);
    CGContextAddQuadCurveToPoint(ref, self.frame.size.width, self.frame.size.height * 0.5, self.frame.size.width, self.frame.size.height);
    CGContextSetLineWidth(ref, 2.0);
    CGContextSetStrokeColorWithColor(ref, [UIColor blueColor].CGColor);
    CGContextStrokePath(ref);
}

@end
