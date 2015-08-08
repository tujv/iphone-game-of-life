//
//  ViewController.m
//  PocketLife
//
//  Created by tujv on 18/10/12.
//  Copyright (c) 2012 tujv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize scrollView, life;

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  LifeView *temp_life = [[LifeView alloc] initWithFrame:CGRectMake(0, 0, 1075, 1075)];
  self.life = temp_life;

  // Do any additional setup after loading the view, typically from a nib.
  
  scrollView.contentSize = CGSizeMake(1050, 1050);
  scrollView.maximumZoomScale = 2.0;
  scrollView.minimumZoomScale = 0.50;
  scrollView.clipsToBounds = YES;
  scrollView.bounces = YES;
  scrollView.delegate = self;
  
  [scrollView addSubview:life];
  [UIApplication sharedApplication].keyWindow.rootViewController = self;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
  return life;
}

-(IBAction)onRunTapped:(id)sender
{
  if([life startStop])
    [btnRun setTitle: @"Continue"];
  else
    [btnRun setTitle: @"Pause"];
}

-(void)setStopped
{
  NSLog(@"toggle off");
  [btnRun setTitle: @"Start"];
}

-(IBAction)clearBoard:(id)sender
{
  [self setStopped];
  [life reset];
  [life startStop];
}


@end
