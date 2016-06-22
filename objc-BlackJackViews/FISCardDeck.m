//
//  FISCardDeck.m
//  OOP-Cards-Model
//
//  Created by Flatiron School on 6/15/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCardDeck.h"

@implementation FISCardDeck


-(instancetype)init{
    self = [self initWithRemainingCards:[[NSMutableArray alloc]init] dealtCards:[[NSMutableArray alloc]init]];
    return self;
}
-(instancetype)initWithRemainingCards:(NSMutableArray *)remainingCards
                           dealtCards:(NSMutableArray *)dealtCards{
    self = [super init];
    if(self){
        _remainingCards = remainingCards;
        _dealtCards = dealtCards;
        [self generateNewDeck];
    
    }
    return self;
}


-(void)generateNewDeck{
    
    
    for (NSString *suit in [FISCard validRanks]){
        for (NSString *rank in [FISCard validSuits]){
            FISCard *card = [[FISCard alloc]initWithSuit:rank rank:suit];
            [self.remainingCards addObject:card];

        }
            if ([self.remainingCards count] >= 52 ){
                break;
            }
    }
}


-(FISCard *)drawNextCard{
    FISCard *drawCard = [self.remainingCards lastObject];

    if ([self.remainingCards count] > 0){
    [self.remainingCards removeLastObject];
    [self.dealtCards addObject:drawCard];
    }else{
        NSLog(@"The deck is empty");

    }

  

    
    return drawCard;
    
}

-(void)resetDeck{
    [self gatherDealtCards];
    [self shuffleRemainingCards];
}
-(void)gatherDealtCards{
    [self.remainingCards addObjectsFromArray:self.dealtCards];
    [self.dealtCards removeAllObjects];

}
-(void)shuffleRemainingCards{
    {
       // NSUInteger count = [self count];
        for (NSUInteger i = 0; i < [self.remainingCards count]; ++i) {
            NSInteger exchangeIndex = arc4random_uniform(52);
            if (i != exchangeIndex) {
                [self.remainingCards exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
            }
        }
    }

}



- (NSString *)description {
    NSString *descriptionString = [NSString stringWithFormat:@"count:%lu \n cards:%@", [self.remainingCards count], self.remainingCards];
    return descriptionString;
    
}

@end
