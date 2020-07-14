/*:
 
 # Style Guide
 
 This project provides a framework for commonly used data structures and algorithms written in Swift! This sample playground provides a quick guide for utilizing the many algorithms and data structures.
 */

//note: Is this a style guide? What else could be added
//to make this cool?

import PlaygroundSupport
import Structures
import SwiftUI

/*:
 Shown above, playgrounds created with the Xcode 12+ can include additional resources from a Swift package or iOS app project. In this case, resources from the **Structures** package are being referenced to build the sample **Stack** data structure. As you experiment with the code, feel free to push and pop additional items. Also, test the generic features by changing **Int** to a **String** type.
 */

//create a new stack
let stack = Stack<Int>()

//push items
stack.push(8)
stack.push(10)
stack.push(2)
//stack.push(9)

//uncomment this code to see what changes!
//stack.pop()

/*:
 Often referred to in technical interviews, **Stacks** are useful structures because their main operations (e.g. push, pop) occurr in O(1) - constant time. Compared to other O(1) algorithms, they are relatively straightforward to code and can built using a standard **Array** data structure. Similar to the other structures included this project, the Stack also supports **Generics**. You can find the source for this implementation under the Sources/Structures/Algorithms folder under the main Swift package.
 */

struct StackView: View {
        
   @State var results = stack.values
    
/*:
 The Stack also makes use of SwiftUI for its visual elements. To prepare the Stack data to be used SwiftUI, the model supporting the custom structure was extended to support the **Identifiable** protocol. This works as the main **source of truth**, as its results are always interpreted at runtime using a computed property.
 */
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            ForEach(results, id: \.id) { result in
                
                //TODO: extract as subView.
                ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.gray)
                            .frame(width: 195.0, height: 65.0)
                    
                        if let tvalue = result.tvalue {
                            Text("\(tvalue)")
                                .foregroundColor(.white)
                                .font(.system(.largeTitle, design: .rounded))
                                .fontWeight(.bold)
                        }
                }
                    Spacer()
                        .frame(width: nil, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        Spacer()
        Button("Pop from Stack..", action: removeFromStack)
            .frame(width: nil, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    
    
    func removeFromStack() {
        print("pop item from stack..")
        
        guard results.count > 0 else {
            return
        }
        results.removeFirst()
    }
    

}

let stackView = StackView()
PlaygroundPage.current.setLiveView(stackView)


/*:
In addition to this playgrounds sample, be sure to check out the 70+ unit tests that provide much more details on how to utilize the more complex algorithms like **Binary Search Trees**, Heaps and Graphs. These can be found under Tests/StructureTests under the main **Structures** project.
 */
