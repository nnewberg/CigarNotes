//
//  TextFieldTableViewCell.m
//  CigarNotes
//
//  Created by Nick Newberg on 7/31/14.
//  Copyright (c) 2014 Nick Newberg. All rights reserved.
//

#import "TextFieldTableViewCell.h"

@implementation TextFieldTableViewCell

@synthesize theTextField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.theTextField = [[UITextField alloc] initWithFrame: CGRectMake(15, 8, 250, 30)];
        self.theTextField.placeholder = @"Cigar Name";
        self.theTextField.adjustsFontSizeToFitWidth = YES;
        //self.theTextField.minimumFontSize = 0;
        [self.contentView addSubview: self.theTextField];
    
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
