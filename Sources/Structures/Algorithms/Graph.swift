//
//  Graph.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/7/14.
//  Copyright (c) 2014 Arbutus Software Inc. All rights reserved.
//

import Foundation

/**
A `Graph` defines a relationship between two or more `Vertices`.
 */

public class Graph {
   
    var canvas: Array<Vertex>
    var isDirected: Bool
    
    /**
      Declare a default directed `Graph` canvas.
     
     - Parameter directed: Indicates if the model should be established as directed or undirected graph.
     */

   public init(directed: Bool = true) {
        canvas = Array<Vertex>()
        isDirected = directed
    }
    
    
    //add vertex to graph canvas
    public func addVertex(element: Vertex) {
        canvas.append(element)
    }
        
    public func addEdge(source: Vertex, neighbor: Vertex, weight: Int) {
        
        
        //create a new edge
        let newEdge = Edge()
        
        
        //establish the default properties
        newEdge.neighbor = neighbor
        newEdge.weight = weight
        source.neighbors.append(newEdge)
        
        
        print("The neighbor of vertex: \(source.tvalue as String?) is \(neighbor.tvalue as String?)..")
        
        
        //check condition for an undirected graph
        if isDirected == false {
            
            
           //create a new reversed edge
           let reverseEdge = Edge()
            
            
           //establish the reversed properties
           reverseEdge.neighbor = source
           reverseEdge.weight = weight
           neighbor.neighbors.append(reverseEdge)
            
           print("The neighbor of vertex: \(neighbor.tvalue as String?) is \(source.tvalue as String?)..")
            
        }
        
    }

    
    /**
     Reverse the sequence of paths given the shortest path. Process analagous to reversing a linked list..
     
     - Parameter head: The source Vertex.
     - Parameter source: The connecting destination `Vertex`.
     - Returns: The reversed `Path`.
     */

    public func reversePath(_ head: Path?, source: Vertex) -> Path? {
        
        
        guard head != nil else {
            return head
        }
        
        //mutated copy
        var output = head
        
        
        var current: Path! = output
        var prev: Path!
        var next: Path!
        
        
        while(current != nil) {
            next = current.previous
            current.previous = prev
            prev = current
            current = next
        }
        
        
        //append the source path to the sequence
        let sourcePath: Path = Path()
        
        sourcePath.destination = source
        sourcePath.previous = prev
        sourcePath.total = 0
        
        output = sourcePath
        
        
        return output
        
    }
    
    


    
    //process Dijkstra's shortest path algorithm
    public func processDijkstra(_ source: Vertex, destination: Vertex) -> Path? {
    
        
        var frontier: Array<Path> = Array<Path>()
        var finalPaths: Array<Path> = Array<Path>()
        
        
        //use source edges to populate the frontier
        for e in source.neighbors {
            
            let newPath: Path = Path()
            
            
            newPath.destination = e.neighbor
            newPath.previous = nil
            newPath.total = e.weight
            
            
            //add the new path to the frontier
            frontier.append(newPath)
            
        }
        

        //construct the best path
        var bestPath: Path = Path()
        
        
        while frontier.count != 0 {
            
            bestPath = Path()
            
            //support path changes using the greedy approach - O(n)
            var pathIndex: Int = 0
            
            
            for x in 0..<frontier.count {
               
                let itemPath: Path = frontier[x]
                
                if  (bestPath.total == 0) || (itemPath.total < bestPath.total) {
                    bestPath = itemPath
                    pathIndex = x
                }
            }
            
            
            //enumerate the bestPath edges
            for e in bestPath.destination.neighbors {
                
                let newPath: Path = Path()
                
                newPath.destination = e.neighbor
                newPath.previous = bestPath
                newPath.total = bestPath.total + e.weight
                
                
                
                //add the new path to the frontier
                frontier.append(newPath)
            }
            
            
            //preserve the bestPath
            finalPaths.append(bestPath)
            
            
            //remove the bestPath from the frontier
            frontier.remove(at: pathIndex)
            
            
            
        } //end while
        
        
    
        //establish the shortest path as an optional
        var shortestPath: Path! = Path()
        
        
        for itemPath in finalPaths {
            
            if (itemPath.destination.tvalue == destination.tvalue) {
                
                if  (shortestPath.total == 0) || (itemPath.total < shortestPath.total) {
                    shortestPath = itemPath
                }
                
            }
            
        }
        
        
        return shortestPath
        
    }
    
    
    
    ///An optimized version of Dijkstra's shortest path algorthim
    public func processDijkstraWithHeap(_ source: Vertex, destination: Vertex) -> Path? {
        
        
        let frontier: PathHeap = PathHeap()
        let finalPaths: PathHeap = PathHeap()
        
        
        //use source edges to create the frontier
        for e in source.neighbors {
            
            let newPath: Path = Path()
            
            
            newPath.destination = e.neighbor
            newPath.previous = nil
            newPath.total = e.weight
            
            
            //add the new path to the frontier
            frontier.enQueue(newPath)
            
        }
        
        
        //construct the best path
        while frontier.count != 0 {
                        
            //use the greedy approach to obtain the best path - O(1)
            guard let bestPath: Path = frontier.peek() else {
                break
            }
            
            
            //enumerate the bestPath edges
            for e in bestPath.destination.neighbors {
                
                let newPath: Path = Path()
                
                newPath.destination = e.neighbor
                newPath.previous = bestPath
                newPath.total = bestPath.total + e.weight
                
                
                //add the new path to the frontier
                frontier.enQueue(newPath)
                
            }
            
            
            //preserve the bestPaths that match destination
            if (bestPath.destination.tvalue == destination.tvalue) {
                finalPaths.enQueue(bestPath)
            }
            
            
            //remove the bestPath from the frontier
            frontier.deQueue()
            
            
        } //end while
        
        
        
        //obtain the shortest path from the heap
        var shortestPath: Path? = Path()
        shortestPath = finalPaths.peek()
        
        
        return shortestPath
        
    }
    
        
    
    //MARK: PageRank algorithms
    
    public func processPageRankWithSink() {
                
        let startingRank: Float = roundf(Float((100 / self.canvas.count))) //todo: change from default 100 to 1?
        var round: Int = 0
        
        
        while round < 2 {
            
            for v in self.canvas {
                
                //equal allocation - random surfer
                if round == 0 {
                    v.rank[round] = startingRank
                }
                
                let currRank = v.rank[round]
                
                //calculate & assign
                if v.neighbors.count > 0 {
                    
                    let assignedRank = roundf(currRank / Float(v.neighbors.count))
                    
                    //assign rank
                    for m in v.neighbors {
                        m.neighbor.rank[round + 1] += assignedRank
                    }
                }
                
                //sink vertex - distribute previous rank to other vertices
                else {
                    if self.canvas.count > 1 {
                        
                        let sinkRank = currRank / (Float(self.canvas.count) - 1)
                        
                        for m in self.canvas {
                            if v.tvalue != m.tvalue {
                                m.rank[round + 1] += sinkRank
                            }
                        }
                    }
                }
            }

            //advance to next round
            round += 1
        }
        
        
    }

        
    
    //MARK: traversal algorithms
    
    
    //bfs traversal with inout closure function
    public func traverse(_ startingv: Vertex, formula: (_ node: inout Vertex) -> ()) {

        
        //establish a new queue
        let graphQueue: Queue<Vertex> = Queue<Vertex>()
        
        
        //queue a starting vertex
        graphQueue.enQueue(startingv)
        
        
        while !graphQueue.isEmpty() {
            
            
            //traverse the next queued vertex
            guard var vitem = graphQueue.deQueue() else {
                break
            }
            
            //add unvisited vertices to the queue
            for e in vitem.neighbors {
                if e.neighbor.visited == false {
                    print("adding vertex: \(e.neighbor.tvalue) to queue..")
                    graphQueue.enQueue(e.neighbor)
                }
            }
            

            /*
            notes: this demonstrates how to invoke a closure with an inout parameter.
            By passing by reference no return value is required.
            */
            
            //invoke formula
            formula(&vitem)

            
        } //end while
        
        
        print("graph traversal complete..")
        
        
    }


    
    
    /// Identifies all unconnected vertices of related neighbors (e.g. mutual friends).
    ///
    /// - Parameter source: the source vertex
    /// - Returns: the list of unconnected vertices, based on priority
    
    public func mutualNeighbors(of source: Vertex) -> Priority<Vertex>  {
       
        let priority = Priority<Vertex>()
                
        //initialize source list
        for e in source.neighbors {
            
            //iterate through entire graph
            for g in self.canvas {
                
                //examine each neighbors adjacency list
                for s in g.neighbors {
                    if (s.neighbor == e.neighbor) && (s.neighbor != source) {
                        print("mutual connection found..")
                        priority.add(g)
                    }
                }
            }
        }
    
                
        return priority
    }
    
    
    
    //breadth first search
    public func traverse(_ startingv: Vertex) {
        
        
        //establish a new queue
        let graphQueue: Queue<Vertex> = Queue<Vertex>()
        
        
        //queue a starting vertex
        graphQueue.enQueue(startingv)
        
        
        while !graphQueue.isEmpty() {
            
            
            //traverse the next queued vertex
            guard let vitem = graphQueue.deQueue() else {
                break
            }

            
            //add unvisited vertices to the queue
            for e in vitem.neighbors {
                if e.neighbor.visited == false {
                   // print("adding vertex: \(e.neighbor.tvalue) to queue..")
                    graphQueue.enQueue(e.neighbor)
                }
            }
            
        
            vitem.visited = true
            print("traversed vertex: \(vitem.tvalue)..")
            
            
        } //end while
        
        
        print("graph traversal complete..")
        
        
    } //end function
    
    
    
    //use bfs with trailing closure to update all values
    func update(startingv: Vertex, formula:((Vertex) -> Bool)) {
        
        
        //establish a new queue
        let graphQueue: Queue<Vertex> = Queue<Vertex>()
        
        
        //queue a starting vertex
        graphQueue.enQueue(startingv)
        
        
        while !graphQueue.isEmpty() {
            
            //traverse the next queued vertex - Swift 4.0
            //let vitem = graphQueue.deQueue() as Vertex!

            //traverse the next queued vertex
            guard let vitem = graphQueue.deQueue() else {
                break
            }

            
            //add unvisited vertices to the queue
            for e in vitem.neighbors {
                if e.neighbor.visited == false {
                    print("adding vertex: \(e.neighbor.tvalue) to queue..")
                    graphQueue.enQueue(e.neighbor)
                }
            }
            
            
            //apply formula..
            if formula(vitem) == false {
                print("formula unable to update: \(String(describing: vitem.tvalue))")
            }
            else {
                print("traversed vertex: \(vitem.tvalue)..")
            }
            
            vitem.visited = true
            
            
        } //end while
        
        
        print("graph traversal complete..")
                
    }
    
/*
    //return the graph model in topological order
    func traverseTopo() -> () {
        
        //mutated copy
        let topolist: Array<Vertex> = self.canvas
        
        while topolist.count > 0 {
            
            for (index, v) in topolist.enumerated() {
                for n in v.neighbors {
                    print(n.neighbor.tvalue)
                }
            }
                        
        }
        
    }
     
   */
    
}
