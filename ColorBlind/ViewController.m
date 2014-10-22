//
//  ViewController.m
//  ColorBlind
//
//  Created by Manted on 22/10/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import "ViewController.h"
#import "ColorView.h"

@interface ViewController ()

@property (nonatomic) int score;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) NSMutableArray *blocks;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.containerView];
    self.score = 0;
    [self resetColors];
}

#pragma mark - UI

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
    int blockCount = [self getBlockCount];
//    blockCount = 5;
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

//-(void)addColorsWithRow:(int)row col:(int)col midCol:(int)midCol
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
    [self addColorViews];
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
-(void)pressBlock:(BOOL)isCorrect
{
    NSLog(@"blocks count = %d", [[self.containerView subviews]count]);
    if (isCorrect) {
        self.score++;
        [self resetColors];
    } else {
        NSLog(@"game over");
        self.score = 0;
        [self resetColors];
    }
}

@end
