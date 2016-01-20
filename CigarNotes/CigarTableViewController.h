//
//  CigarTableViewController.h
//  CigarNotes
//
//  Created by Nick Newberg on 7/31/14.
//  Copyright (c) 2014 Nick Newberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CigarTableViewController : UITableViewController <UITableViewDelegate, UITextFieldDelegate>

@property (strong,nonatomic) UIColor* mainColor;

@property (strong, nonatomic) UIColor* detailColor;

@property (strong, nonatomic) NSMutableArray* cigars;

- (IBAction)plusAddCigar:(id)sender;

- (IBAction)unwindToHumidor:(UIStoryboardSegue *)segue;


@end
