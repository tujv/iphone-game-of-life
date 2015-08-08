//
//  ViewController.h
//  PocketLife
//
//  Created by tujv on 18/10/12.
//  Copyright (c) 2012 tujv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LifeView.h"

@interface ViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UIBarButtonItem *btnRun;
    IBOutlet UIScrollView *scrollView;
}

-(IBAction)onRunTapped:(id)sender;
-(IBAction)clearBoard:(id)sender;
-(void)setStopped;

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) LifeView *life;

@end
