//
//  Queue.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 7/11/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation


public class Queue<T>: Sequence, IteratorProtocol {
        
    var top = Node<T>()
    private var counter: Int = 0
    private var iterator: Node<T>?
    private var times: Int = 0

    

    public init() {
        //dependency support
    }
    
    public var count: Int {
        return counter
    }

    
    public func peek() -> T? {
        return top.tvalue
    }
    
    
    
    //check for a value
    public func isEmpty() -> Bool {
        
        guard top.tvalue != nil else {
            return true
        }
        
        return false
    }


    
    //MARK: Queuing Functions

    
    //enqueue specified item - O(n)
    public func enQueue(_ key: T) {
        
        
        //trivial case
        guard top.tvalue != nil else {
            top.tvalue = key
            counter += 1
            return
        }
        
        let childToUse = Node<T>()
        var current = top

        
        //find next position - O(n)
        while let next = current.next {
            current = next
        }
        
        
        //append new item
        childToUse.tvalue = key
        current.next = childToUse
        counter += 1
    }
    

    
    //retrieve top level item - O(1)
    public func deQueue() -> T? {
    
    
        //trivial case
        guard top.tvalue != nil else {
            return nil
        }
    
        
        //retrieve current item
        let item = top.tvalue
    
    
        //queue next item
        if let next = top.next {
          top = next
          counter -= 1
        }
    
        else {
          top.tvalue = nil
          counter = 0
        }
    
    
        return item
    
    }
    
    
    //MARK: Iterator protocol conformance
    
    
     //iterates through each item
     public func next() -> T? {
         
         print("iterator called..")
         
         //check starting reference
         if times == 0 {
             iterator = top
         }
                 
         
         //assign next instance
         if let item = iterator {
             if let tvalue = item.tvalue {
                 iterator = item.next
                 times += 1
                 return tvalue
             }
         }
         
         //reset timer
         times = 0
         
         return nil
         
     }
     
    
    
} //end class

