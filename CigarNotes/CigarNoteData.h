//
//  CigarNoteData.h
//  CigarNotes
//
//  Created by Nick Newberg on 7/31/14.
//  Copyright (c) 2014 Nick Newberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CigarNoteData : NSObject <NSCoding>

@property (strong, nonatomic) NSString* cigarName;

@property int cigarCount;
@property int flavorRating;
@property int constructionRating;
@property int cigarScore;



@property (strong, nonatomic) NSString* noteDate;
@property (strong, nonatomic) NSString* cigarPrice;
@property (strong, nonatomic) NSString* cigarTime;
@property (strong, nonatomic) NSString* cigarSize;
@property (strong, nonatomic) NSString* cigarCountry;
@property (strong, nonatomic) NSString* noteText;



-(id)initWithName:(NSString *) name;

@end
