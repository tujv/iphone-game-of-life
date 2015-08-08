//
//  LifeView.m
//  PocketLife
//
//  Created by tujv on 18/10/12.
//  Copyright (c) 2012 tujv. All rights reserved.
//

#import "ViewController.h"
#import "LifeView.h"
#import "Life.h"

Life *theGame;
CGRect visibleRect;

@implementation LifeView

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
  CGPoint location = [recognizer locationInView:self];
  [theGame setPos:(int)(location.y/50) + 1 y:(int)(location.x/50) + 1 selected:NO];
}

-(void)handleSwipe:(UISwipeGestureRecognizer*) swipeRecognizer {
  [theGame toggle];
}

-(void)handleLongPress:(UILongPressGestureRecognizer*) longPressRecognizer {
  NSLog(@"Long press detected!");
  CGPoint location = [longPressRecognizer locationInView:self];
  
  if([theGame pos:(int)(location.y/50) + 1 y:(int)(location.x/50) + 1] > 0)
  {
    [theGame toggle];
    [theGame setPos:(int)(location.y/50) + 1 y:(int)(location.x/50) + 1 selected:YES];
  }
}


-(id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    theGame = [Life new];
    theGame.drawingboard = self;
    [theGame setup];
  }
  
  UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector (handleLongPress:)];
  
  [self addGestureRecognizer:singleFingerTap];
  [self addGestureRecognizer:longPress];
  
  return self;
}

-(void) toggleOff {
  NSLog(@"toggleOff");
  ViewController* vc = (ViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
  [vc setStopped];
}

// Read out the contents of the life board
// and render it to screen
- (void)drawRect:(CGRect)rect {
  
  int xborder=0;
  int yborder=0;
  int blocksize=50;
  const int BOARD_X = 24;
  const int BOARD_Y = 24;
  
  CGRect thisrect;
  int pos;

  for(int i=1;i<BOARD_X-2;i++)
    for(int j=1; j<BOARD_Y-2;j++)
    {
      thisrect = CGRectMake(((j-1)*blocksize)+xborder+(j-1), ((i-1)*blocksize)+yborder+(i-1), blocksize, blocksize);
      pos = [theGame pos:i y:j];
      if(pos > 0)
      {
        if(pos == 2)
          [[UIColor greenColor] set];
        else
          [[UIColor blueColor] set];
      }
      else
      {
        [[UIColor whiteColor] setFill];
      }
      UIRectFill(thisrect);
    }
}

-(bool) startStop
{
  [theGame toggle];
  return [theGame stopped];
}

-(void)reset
{
  [theGame reset];
}

@end
