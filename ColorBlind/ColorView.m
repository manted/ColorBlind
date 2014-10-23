//
//  ColorView.m
//  ColorBlind
//
//  Created by Manted on 22/10/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import "ColorView.h"

#define COLOR_COUNT 7

@interface ColorView()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) BOOL isCorrect;
@property (nonatomic) int colorNum;

@end

@implementation ColorView

static NSArray* colors;
static NSArray* colorStrings;

+ (NSArray *)colors
{
    if (!colors) {
        colors = [[NSArray alloc] initWithObjects:
                  [UIColor blackColor],
                  [UIColor whiteColor],
                  [UIColor blueColor],
                  [UIColor greenColor],
                  [UIColor redColor],
                  [UIColor yellowColor],
                  [UIColor orangeColor],
                  [UIColor grayColor],
                  [UIColor purpleColor],
                  [UIColor brownColor], nil];
    }
    return colors;
}

+ (NSArray *)colorStrings
{
    if (!colorStrings) {
        colorStrings = [[NSArray alloc] initWithObjects:
                        @"BLACK",
                        @"WHITE",
                        @"BLUE",
                        @"GREEN",
                        @"RED",
                        @"YELLOW",
                        @"ORANGE",
                        @"GRAY",
                        @"PURPLE",
                        @"BROWN", nil];
    }
    return colorStrings;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addSubview:self.label];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1.0f;
    }
    return self;
}

-(UILabel*)label
{
    if (!_label) {
        // frame based on self.frame
        _label = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width * 0.1, 0, self.frame.size.width * 0.8, self.frame.size.height)];
        [_label setAdjustsFontSizeToFitWidth:YES];
        [_label setBackgroundColor:[UIColor clearColor]];
        [_label setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:40]];
        [_label setTextAlignment:NSTextAlignmentCenter];
    }
    return _label;
}

-(void)resetColor
{
    self.colorNum = arc4random() % COLOR_COUNT;
    self.color = [[ColorView colors] objectAtIndex:self.colorNum];
    [self setBackgroundColor:self.color];
}

-(void)setIsColorCorrect:(BOOL)isCorrect
{
    self.isCorrect = isCorrect;
    [self.label setTextColor:[self getLabelColor]];
    [self.label setText:[self getColorString]];
}

-(NSString*)getColorString
{
    int x = self.colorNum;
    if (!self.isCorrect) {
        x = arc4random() % COLOR_COUNT;
        while (x == self.colorNum) {
            x = arc4random() % COLOR_COUNT;
        }
    }
    return [[ColorView colorStrings] objectAtIndex:x];
}

-(UIColor*)getLabelColor
{
    int x = arc4random() % COLOR_COUNT;
    while (x == self.colorNum) {
        x = arc4random() % COLOR_COUNT;
    }
    return [[ColorView colors] objectAtIndex:x];
}

#pragma mark - touch
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self.vc pressBlock:self.isCorrect];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self touchesEnded:touches withEvent:event];
}

@end
