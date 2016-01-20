//
//  FiveStarView.h
//  TestTableApp
//
//  Created by Nick Newberg on 7/1/14.
//  Copyright (c) 2014 Nick Newberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FiveStarView : UIView

@property (strong, nonatomic) NSArray *stars;
@property int rating;

-(void) starChosen:(UIButton *) sender;
-(void) setRatingView: (int) rating;


@end
