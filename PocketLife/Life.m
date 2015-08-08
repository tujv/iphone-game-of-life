//
//  Life.m
//  PocketLife
//
//  Created by tujv on 16/11/12.
//  Copyright (c) 2012 tujv. All rights reserved.
//

#import "Life.h"

@implementation Life
@synthesize drawingboard;

int iteration = 0;
const int limit = 15;
bool stop;

const int BOARD_X = 24;
const int BOARD_Y = 24;
int board[BOARD_X][BOARD_Y];

// RULES:
// Any live cell with fewer than two live neighbours dies, as if caused by under-population.
// Any live cell with two or three live neighbours lives on to the next generation.
// Any live cell with more than three live neighbours dies, as if by overcrowding.
// Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

int newboard[BOARD_X][BOARD_Y];

-(void) next
{
  int neighbours = 0;
  
  if(stop == NO)
  {
    for(int x=1;x<BOARD_X-2;x++)
      for(int y=1;y<BOARD_Y-2;y++)
        newboard[x][y] = board[x][y];
    
    for(int x=1;x<BOARD_X-2;x++)
      for(int y=1;y<BOARD_Y-2;y++)
      {
        neighbours = 0;
        
        if(board[x-1][y-1] == 1) neighbours++;
        if(board[x+1][y+1] == 1) neighbours++;
        
        if(board[x][y-1] == 1) neighbours++;
        if(board[x-1][y] == 1) neighbours++;
        
        if(board[x+1][y] == 1) neighbours++;
        if(board[x][y+1] == 1) neighbours++;
        
        if(board[x+1][y-1] == 1) neighbours++;
        if(board[x-1][y+1] == 1) neighbours++;
        
        // Live Cell
        if(board[x][y] == 1)
        {
          if(neighbours<2) newboard[x][y] = 0;
          if(neighbours>3) newboard[x][y] = 0;
          
          if( (neighbours == 2) || (neighbours == 3)) newboard[x][y] = 1;
        }
        
        // Dead Cell
        if(board[x][y] == 0)
        {
          if(neighbours == 3) newboard[x][y] = 1;
        }
        
      }
    
    int testy=0;
    
    for(int x=1;x<BOARD_X-2;x++)
      for(int y=1;y<BOARD_Y-2;y++)
      {
        if(board[x][y] != newboard[x][y])
        {
          board[x][y] = newboard[x][y];
          testy = 1;
        }
      }
    
    if(testy == 0)
    {
      NSLog(@"End of simulation");
      stop = YES;
      [drawingboard performSelector:@selector(toggleOff) withObject:nil];
    }
    
    
    [self performSelector:@selector(next) withObject:nil afterDelay:0.2];
    
    
    [drawingboard setNeedsDisplay];
  }
}

-(void) off
{
  stop = YES;
}

-(void) toggle
{
  if(stop == YES)
  {
    stop = NO;
    
    iteration = 0;
    [self performSelector:@selector(next) withObject:nil afterDelay:0.2];
  }
  else
  {
    stop = YES;
  }
}


-(void) setup
{
  
  // Seed
  
  board[1][2] = 1;
  board[2][3] = 1;
  board[3][1] = 1;
  board[3][2] = 1;
  board[3][3] = 1;
  
  stop = NO;
  [self performSelector:@selector(next) withObject:nil afterDelay:0.2];
}

-(int) pos:(int)x y:(int)y
{
  return board[x][y];
}



-(void) selectGrid:(int)x y:(int)y
{
  if(board[x-1][y-1] == 1) { board[x-1][y-1] = 2; [self selectGrid:(x-1) y:(y-1)]; }
  if(board[x+1][y+1] == 1) { board[x+1][y+1] = 2; [self selectGrid:x+1 y:y+1]; }
  
  if(board[x][y-1] == 1) { board[x][y-1] = 2; [self selectGrid:x y:y-1]; }
  if(board[x-1][y] == 1) { board[x-1][y] = 2; [self selectGrid:x-1 y:y]; }
  
  if(board[x+1][y] == 1) { board[x+1][y] = 2; [self selectGrid:x+1 y:y]; }
  if(board[x][y+1] == 1){ board[x][y+1] = 2; [self selectGrid:x y:y+1]; }
  
  if(board[x+1][y-1] == 1) { board[x+1][y-1] = 2; [self selectGrid:x+1 y:y-1]; }
  if(board[x-1][y+1] == 1) { board[x-1][y+1] = 2; [self selectGrid:x-1 y:y+1]; }
}

-(bool) stopped
{
  return stop;
}

-(void) setPos:(int)x y:(int)y selected:(bool)makeSelection
{
  
  if(makeSelection) {
    board[x][y] = 2;
    [self selectGrid:x y:y];
  } else {
    if(board[x][y] == 1)
      board[x][y] = 0;
    else
      board[x][y] = 1;
  }
  
  [drawingboard setNeedsDisplay];
}

-(void) reset
{
  for(int x=1;x<BOARD_X-2;x++)
    for(int y=1;y<BOARD_Y-2;y++)
      board[x][y] = 0;
}

@end
