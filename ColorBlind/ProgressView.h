//
//  ProgressView.h
//  ColorBlind
//
//  Created by Manted on 23/10/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@class ViewController;

@interface ProgressView : UIView

@property (nonatomic,strong) ViewController *vc;

-(void)setTotalTime:(float)time;
-(void)start;
-(void)stop;

@end
