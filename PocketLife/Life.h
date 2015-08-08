//
//  Life.h
//  PocketLife
//
//  Created by tujv on 16/11/12.
//  Copyright (c) 2012 tujv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LifeView.h"

@interface Life : NSObject

@property LifeView* drawingboard;

-(void) setup;
-(int) pos:(int)x y:(int)y;
-(void) setPos:(int)x y:(int)y selected:(bool)makeSelection;
-(void) toggle;
-(void) next;
-(void) off;
-(void) selectGrid:(int)x y:(int)y;
-(bool) stopped;
-(void) reset;

@end

