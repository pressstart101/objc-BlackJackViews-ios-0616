//
//  FISBlackjackPlayer.m
//  BlackJack
//
//  Created by Flatiron School on 6/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackPlayer.h"

@implementation FISBlackjackPlayer


-(instancetype)init{
    self = [self initWithName:@""];
    return self;
}
-(instancetype)initWithName:(NSString *)name{
    self = [super init];
    if (self){
        _name = name;
        _cardsInHand = [[NSMutableArray alloc]init];
        _aceInHand = NO;
        _blackjack = NO;
        _busted = NO;
        _stayed = NO;
        _handscore = 0;
        _wins = 0;
        _losses = 0;
        
    }
    return self;
}
-(void)resetForNewGame{
    
    
    [self.cardsInHand removeAllObjects];
    self.handscore = 0;
    self.aceInHand = NO;
    self.blackjack = NO;
    self.busted = NO;
    self.stayed = NO;
    
}
-(void)acceptCard:(FISCard *)card{
  
    
    [self.cardsInHand addObject:card];
        self.handscore += card.cardValue;

    for (FISCard *currentCard in self.cardsInHand) {
        if (currentCard.cardValue == 1) {
            //if ([currentCard.rank isEqual:@"A"]) {
            self.aceInHand = YES;
        }
    }
    
    if(self.aceInHand && self.handscore <= 11){
        self.handscore +=10;
    }
    
    if ([self.cardsInHand count] == 2 && self.handscore == 21){
        self.blackjack = YES;
    }
    if (self.handscore > 21) {
        self.busted = YES;
    }

//    NSLog(@"\n\n\n\\n\n\n %lu \n\n\n\n\n\n\n\n", self.handscore);

}
-(BOOL)shouldHit{
    if (self.handscore > 17){
        self.stayed = YES;
        return NO;
    }
    return YES;
}

- (NSString *)description {
    NSMutableString *descriptionString = [NSMutableString stringWithFormat:@"name:%@\n cards:%@\n handscore:%lu\n ace in hand:%d\n stayed:%d\n blackjack:%d\n busted:%d\n wins:%lu\n losses:%lu", self.name, self.cardsInHand, self.handscore, self.aceInHand, self.stayed, self.blackjack, self.busted, self.wins, self.losses];
    return descriptionString;
    
}






@end
