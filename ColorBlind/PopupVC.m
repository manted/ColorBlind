//
//  PopupVC.m
//  NextNum
//
//  Created by Manted on 16/03/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import "PopupVC.h"

@interface PopupVC ()
@property (nonatomic) int score;

@end

@implementation PopupVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.scoreLabel];
    [self.view addSubview:self.bestLabel];
    [self.scoreLabel setText:[NSString stringWithFormat:@"%d",self.score]];
    [self.scoreLabel setTextColor:[self.vc getScoreColor:self.score]];
    NSInteger best = [[NSUserDefaults standardUserDefaults] integerForKey:BEST_SCORE];
    [self.bestLabel setText:[NSString stringWithFormat:@"%ld", best]];
    [self.bestLabel setTextColor:[self.vc getScoreColor:(int)best]];
    [self.view setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
}

-(void)setScore:(int)score
{
    _score = score;
//    [self.scoreLabel setText:[NSString stringWithFormat:@"%d",score]];
}

- (IBAction)tryAgain:(id)sender {
    [self.vc tryAgain];
}

-(UILabel*)scoreLabel
{
    if (!_scoreLabel) {
        CGRect frame = self.view.bounds;
        float width = frame.size.width / 2;
        float height = frame.size.height / 4;
        float x = (frame.size.width - width) / 2;
        float y = frame.size.height / 7;
        _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        [_scoreLabel setAdjustsFontSizeToFitWidth:YES];
        [_scoreLabel setBackgroundColor:[UIColor clearColor]];
        [_scoreLabel setFont:[UIFont fontWithName:@"Helvetica" size:60]];
        [_scoreLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _scoreLabel;
}

-(UILabel*)bestLabel
{
    if (!_bestLabel) {
        CGRect frame = self.view.bounds;
        float width = frame.size.width / 2;
        float height = frame.size.height / 8;
        float x = (frame.size.width - width) / 2;
        float y = frame.size.height * 0.55;
        _bestLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)];
        [_bestLabel setAdjustsFontSizeToFitWidth:YES];
        [_bestLabel setBackgroundColor:[UIColor clearColor]];
        [_bestLabel setFont:[UIFont fontWithName:@"Helvetica" size:32]];
        [_bestLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _bestLabel;
}

@end
