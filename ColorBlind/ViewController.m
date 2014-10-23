//
//  ViewController.m
//  ColorBlind
//
//  Created by Manted on 22/10/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import "ViewController.h"
#import "ColorView.h"
#import "ProgressView.h"

@interface ViewController ()

@property (nonatomic) int score;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) ProgressView *progressView;
@property (nonatomic, strong) NSMutableArray *blocks;
@property (nonatomic) BOOL isPlaying;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.progressView];
    [self.progressView setTotalTime:5];
    [self.view addSubview:self.scoreLabel];
    self.score = 0;
    self.isPlaying = NO;
    [self addColorViews];
    [self resetColors];
}

#pragma mark - UI

-(ProgressView*)progressView
{
    if (!_progressView) {
        CGRect frame = self.view.bounds;
        float width = frame.size.width / 3;
        float x = (frame.size.width - width) / 2;
        float y = (frame.size.height - width) / 2;
        _progressView = [[ProgressView alloc]initWithFrame:CGRectMake(x, y, width, width)];
        _progressView.vc = self;
    }
    return _progressView;
}

-(UILabel*)scoreLabel
{
    if (!_scoreLabel) {
        CGRect frame = self.view.bounds;
        float width = frame.size.width / 3;
        float x = (frame.size.width - width) / 2;
        float y = (frame.size.height - width) / 2;
        _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, width)];
        [_scoreLabel setAdjustsFontSizeToFitWidth:YES];
        [_scoreLabel setBackgroundColor:[UIColor clearColor]];
        [_scoreLabel setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:40]];
        [_scoreLabel setTextColor:[UIColor blueColor]];
        [_scoreLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _scoreLabel;
}

-(UIView*)containerView
{
    if (!_containerView) {
        CGRect screen = [[UIScreen mainScreen]bounds];
        _containerView = [[UIView alloc]initWithFrame:screen];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

-(NSArray*)blocks
{
    if (!_blocks) {
        _blocks = [[NSMutableArray alloc]init];
    }
    return _blocks;
}

-(void)addColorViews
{
//    int blockCount = [self getBlockCount];
    int blockCount = 4;
    if (blockCount == [self.blocks count]) {
        return;
    } else {
        for (UIView* view in self.blocks) {
            [view removeFromSuperview];
        }
        [self.blocks removeAllObjects];
    }
    switch (blockCount) {
        case 2:
            [self addColorViews:@[@1, @1]];
            break;
        case 3:
            [self addColorViews:@[@1, @1, @1]];
            break;
        case 4:
            [self addColorViews:@[@2, @2]];
            break;
        case 5:
            [self addColorViews:@[@2, @1, @2]];
            break;
        case 6:
            [self addColorViews:@[@2, @2, @2]];
            break;
        case 7:
            [self addColorViews:@[@2, @3, @2]];
            break;
        case 8:
            [self addColorViews:@[@3, @2, @3]];
            break;
        case 9:
            [self addColorViews:@[@3, @3, @3]];
            break;
        case 10:
            [self addColorViews:@[@3, @2, @3, @2]];
            break;
        case 11:
            [self addColorViews:@[@2, @3, @3, @3]];
            break;
        case 12:
            [self addColorViews:@[@3, @3, @3, @3]];
            break;
        case 13:
            [self addColorViews:@[@2, @3, @4, @3]];
            break;
        case 14:
            [self addColorViews:@[@3, @4, @3, @4]];
            break;
        case 15:
            [self addColorViews:@[@3, @4, @4, @4]];
            break;
        case 16:
            [self addColorViews:@[@4, @4, @4, @4]];
            break;
        default:
            break;
    }
}

-(void)addColorViews:(NSArray*)array
{
    CGRect container = self.containerView.frame;
    float width = container.size.width;
    float height = container.size.height;
    int row = [array count];
    for (int i = 0; i < row; i++) {
        int col = [[array objectAtIndex:i] intValue];
        for (int j = 0; j < col; j++) {
            ColorView* view = [[ColorView alloc]initWithFrame:CGRectMake(j * width / col, i * height / row, width / col, height / row)];
            view.vc = self;
            [self.containerView addSubview:view];
            [self.blocks addObject:view];
        }
    }
}

-(void)resetColors
{
//    [self addColorViews];
    int count = 0;
    int correctIndex = arc4random() % [self.blocks count];
    for (UIView* v in self.blocks) {
        ColorView* view = (ColorView*)v;
        [view resetColor];
        [view setIsColorCorrect:count == correctIndex];
        count++;
    }
}

-(int)getBlockCount
{
    return self.score + 2 > 16 ? 16 : self.score + 2;
    if (self.score <= 2) {
        return 2;
    } else if (self.score <= 4) {
        return 3;
    } else if (self.score <= 6) {
        return 4;
    } else if (self.score <= 8) {
        return 5;
    } else if (self.score <= 10) {
        return 6;
    } else if (self.score <= 12) {
        return 7;
    } else if (self.score <= 14) {
        return 9;
    } else if (self.score <= 16) {
        return 10;
    } else if (self.score <= 18) {
        return 11;
    }
    return 12;
}

#pragma mark - game logic
-(void)play
{
    self.isPlaying = YES;
    [self resetColors];
    [self resetProgressView];
}

-(void)resetProgressView
{
    float time = MAX(5 - (self.score / 100.0) * 2 * log10f(self.score), 3);
//    float time1 = 5 - (20 / 100.0) * 2 * log10f(20);
//    float time2 = 5 - (40 / 100.0) * 2 * log10f(40);
//    float time3 = 5 - (60 / 100.0) * 2 * log10f(60);
//    NSLog(@"time1 = %f time2 = %f time3 = %f", time1, time2, time3);
    [self.progressView setTotalTime:time];
    [self.progressView start];
}

-(void)gameOver
{
    NSLog(@"game over");
    self.isPlaying = NO;
    [self.progressView stop];
    // show dialog
}

-(void)setScore:(int)score
{
    _score = score;
    [self.scoreLabel setText:[NSString stringWithFormat:@"%i", score]];
    float r = 1, g = 0, b = 0;
    if (score < 10) {
        r = 0;
        g = score / 10.0;
        b = 1;
    } else if (score < 20) {
        r = 0;
        g = 1;
        b = (20 - score) / 10.0;
    } else if (score < 30) {
        r = (score - 20) / 10.0;
        g = 1;
        b = 0;
    } else if (score < 40) {
        r = 1;
        g = (40 - score) / 10.0;
        b = 0;
    }
    UIColor* color = [UIColor colorWithRed:r green:g blue:b alpha:1];
    [self.scoreLabel setTextColor:color];
}

-(void)pressBlock:(BOOL)isCorrect
{
    if (isCorrect) {
        if (self.isPlaying) {
            self.score++;
            [self resetColors];
            [self resetProgressView];
        } else {
            self.score++;
            [self play];
        }
    } else {
        if (self.isPlaying) {
            [self gameOver];
        } else {
            [self resetColors];
        }
    }
}

@end
