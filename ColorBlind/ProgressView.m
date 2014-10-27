//
//  ProgressView.m
//  ColorBlind
//
//  Created by Manted on 23/10/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView ()

@property (nonatomic) float totalTime;
@property (nonatomic) float currentTime;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat endAngle;
@property (nonatomic) float radius;

@end

@implementation ProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        // Determine our start and stop angles for the arc (in radians)
        self.startAngle = -M_PI_2;
        self.endAngle = self.startAngle - M_PI * 2;
        
        self.radius = frame.size.width / 2 * 0.7;
    }
    return self;
}

-(void)setTotalTime:(float)time
{
    _totalTime = time;
    _currentTime = _totalTime;
    [self setNeedsDisplay];
}

-(void)start
{
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}

-(void)stop
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)updateProgress
{
    if (self.currentTime > 0) {
        self.currentTime -= 0.01;
        [self setNeedsDisplay];
    } else {
        [self.timer invalidate];
        self.timer = nil;
        [self.vc gameOver];
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor whiteColor] setFill];
    CGContextAddArc(context, CGRectGetMidX(rect), CGRectGetMidY(rect),
                    CGRectGetWidth(rect) / 2.45, 0, 2 * M_PI, YES);
    CGContextFillPath(context);
    
    float percent = self.currentTime / self.totalTime;
    //    NSLog(@"%f", percent);
    if (percent <= 0) {
        return;
    }
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath setLineCapStyle:kCGLineCapRound];

    // Create our arc, with the correct angles
    [bezierPath addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2)
                          radius:self.radius
                      startAngle:self.startAngle
                        endAngle:(self.endAngle - self.startAngle) * percent + self.startAngle
                       clockwise:NO];
    
    // Set the display for the path, and stroke it
    bezierPath.lineWidth = 7;
    float r = MIN((1 - percent) * 2, 1);
    float g = MIN(percent * 2, 1);
    UIColor* color = [UIColor colorWithRed:r green:g blue:0 alpha:1];
    [color setStroke];
    [bezierPath stroke];
}

@end
