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
    [self.scoreLabel setText:[NSString stringWithFormat:@"%d",self.score]];
    [self.bestLabel setText:[NSString stringWithFormat:@"%ld", (long)[[NSUserDefaults standardUserDefaults] integerForKey:BEST_SCORE]]];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
}

-(void)setScore:(int)score
{
    _score = score;
    [self.scoreLabel setText:[NSString stringWithFormat:@"%d",score]];
}

- (IBAction)tryAgain:(id)sender {
    [self.vc tryAgain];
}

@end
