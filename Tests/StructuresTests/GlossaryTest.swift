//
//  GlossaryTest.swift
//  
//
//  Created by Wayne Bishop on 4/28/21.
//
import XCTest


@testable import Structures


class GlossaryTest: XCTestCase {
    
    //called before each test invocation
    override func setUp() {
        super.setUp()
    }
    
    //test basic glossary functionality
    func testGlossaryStrings() {
                
        let vehicals = Glossary<String, String>()
         
        //new values
        vehicals.updateValue("Porshe", forKey: "Car")
        vehicals.updateValue("Tesla", forKey: "Electric")
        vehicals.updateValue("Cessna", forKey: "Plane")

        
        //print keys (non-nil)
        for k in vehicals.keys {
            print("key is \(k)")
        }
        
        //print values
        for v in vehicals.values {
            if let value = v {
                print("value is \(value)")
            }
        }
        
        
        //check for existing value
        if let results = vehicals.valueForKey("Car") {
            print("car is: \(results)")
        }
        else {
            XCTFail("test failed: not able to find glossary value..")
        }
        
        
        //test for non-existing key
        XCTAssertNil(vehicals.valueForKey("Boat"), "test failed: value does not exist..")
    }
    
    //test glossary closure method - mimics Swift SDK
    func testGlossaryDuplicateKey() {
            
        let bids = Glossary<String, Float>()
        
        //add new auction values
        bids.updateValue(20.0, forKey: "Tim")
        bids.updateValue(50.0, forKey: "Sruti")
        bids.updateValue(10.0, forKey: "Tim") //same duplicate value as tim..
        bids.updateValue(50.0, forKey: "Sam")
                
        print("valueForKey: Tim is: \(bids.valueForKey("Tim")!) ")
                
    }
    
    
}
