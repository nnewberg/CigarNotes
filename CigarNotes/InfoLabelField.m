//
//  InfoLabelField.m
//  CigarNotes
//
//  Created by Nick Newberg on 8/4/14.
//  Copyright (c) 2014 Nick Newberg. All rights reserved.
//

#import "InfoLabelField.h"

@implementation InfoLabelField

@synthesize textField, maxLength;

- (id)initWithFrame:(CGRect)frame andName:(NSString *) name
{
    CGRect newFrame = CGRectMake(15, frame.origin.y, 290, 30);
    
    self = [super initWithFrame:newFrame];

    if (self) {
        
        
        UIColor *mainColor = [UIColor colorWithRed:228.0/255 green:223.0/255 blue:213.0/255 alpha:100];
        UIColor *detailColor = [UIColor colorWithRed:83.0/255 green:108.0/255 blue:133.0/255 alpha:100];
        
        self.backgroundColor = detailColor;
        
        self.maxLength = 26;
        
        //Label
        name = [NSString stringWithFormat:@"%@:", name];
        
        UIFont *labelFont = [UIFont fontWithName:@"Futura" size: 15];
        CGSize labelFontSize = [name sizeWithAttributes:
                       @{NSFontAttributeName:
                             labelFont}];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, labelFontSize.width + 5, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.font = labelFont;
        label.textColor = mainColor;
        label.text = name;
        
        //Field
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake( labelFontSize.width + 10, 1
                                                                           , (290 - (labelFontSize.width + 10)), 30)];
        
        field.backgroundColor = [UIColor clearColor];
        field.textColor = mainColor;
        field.font = [UIFont fontWithName:@"Courier" size: 15];
        field.delegate = self;
        self.textField = field;
        
        [self addSubview: field];
        [self addSubview: label];

    
    }
    return self;
}

//return on return key 
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [self.textField resignFirstResponder];
    
    return YES;
    
}

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    NSUInteger oldLength = [self.textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= self.maxLength || returnKey;
    
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
