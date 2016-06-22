//
//  FISBlackjackViewController.m
//  objc-BlackJackViews
//
//  Created by Flatiron School on 6/21/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackViewController.h"
#import "FISCard.h"

@interface FISBlackjackViewController ()

@property (weak, nonatomic) IBOutlet UIButton *hitButton;
@property (weak, nonatomic) IBOutlet UIButton *stayButton;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;


@property (nonatomic) NSMutableArray *viewsArrayOfPlayerCards;
@property (nonatomic) NSMutableArray *viewsArrayOfHouseCards;


@end

@implementation FISBlackjackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetGame];

    self.game = [[FISBlackjackGame alloc] init];
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)deal:(UIButton *)sender {


    [self.game incrementWinsAndLossesForHouseWins:self.game.houseWins];
    [self resetGame];
    [self.game dealNewRound];
    [self checkForWin];

    
    self.hitButton.enabled = YES;
    self.stayButton.enabled = YES;
    self.dealButton.enabled = NO;
    
    
    
    //turn over player cards, display label
    self.playerCardLabel.hidden = NO;
    self.playerCard2Label.hidden = NO;
    FISCard *cardplayer1 = self.game.player.cardsInHand[0];
    self.playerCardLabel.text = cardplayer1.cardLabel;
    FISCard *cardplayer2 = self.game.player.cardsInHand[1];
    self.playerCard2Label.text = cardplayer2.cardLabel;
    
    
    
    //turn over house cards, display label
    self.houseCardLabel.hidden = NO;
    self.houseCard2Label.hidden = NO;
    FISCard *cardhouse1 = self.game.house.cardsInHand[0];
    self.houseCardLabel.text = cardhouse1.cardLabel;
    FISCard *cardhouse2 = self.game.house.cardsInHand[1];
    self.houseCard2Label.text = cardhouse2.cardLabel;
    
        [self scoreUpdate];
    
    
}

- (IBAction)hit:(UIButton *)sender {


    if ([self.game.player.cardsInHand count]== 2) {
        [self.game dealCardToPlayer];
        [self checkForWin];
        self.playerCard3Label.hidden = NO;
        FISCard *card = [self.game.player.cardsInHand lastObject];
        self.playerCard3Label.text = card.cardLabel;
    }else if ([self.game.player.cardsInHand count]== 3) {
        [self.game dealCardToPlayer];
        [self checkForWin];
        self.playerCard4Label.hidden = NO;
        FISCard *card = [self.game.player.cardsInHand lastObject];
        self.playerCard4Label.text = card.cardLabel;
    }else if ([self.game.player.cardsInHand count]== 4) {
        [self.game dealCardToPlayer];
        [self checkForWin];
        self.playerCard5Label.hidden = NO;
        FISCard *card = [self.game.player.cardsInHand lastObject];
        self.playerCard5Label.text = card.cardLabel;
    }

    
    [self housePlays];
    [self scoreUpdate];
    

}

- (IBAction)stay:(UIButton *)sender {
    
    self.stayButton.enabled = NO;
    [self checkForWin];
    self.dealButton.enabled = YES;
    self.playerStayedLabel.hidden = NO;
    self.houseScoreLabel.hidden = NO;
    self.winnerLabel.hidden = NO;
    
    [self housePlays];

    
    self.houseScoreLabel.text = [NSString stringWithFormat:@"Score %li", self.game.house.handscore];
    
}



//---helpers




-(void)resetGame{
    [self.game.player resetForNewGame];
    [self.game.deck resetDeck];
    self.game.player.handscore = 0;
    self.game.house.handscore = 0;
    
    self.houseScoreLabel.text = 0;
    self.playerScoreLabel.text = 0;
    
    self.houseScoreLabel.hidden = YES;

    
    self.winnerLabel.hidden = YES;
    self.houseStayedLabel.hidden = YES;
    self.playerStayedLabel.hidden = YES;
    self.houseBustLabel.hidden = YES;
    self.playerBustLabel.hidden = YES;
    self.houseBlackjackLabel.hidden = YES;
    self.playerBlackjackLabel.hidden = YES;
    self.playerBustLabel.hidden = YES;
    
    self.playerCardLabel.hidden = YES;
    self.playerCard2Label.hidden = YES;
    self.playerCard3Label.hidden = YES;
    self.playerCard4Label.hidden = YES;
    self.playerCard5Label.hidden = YES;
    
    self.houseCardLabel.hidden = YES;
    self.houseCard2Label.hidden = YES;
    self.houseCard3Label.hidden = YES;
    self.houseCard4Label.hidden = YES;
    self.houseCard5Label.hidden = YES;
    

}

    

-(void)buttonsBack{
    self.hitButton.enabled = NO;
    self.stayButton.enabled = NO;
    self.dealButton.enabled = YES;
}

-(void)checkForWin{
    if (self.game.player.busted || self.game.house.busted) {
        self.winnerLabel.text = @"You lost!";
        self.winnerLabel.hidden = NO;
        [self buttonsBack];
        if(self.game.player.busted){
            self.playerBustLabel.enabled = YES;
            self.houseBlackjackLabel.enabled = YES;
        }else if(self.game.house.busted){
            self.houseBustLabel.enabled = YES;
            self.playerBlackjackLabel.enabled = YES;
        }
        
    }else if(self.game.player.blackjack || self.game.house.blackjack){
        self.winnerLabel.text = @"You win!";
        self.winnerLabel.hidden = NO;
        [self buttonsBack];
        if(self.game.player.blackjack){
            self.playerBlackjackLabel.enabled = YES;
            self.houseBustLabel.enabled = YES;
        }else if(self.game.house.blackjack){
            self.houseBlackjackLabel.enabled = YES;
            self.playerBustLabel.enabled = YES;
        }
    }
}

-(void)scoreUpdate{
    //score updates for player
    self.playerWinsLabel.text = [NSString stringWithFormat:@"Wins %li", self.game.player.wins];
    self.playerLossesLabel.text = [NSString stringWithFormat:@"Losses %li", self.game.player.losses];
    self.playerScoreLabel.text = [NSString stringWithFormat:@"Score %li", self.game.player.handscore];
    
    //score updates for house
    self.houseWinsLabel.text = [NSString stringWithFormat:@"Wins %li", self.game.house.wins];
    self.houseLossesLabel.text = [NSString stringWithFormat:@"Losses %li", self.game.house.losses];
    self.houseScoreLabel.text = [NSString stringWithFormat:@"Score %li", self.game.house.handscore];
}

-(void)housePlays{
    if ([self.game.house.cardsInHand count]== 2) {
        [self.game dealCardToHouse];
        [self checkForWin];
        self.houseCard3Label.hidden = NO;
        FISCard *card = [self.game.house.cardsInHand lastObject];
        self.houseCard3Label.text = card.cardLabel;
    }else if ([self.game.house.cardsInHand count]== 3) {
        [self.game dealCardToHouse];
        [self checkForWin];
        self.houseCard4Label.hidden = NO;
        FISCard *card = [self.game.house.cardsInHand lastObject];
        self.houseCard4Label.text = card.cardLabel;
    }else if ([self.game.house.cardsInHand count]== 4) {
        [self.game dealCardToHouse];
        [self checkForWin];
        self.houseCard5Label.hidden = NO;
        FISCard *card = [self.game.house.cardsInHand lastObject];
        self.houseCard5Label.text = card.cardLabel;
    }
}

@end
