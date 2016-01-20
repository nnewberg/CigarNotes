//
//  InfoLabelField.h
//  CigarNotes
//
//  Created by Nick Newberg on 8/4/14.
//  Copyright (c) 2014 Nick Newberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoLabelField : UIView <UITextFieldDelegate>

@property (strong, nonatomic) UITextField * textField;

@property int maxLength;

- (id)initWithFrame:(CGRect)frame andName:(NSString *) name;

@end
