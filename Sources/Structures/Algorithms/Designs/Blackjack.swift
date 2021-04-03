//
//  Blackjack.swift
//  
//
//  Created by Wayne Bishop on 3/17/21.
//

import Foundation

class Blackjack : Playable {
    
    var players = Array<Player>()
    var deck = Deck()
    var discard = Array<Card>()
    
    /*
     note: in addition to the specified based model, an additional
     hasStarted property could also be added at the level preventing
     new players to the model once the game has started.
     */
    
    public init() {
        //randomize the deck
        deck.shuffle()
    }

    
    
    //MARK: Playable protocol conformance
    
    
    //deal cards to player
    func deal(_ player: inout Player) {
        
        //assign two cards to the designated player
        for _ in 0..<2 {
            if let card = deck.cards.pop() {
                player.hand.enQueue(card)
            }
        }
        
    }
    

    //put down a card
    func play(_ player: inout Player, _ index: Int) {
        
        /*
         note: since each players hand is a heap,
         we can indicate which card should be discarded by
         selecting the card index value. This 'card' can then
         just be removed, or added to a 'virtual' discard pile.
         */
        
        let card = player.hand.items[index]

        /*
        todo: although technically correct, this actually breaks the
         max-heap property of the selected players hand..
        */
        
        discard.append(card)
        
        //do some card analysis here..
        
    }
    
    
    
    //receive a card - could be moved to Playable
    func draw(_ player: inout Player)  {
        
        if let card = deck.cards.pop() {
            player.hand.enQueue(card)
        }
    }
    
    
    //analyze and complete game
    func call() {
        
    }
    
    
}
