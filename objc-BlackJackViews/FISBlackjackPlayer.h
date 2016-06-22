//
//  FISBlackjackPlayer.h
//  BlackJack
//
//  Created by Flatiron School on 6/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISCard.h"

@interface FISBlackjackPlayer : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSMutableArray *cardsInHand;
@property (nonatomic, assign) BOOL aceInHand;
@property (nonatomic, assign) BOOL blackjack;
@property (nonatomic, assign) BOOL busted;
@property (nonatomic, assign) BOOL stayed;
@property (nonatomic) NSUInteger handscore;
@property (nonatomic) NSUInteger wins;
@property (nonatomic) NSUInteger losses;



-(instancetype)init;
-(instancetype)initWithName:(NSString *)name;
-(void)resetForNewGame;
-(void)acceptCard:(FISCard *)card;
-(BOOL)shouldHit;


@end
