//
//  FISCard.m
//  OOP-Cards-Model
//
//  Created by Flatiron School on 6/15/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCard.h"

@interface FISCard ()
@property (strong, nonatomic, readwrite)NSString *suit;
@property (strong, nonatomic, readwrite)NSString *rank;
@property(strong, nonatomic, readwrite)NSString *cardLabel;

@property (nonatomic, readwrite)NSUInteger cardValue;
@end

@implementation FISCard
+(NSArray *)validSuits{
    NSArray *validSuitsArray = @[@"♠", @"♥", @"♣", @"♦"];
    return validSuitsArray;
}
+(NSArray *)validRanks{
    NSArray *validRankArray = @[@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    return validRankArray;
}

-(instancetype)init{
    self = [self initWithSuit:@"!" rank:@"N"];
    return self;
}
-(instancetype)initWithSuit:(NSString *)suit
                       rank:(NSString *)rank{
    self = [super init];
    if (self){
        _suit = suit;
        _rank = rank;
        _cardLabel = [NSString stringWithFormat:@"%@%@", suit, rank];
        
        NSInteger rankInt = [[FISCard validRanks]indexOfObject:rank]+1;
        if (rankInt <10){
        _cardValue = [[FISCard validRanks]indexOfObject:rank]+1;
        }else{
            _cardValue = 10;
        }

    }
    return self;
}

- (NSString *)description {
    NSString *descriptionString = [NSString stringWithFormat:@"%@", self.cardLabel];
    return descriptionString;
    
}


@end
