//
//  ParkingLot.swift
//  
//
//  Created by Wayne Bishop on 1/19/21.
//

import Foundation

public class ParkingLot <T> {

    var ticketList = Set<Ticket>()
    var reserveList: Array<Chain<Space>?>

    
    public init() {
        self.reserveList = Array<Chain<Space>?>(repeatElement(nil, count: 24))
    }
    
    
    //make a reservation
    public func reserve(start: Date, end: Date) -> Reservation? {
                
        //reserved spaces
        let reserveSlice = Array(reserveList[0...6])
    
        /*
         note: needs to check date range for any potentially
         chained items in a series.
         */
        if let spaceNo = reserveSlice.firstIndex(where: { $0 == nil }) {
            
            let reservedSpace = Space(name: spaceNo)
            
            //create reservation
            let res = Reservation(for: reservedSpace)
            res.start = start
            res.end = end
            
            reservedSpace.reservation = res
            res.space = reservedSpace
            

            //new series
            let spaceChain = Chain<Space>()
            spaceChain.append(reservedSpace)

            
            //add new chain
            reserveList[spaceNo] = spaceChain

            
            return res

        }
                    
        return nil
    }
    
    
    //enter the lot
    public func enter(item: Reservation?) -> Bool {
        
        /*
         note: the goal of entering the lot is to create a ticket.
         if they have a reservation this is attached to ticket at entry.
         */
       
        /*
        guard let reservation = item else {
            print("I don't have a ticket..")
            return false
        }
        
        //has reservation - pull the chain and check uuid
        if let chain = reserveList[reservation.space!.name!] {
            
       }
        */
        
        return false
    }
    
    
    //exit the lot
    public func exit(ticket: Ticket) {
        //return nil
        
        /*
         todo: determine if the customer should be charged and
         by how much. If they have a reservation and it's timeout
         is less than the current time no charge is made.
         
         Otherwise, charge the user based on the difference between
         timein and timout.
         */
        
    }
    
}
