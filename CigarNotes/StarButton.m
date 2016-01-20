//
//  StarButton.m
//  TestTableApp
//
//  Created by Nick Newberg on 6/30/14.
//  Copyright (c) 2014 Nick Newberg. All rights reserved.
//

#import "StarButton.h"

@implementation StarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.selected = NO;
        
        [self setBackgroundImage: [UIImage imageNamed: @"starButtonDeselected.png"] forState: UIControlStateNormal];
        
        //[self addTarget: self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
     
        
    }
    return self;
}

-(void)buttonClicked:(UIButton *)sender{
    
    NSLog(@"Click! Highlighted = %@", (self.selected) ? @"True" : @"False");
    
    if (!self.selected)
    {
        [self setBackgroundImage: [UIImage imageNamed: @"starButtonHighlighted.png"] forState:UIControlStateNormal];
        self.selected = YES;
    }
    else{
    
    [self setBackgroundImage: [UIImage imageNamed: @"starButtonDeselected.png"] forState: UIControlStateNormal];
    self.selected = NO;
    
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
