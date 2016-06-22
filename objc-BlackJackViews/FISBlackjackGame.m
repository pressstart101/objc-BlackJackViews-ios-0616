//
//  FISBlackjackGame.m
//  BlackJack
//
//  Created by Flatiron School on 6/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackGame.h"

@implementation FISBlackjackGame


-(instancetype)init{
    self = [super init];
    if (self){
        _deck = [[FISCardDeck alloc]init];
        _house = [[FISBlackjackPlayer alloc]initWithName:@"House"];
        _player = [[FISBlackjackPlayer alloc]initWithName:@"Player"];
        
    }
    return self;
}

-(void)playBlackjack{
    [self.deck resetDeck];
    [self dealNewRound];
    for (NSUInteger i; i<3; i++){
        [self dealCardToPlayer];
        if (self.player.busted) {
            break;
        }
        [self dealCardToHouse];
        if (self.house.busted) {
            break;
        }
    }
    if (self.houseWins){
        [self incrementWinsAndLossesForHouseWins:YES];
    }
    NSLog(@"player%@", self.player);
    NSLog(@"house%@", self.house);
    //loop max 3
    // inside loop: player turn, house turn,
    //as soon as house or player bust- round over
    //check for bust after each round by checking house busted? player busted?
    //use break inside loop
}
-(void)dealNewRound{
    for (NSUInteger i = 0; i<2; i++){
    [self dealCardToPlayer];
    [self dealCardToHouse];
    }
}
-(void)dealCardToPlayer{
    FISCard *newCard = [self.deck drawNextCard];
    [self.player acceptCard:newCard];

}
-(void)dealCardToHouse{
    FISCard *newCard = [self.deck drawNextCard];
    [self.house acceptCard:newCard];
}
-(void)processPlayerTurn{
    if(self.player.shouldHit && self.player.stayed == NO && self.player.busted == NO){
        [self dealCardToPlayer];
    }
    
}
-(void)processHouseTurn{
    if(self.house.shouldHit && self.house.stayed == NO && self.house.busted ==NO){
        [self dealCardToHouse];
    }
}


-(BOOL)houseWins{
    if (self.house.blackjack && self.player.blackjack){
        return NO;
    }else if(self.house.busted){
        return NO;
    }else if(self.player.busted){
        return YES;
    }else if(self.house.handscore >= self.player.handscore){
        return YES;
    }
    return NO;
}
-(void)incrementWinsAndLossesForHouseWins:(BOOL)houseWins{
    
    
    if (houseWins == NO) {
                self.house.losses +=1;
                NSLog(@"%lu", self.house.losses);
                self.player.wins +=1;
                NSLog(@"%lu", self.player.wins);
    }else{
                self.house.wins +=1;
        self.player.losses +=1;
                NSLog(@"%lu", self.house.wins);
    }
    
}
@end
