//
//  ViewController.h
//  ColorBlind
//
//  Created by Manted on 22/10/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

#define BEST_SCORE @"best"

@interface ViewController : UIViewController 

-(void)pressBlock:(BOOL)isCorrect;
-(void)gameOver;
-(void)tryAgain;

@end
