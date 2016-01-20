//
//  CigarNoteViewController.h
//  CigarNotes
//
//  Created by Nick Newberg on 8/4/14.
//  Copyright (c) 2014 Nick Newberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CigarNoteData.h"
#import "FiveStarView.h"
#import "InfoLabelField.h"
#import "ScoreTextField.h"

@interface CigarNoteViewController : UIViewController

@property (strong, nonatomic) CigarNoteData * cigarNoteData;
@property (strong, nonatomic) UIColor * mainColor;
@property (strong, nonatomic) UIColor * detailColor;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) FiveStarView * flavorStars;
@property (strong, nonatomic) FiveStarView * constructionStars;

@property (strong, nonatomic) InfoLabelField * dateInfo;
@property (strong, nonatomic) InfoLabelField * priceInfo;
@property (strong, nonatomic) InfoLabelField * timeInfo;
@property (strong, nonatomic) InfoLabelField * countryInfo;
@property (strong, nonatomic) InfoLabelField * sizeInfo;
@property (strong, nonatomic) UITextView * noteTextView;
@property (strong, nonatomic) ScoreTextField* scoreInfo;







@end
