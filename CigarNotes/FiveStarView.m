//
//  FiveStarView.m
//  TestTableApp
//
//  Created by Nick Newberg on 7/1/14.
//  Copyright (c) 2014 Nick Newberg. All rights reserved.
//

#import "FiveStarView.h"
#import "StarButton.h"

@implementation FiveStarView
@synthesize stars;

- (id)initWithFrame:(CGRect)frame
{
    CGRect newFrame  = CGRectMake(frame.origin.x, frame.origin.y, 120 , 30);
    self = [super initWithFrame:newFrame];
    if (self) {
        
        StarButton *star1 = [[StarButton alloc] initWithFrame:CGRectMake(0, 5, 20 , 20)];
        [star1 addTarget:self action:@selector(starChosen:) forControlEvents:UIControlEventTouchUpInside];
        
        StarButton *star2 = [[StarButton alloc] initWithFrame:CGRectMake(25, 5, 20 , 20)];
        [star2 addTarget:self action:@selector(starChosen:) forControlEvents:UIControlEventTouchUpInside];

        StarButton *star3 = [[StarButton alloc] initWithFrame:CGRectMake(50, 5, 20 , 20)];
        [star3 addTarget:self action:@selector(starChosen:) forControlEvents:UIControlEventTouchUpInside];

        StarButton *star4 = [[StarButton alloc] initWithFrame:CGRectMake(75, 5, 20 , 20)];
        [star4 addTarget:self action:@selector(starChosen:) forControlEvents:UIControlEventTouchUpInside];
        
        StarButton *star5 = [[StarButton alloc] initWithFrame:CGRectMake(100, 5, 20 , 20)];
        [star5 addTarget:self action:@selector(starChosen:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview: star1];
        [self addSubview: star2];
        [self addSubview: star3];
        [self addSubview: star4];
        [self addSubview: star5];

        
        self.stars = [NSArray arrayWithObjects: star1, star2, star3, star4, star5, nil];

        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void) starChosen:(UIButton *) sender{
    
    int i;
    
    bool hitTarget = NO;
    
    for (i = 0; i < self.stars.count; i++){
        
        
        
        StarButton * theStar = [self.stars objectAtIndex: i];
        
        
        if (!theStar.selected && !hitTarget)
        {
            
            [theStar setBackgroundImage: [UIImage imageNamed: @"starButtonHighlighted.png"] forState:UIControlStateNormal];
            
        }
        else if (hitTarget)
        {
            [theStar setBackgroundImage: [UIImage imageNamed: @"starButtonDeselected.png"] forState:UIControlStateNormal];
            
        }
        
        if ([theStar isEqual: sender])
        {
            hitTarget = YES;
            self.rating = (i + 1);
            NSLog(@"Rating: %d", self.rating);
        }
        
        
        
    
    }


        
    }

-(void) setRatingView: (int) rating{
    
    if (rating)
    {
    [self starChosen:[self.stars objectAtIndex: (rating -1)]];
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
