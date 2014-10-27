//
//  PopupVC.h
//  ColorBlind
//
//  Created by Manted on 16/03/2014.
//  Copyright (c) 2014 Ye Hua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import <CoreData/CoreData.h>

@class ViewController;

@interface PopupVC : UIViewController

@property (nonatomic, strong) ViewController *vc;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *bestLabel;
@property (nonatomic, strong) UILabel *yourBestLabel;

-(void)setScore:(int)score;
- (IBAction)tryAgain:(id)sender;

@end
