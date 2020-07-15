/*:
 
 # Style Guide
 
 This playground provides for getting started with the **Structures** package. Swift Structures has been optimized for **Swift 5.3** (e.g., Xcode 12.0) or later.
 */

import PlaygroundSupport
import Structures
import SwiftUI

/*:
 Shown above, playgrounds created with the Xcode 12+ can include additional resources from a Swift package. In addition, **Structures** can also be used as a project dependency in an existing iOS, WatchOS or TvOS app.  In this case, package resources are being referenced to build the sample **Stack** data structure. As you experiment with the code, feel free to push and pop additional items. Also, test the generic features by changing **Int** to a **String** type.
 */

//create a new stack
let stack = Stack<Int>()

//push items
stack.push(8)
stack.push(10)
stack.push(2)
stack.push(9)

//uncomment this code to see what changes!
//stack.pop()

/*:
 Often referred to in technical interviews, **Stacks** are useful structures because their main operations (e.g. push, pop) occurr in O(1) - constant time. Compared to other O(1) algorithms, they are relatively straightforward to code and can built using a standard **Array** data structure. Similar to the other structures included this project, the Stack also supports **Generics**. You can find the source for this implementation under the Sources/Structures/Algorithms folder under the main Swift package.
 */

struct StackView: View {
        
   @State var results = stack.values
    
/*:
 To prepare the Stack data to be used SwiftUI, the model supporting the custom structure was extended to support the **Identifiable** protocol. This works as the main **source of truth**, as its results are always interpreted at runtime using a computed property.
 */
    
    var body: some View {
        
        VStack(alignment: .center) {
            
            ForEach(results, id: \.id) { result in
                
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
    }
}

let stackView = StackView()
PlaygroundPage.current.setLiveView(stackView)


/*:
In addition to this playgrounds sample, be sure to check out the 70+ unit tests that provide much more details on how to utilize the more complex algorithms like **Binary Search Trees**, Heaps and Graphs. These can be found under Tests/StructureTests under the main **Structures** project.
 */
