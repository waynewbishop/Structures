//
//  Blockchain.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 06/08/20.
//  Copyright © 2018 Arbutus Software Inc. All rights reserved.
//

import Foundation


/**
    All blockchain resources are shared by peers and miners by reference. Any change to shared resources by either type is reflected directly the blockchain.
 */

class Blockchain {
    
      private var intent = Array<Exchange>()
      private var blockchain = LinkedList<Block>()
      private var audit = Stack<Audit>()
 
    
      //entity types
      private var members = Array<Member>()
      private var reward: Float = 20.0

    
    
      init() {
        self.updateChain(with: genesisBlock())
      }
    
    
    
      //MARK: member function (e.g. peer or miner)
    
      func newMember(item: Member) {
        self.members.append(item)
      }

    
     
      //MARK: exchange functions
    
      func newExchange(_ exchange: Exchange) {
        intent.append(exchange)
      }
      
    
      func exchangeList(requester: Miner) -> Array<Exchange> {
        
         audit.push(Audit(action: "get exchange list", requester))
         return self.intent
      }
    
    
      func clearExchange(requester: Miner) {
        
        audit.push(Audit(action: "clear exchange", requester))
        intent.removeAll()
      }
    
    
      //MARK: mining functions
    
      
      //empty block
      func genesisBlock() -> Block {
        
        let newblock = Block()
        newblock.desc = "genesis block.."
        
        return newblock
      }
    

    
      //return current blockchain
      func currentChain() -> LinkedList<Block> {
          return blockchain
      }
        
    
    
      //issue reward for mining block
      func sendreward(to requester: Miner) -> Float {
        
        audit.push(Audit(action: "issue reward", requester))
        return self.reward
      }
 
 
    
      //update network participants
      func updateChain(with newblock: Block) {
        
        /*
         note: all members maintain a reference to the main network blockchain
         any change in this status is promoted to all participants
        */
        
        
        blockchain.append(newblock)
        
      }
              
        
}

