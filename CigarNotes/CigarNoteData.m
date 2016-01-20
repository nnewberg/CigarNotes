//
//  CigarNoteData.m
//  CigarNotes
//
//  Created by Nick Newberg on 7/31/14.
//  Copyright (c) 2014 Nick Newberg. All rights reserved.
//

#import "CigarNoteData.h"

@implementation CigarNoteData

@synthesize cigarName, cigarCount, cigarCountry, cigarPrice, cigarSize, cigarTime, noteDate, noteText, flavorRating, constructionRating, cigarScore;

-(id)initWithName:(NSString *) name{
    
    if (self = [super init]){
        
        self.cigarName = name;
        self.cigarCount = 1;
        
    }
    
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)anEncoder {
    
    [anEncoder encodeObject:self.cigarName forKey:@"cigarName"];
    [anEncoder encodeObject:[NSNumber numberWithInt: self.cigarCount] forKey:@"cigarCount"];
    [anEncoder encodeObject:[NSNumber numberWithInt: self.flavorRating] forKey:@"flavorRating"];
    [anEncoder encodeObject:[NSNumber numberWithInt: self.constructionRating] forKey:@"constructionRating"];
    [anEncoder encodeObject:self.cigarCountry forKey:@"cigarCountry"];
    [anEncoder encodeObject:self.cigarPrice forKey:@"cigarPrice"];
    [anEncoder encodeObject:self.cigarSize forKey:@"cigarSize"];
    [anEncoder encodeObject:self.cigarTime forKey:@"cigarTime"];
    [anEncoder encodeObject:self.noteDate forKey:@"noteDate"];
    [anEncoder encodeObject:self.noteText forKey:@"noteText"];
    [anEncoder encodeObject:[NSNumber numberWithInt: self.cigarScore] forKey:@"cigarScore"];




}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self) {
        
        self.cigarName = [aDecoder decodeObjectForKey:@"cigarName"];
        self.cigarCount = [[aDecoder decodeObjectForKey:@"cigarCount"] intValue];
        self.flavorRating = [[aDecoder decodeObjectForKey:@"flavorRating"] intValue];
        self.constructionRating = [[aDecoder decodeObjectForKey:@"constructionRating"] intValue];
        self.cigarCountry = [aDecoder decodeObjectForKey:@"cigarCountry"];
        self.cigarPrice = [aDecoder decodeObjectForKey:@"cigarPrice"];
        self.cigarSize = [aDecoder decodeObjectForKey:@"cigarSize"];
        self.cigarTime = [aDecoder decodeObjectForKey:@"cigarTime"];
        self.noteDate = [aDecoder decodeObjectForKey:@"noteDate"];
        self.noteText = [aDecoder decodeObjectForKey:@"noteText"];
        self.cigarScore = [[aDecoder decodeObjectForKey:@"cigarScore"] intValue];


    }
    return self;
}


@end
