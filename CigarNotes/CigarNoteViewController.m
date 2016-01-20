//
//  CigarNoteViewController.m
//  CigarNotes
//
//  Created by Nick Newberg on 8/4/14.
//  Copyright (c) 2014 Nick Newberg. All rights reserved.
//

#import "CigarNoteViewController.h"


@interface CigarNoteViewController ()

@property (strong, nonatomic) UILabel *countLabel;


@end

@implementation CigarNoteViewController

@synthesize  scrollView, cigarNoteData, mainColor, detailColor, countLabel, flavorStars, constructionStars, countryInfo, sizeInfo, dateInfo, priceInfo, noteTextView, scoreInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set Scroll View Size
    self.scrollView.contentSize = CGSizeMake(320, 1000);
    
    //Set Background Color
    self.view.backgroundColor = self.mainColor;
    
    //Configure Dynamic Nav Bar Title
    self.title = self.cigarNoteData.cigarName;
    UILabel* tlabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 40)];
    tlabel.text= self.navigationItem.title;
    tlabel.textColor= self.mainColor;
    tlabel.font = [UIFont fontWithName:@"Futura" size: 20.0];
    tlabel.backgroundColor =[UIColor clearColor];
    tlabel.adjustsFontSizeToFitWidth=YES;
    tlabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView=tlabel;
    
    //Set Save Button Font
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont fontWithName:@"Futura" size:16.0], NSFontAttributeName, mainColor, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    //Date Info
    self.dateInfo = [[InfoLabelField alloc] initWithFrame: CGRectMake(0, 15, 0, 0) andName:@"Date"];
    self.dateInfo.textField.text = self.cigarNoteData.noteDate;
    self.dateInfo.maxLength = 14;
    [self.scrollView addSubview: self.dateInfo];
    
    //Price Info
    self.priceInfo = [[InfoLabelField alloc] initWithFrame: CGRectMake(0, 45, 0, 0) andName:@"Price"];
    self.priceInfo.textField.text = self.cigarNoteData.cigarPrice;
    self.priceInfo.maxLength = 14;
    [self.scrollView addSubview: self.priceInfo];
    
    //Smoking Time Info
    self.timeInfo = [[InfoLabelField alloc] initWithFrame: CGRectMake(0, 75, 0, 0) andName:@"Smoking Time"];
    self.timeInfo.textField.text = self.cigarNoteData.cigarTime;
    self.timeInfo.maxLength = 7;
    [self.scrollView addSubview: self.timeInfo];
    
    
    //Cigar Count Interaction////////////////////////////////////
    
    UIView *countMask = [[UIView alloc] initWithFrame:CGRectMake(200, 15, 120, 120)];
    countMask.backgroundColor = mainColor;
    
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 25, 45, 45)];
    self.countLabel.backgroundColor = detailColor;
    self.countLabel.layer.cornerRadius = 22;
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.font = [UIFont fontWithName:@"Futura" size: 18];
    self.countLabel.textColor = mainColor;
    self.countLabel.text = [NSString stringWithFormat:@"%d", self.cigarNoteData.cigarCount];
    
    UIButton *incrCountButton = [[UIButton alloc] initWithFrame:CGRectMake(51, 4, 23, 15)];
    [incrCountButton setImage:[UIImage imageNamed:@"upCaret.png"] forState:UIControlStateNormal];
    [incrCountButton addTarget:self action:@selector(incrCount) forControlEvents:UIControlEventTouchDown];

    UIButton *decrCountButton = [[UIButton alloc] initWithFrame:CGRectMake(51, 76, 23, 15)];
    [decrCountButton setImage:[UIImage imageNamed:@"downCaret.png"] forState:UIControlStateNormal];
    [decrCountButton addTarget:self action:@selector(decrCount) forControlEvents:UIControlEventTouchDown];

    [countMask addSubview:countLabel];
    [countMask addSubview: incrCountButton];
    [countMask addSubview: decrCountButton];
    [self.scrollView addSubview:countMask];

    //////////////////////////////////////////////////////////////
    
    
    //Size Info
    self.sizeInfo = [[InfoLabelField alloc] initWithFrame: CGRectMake(0, 120, 0, 0) andName:@"Size"];
    self.sizeInfo.textField.text = self.cigarNoteData.cigarSize;
    [self.scrollView addSubview: self.sizeInfo];

    //Country Info
   self.countryInfo = [[InfoLabelField alloc] initWithFrame: CGRectMake(0, 150, 0, 0) andName:@"Country"];
    self.countryInfo.textField.text = self.cigarNoteData.cigarCountry;
    [self.scrollView addSubview: self.countryInfo];
    
    
    //Flavor Star Rating
    UILabel *flavorLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 200, 80, 35)];
    flavorLabel.font = [UIFont fontWithName:@"Futura" size: 20];
    flavorLabel.text = @"Flavor";
    flavorLabel.textColor = detailColor;
    
    self.flavorStars = [[FiveStarView alloc] initWithFrame:CGRectMake(100, 205, 0, 0)];
    [self.flavorStars setRatingView: self.cigarNoteData.flavorRating];
    [self.scrollView addSubview: flavorLabel];
    [self.scrollView addSubview: self.flavorStars];

    
    //Construction Star Rating
    UILabel *constructionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 250, 120, 35)];
    constructionLabel.font = [UIFont fontWithName:@"Futura" size: 20];
    constructionLabel.text = @"Construction";
    constructionLabel.textColor = detailColor;
    
    self.constructionStars = [[FiveStarView alloc] initWithFrame:CGRectMake(150, 255, 0, 0)];
    [self.constructionStars setRatingView: self.cigarNoteData.constructionRating];
    [self.scrollView addSubview: constructionLabel];
    [self.scrollView addSubview: self.constructionStars];
    
    
    
    //Note Text Field
    UILabel *noteLabel = [[UILabel alloc] initWithFrame: CGRectMake(15, 300, 50, 30)];
    noteLabel.text = @"Notes:";
    noteLabel.textColor = detailColor;
    noteLabel.font = [UIFont fontWithName:@"Futura" size:15];
    
    self.noteTextView = [[UITextView alloc] initWithFrame: CGRectMake(15, 330, 290, 290)];
    self.noteTextView.text = self.cigarNoteData.noteText;
    self.noteTextView.font = [UIFont fontWithName:@"Courier" size:15];
    self.noteTextView.textColor = detailColor;
    self.noteTextView.backgroundColor = [UIColor clearColor];
    self.noteTextView.layer.borderWidth = 1.0f;
    self.noteTextView.layer.borderColor = [detailColor CGColor];
    [self.scrollView addSubview: noteLabel];
    [self.scrollView addSubview: self.noteTextView];
    
    
    //Score Info
    self.scoreInfo = [[ScoreTextField alloc] initWithFrame: CGRectMake(85, 635, 0, 0)];
    self.scoreInfo.delegate = self.scoreInfo;
    if (self.cigarNoteData.cigarScore != 0)
    {
    self.scoreInfo.text = [NSString stringWithFormat: @"%d", self.cigarNoteData.cigarScore];
    }
    [self.scrollView addSubview: self.scoreInfo];
    
    
    //Cigar Notes Logo
    
    UIImage* logoImage = [UIImage imageNamed:@"CigarNotesLogo.png"];
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:logoImage];
    logoImageView.frame = CGRectMake(110, 900, 100, 100);
    [self.scrollView addSubview: logoImageView];
}


//Handles Increment and Decrement of Cigar Count
-(void) incrCount{
    
    self.cigarNoteData.cigarCount += 1;
    self.countLabel.text = [NSString stringWithFormat: @"%d", self.cigarNoteData.cigarCount ];
}

-(void) decrCount{
    
    int newCount = self.cigarNoteData.cigarCount - 1;
    
    if (newCount >= 0)
    {
    self.cigarNoteData.cigarCount = newCount;
    self.countLabel.text = [NSString stringWithFormat: @"%d",self.cigarNoteData.cigarCount ];
    }
}

//Save Cigar Data
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
    self.cigarNoteData.cigarCount = [self.countLabel.text integerValue];
    self.cigarNoteData.flavorRating = self.flavorStars.rating;
    self.cigarNoteData.constructionRating = self.constructionStars.rating;
    self.cigarNoteData.noteDate = self.dateInfo.textField.text;
    self.cigarNoteData.noteText = self.noteTextView.text;
    self.cigarNoteData.cigarSize = self.sizeInfo.textField.text;
    self.cigarNoteData.cigarCountry = self.countryInfo.textField.text;
    self.cigarNoteData.cigarPrice = self.priceInfo.textField.text;
    self.cigarNoteData.cigarTime = self.timeInfo.textField.text;
    self.cigarNoteData.cigarScore = [self.scoreInfo.text intValue];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
