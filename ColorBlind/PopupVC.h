//
//  PopupVC.h
//  NextNum
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
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestLabel;

-(void)setScore:(int)score;
- (IBAction)tryAgain:(id)sender;

@end