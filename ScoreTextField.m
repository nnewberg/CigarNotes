//
//  ScoreTextField.m
//  CigarNotes
//
//  Created by Nick Newberg on 8/5/14.
//  Copyright (c) 2014 Nick Newberg. All rights reserved.
//

#import "ScoreTextField.h"

@implementation ScoreTextField


- (id)initWithFrame:(CGRect)frame
{
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, 150, 150);
    
    self = [super initWithFrame: newFrame];
    if (self) {
        
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.backgroundColor = [UIColor colorWithRed:83.0/255 green:108.0/255 blue:133.0/255 alpha:100];
        self.textColor =  [UIColor colorWithRed:228.0/255 green:223.0/255 blue:213.0/255 alpha:100];
        self.font = [UIFont fontWithName:@"Futura" size:60];
        self.textAlignment = NSTextAlignmentCenter;
        self.placeholder = @"100";
        self.layer.cornerRadius = 75;


    }
    return self;
}

//Limit Characters
- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger oldLength = [self.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;

    
    if (!string.length || [string isEqualToString:@"0"]){
        
        
        return newLength <= 3 || returnKey;;
    }
    
    else if (![string intValue]){
        
        NSLog(@"NEIN! %@", string);
        return NO;
    }
    
    else {
       
    return newLength <= 3 || returnKey;
    
    }
}

//return on return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    [self resignFirstResponder];
    
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
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
