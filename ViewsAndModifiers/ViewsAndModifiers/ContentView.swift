//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by ihuettel on 1/12/21.
//

import SwiftUI


//  Create a custom container for building a grid.
//  It's certainly not perfect as it has limits as it grows in size,
//  but it's good for educational purposes!

struct GridView<Content: View>: View { // Define a custom view with content that conforms to View
    let rows: Int // State our constants to be used by the struct
    let columns: Int
    let content: (Int, Int) -> Content // Since we're building a grid, we need a closure that will take both an Int for rows and an Int for columns
    
    // From here we build our body, which creates a grid using HStack & VStack.
    // ForEach enumerates how many columns and rows are needed.
    // Finally it returns each individual piece of content bundled with (row, column)
    
    var body: some View {
        HStack {
            ForEach(0 ..< columns) { column in
                VStack {
                    ForEach(0 ..< self.rows) { row in
                        self.content(row, column)
                    }
                }
            }
        }
    }
     
    //  We define a custom initializer so we can have a dynamically created HStack
    //  whenever we call GridView on something down the line.
    //
    //  Most siginificantly, @ViewBuilder provides us our extra functionality
    //  and @escaping signals that "content" will need to be captured.
    //
    //  After that, it simply assigns its arguments to the new instance's properties
    //  (self.row, self.column, etc.)
    
   init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
       self.rows = rows
       self.columns = columns
       self.content = content
   }
}


//  Now we're going to build some custom ViewModifiers.
//  ProminentTitle is my interpretation of one of the challenges
//  put forth in in 100 Days of Swift which simply is to make
//  a modifier that makes a large title with a blue foreground color.

struct ProminentTitle: ViewModifier { // Here we define ProminentTitle as a ViewModifier
    func body(content: Content) -> some View {
        content // We treat "content" as it it was the content we're modifing directly
            .font(.largeTitle) // Make it bigger!
            .foregroundColor(.blue) // Make it blue-er!
    }
}

//  Encapsulate is me having fun with and testing my knowledge of View Modifiers.
//  It doesn't really have any amazing functionality, but it uses padding
//  and linear gradients to make a (slightly) more interesting effect that
//  was not explicitly explained in any part of the tutorial.
//
//  Encapsulate takes whatever content is passed in, adds it's applicable modifiers
//  to the generic "content" View and returns it as a modified version of itself.

struct Encapsulate: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [.white, .gray]),startPoint: .leading, endPoint: .trailing))
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [.gray, .white]),startPoint: .leading, endPoint: .trailing))
    }
}

// Lastly we have a ViewModifier from the 100 Days tutorial.
// This one adds a watermark using a string with some background for visual clarity.

struct Watermark: ViewModifier { // We define our struct as before..
    var text: String // ..only this time we have a text variable that conforms to String
     
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .padding(5)
                .foregroundColor(.white)
                .background(Color.black)
        }
    }
}

//  We have 3 ViewModifiers which we could easily call using .modifier on the objects
//  of our choosing, however we can also write an extension to do the work for us.
//
//  Adding an extension also makes our code look cleaner later on.
//  Plus, it gives me the experience of writing extensions!
//  (..and the 100 Days says to do it as both part of the tutorial and challenges..)
//
//  Essentially, we define our intent to extend the View protocol,
//  we add three methods all with descriptive names similar to their ViewModifier,
//  and we call self.modifier(<our modifier>) in each one.
//  As each is a closure with a single line, it automatically returns that new object
//  which makes for a nice, clean extension.

extension View {
    func titleProminent() -> some View {
        self.modifier(ProminentTitle())
    }
    
    func encapsulate() -> some View {
        self.modifier(Encapsulate())
    }
    
    func watermark(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}



//  Now we have the content that will actually be seen on the screen.
//  This app doesn't serve any particular purpose, as this project was entirely
//  a technical exercise to learn more about Views, ViewModifiers, and more about
//  how Swift uses structs to implement them.

struct ContentView: View {
    @State private var useRedText = false // We'll need this to tract our Button's state
    
    var body: some View {
        VStack { // I implemented everything in a VStack just to keep things seperate on my screen.
            Button("Change color") { // Here's that button for changing text color!
                self.useRedText.toggle() // We use the toggle method to flip a boolean.
            }
            //.titleProminent() // And we call our custom ViewModifier! How fun!
            
            Spacer() // ..sometimes you just need a little space..
            
            
            GridView(rows: 2, columns: 6) { row, col in // We call our custom container with its desired parameters.
                Image(systemName: "\((row + 1) * (col + 1)).square") // This was the main way of demonstrating how GridView draws itself.
                Image(systemName: "diamond") // This was also added to show the implicit HStack made by the custom initializer.
            }
            
            //  As a side note, I considered writing the above text using default
            //  parameters ($0, $1) however, I decided against it for clarity's sake.
            //  Since the most likely people to be reading this is are me, myself, and I,
            //  I wanted it to be a explicit as possible in terms of functionality.
            //  (..though that opinion can definitely change on the daily..)
            
            Text("Hello World!") // This last bit of text is just to show some features in action.
                .foregroundColor(useRedText ? .red : .green) // This demonstrates how the ternary operator can be used to interpret state
                .encapsulate() // We use our custom encapsulate modifier here.
                .frame(maxWidth: .infinity, maxHeight: .infinity) // I added this to make the watermark appear in the corner of the screen, not the corner of the symbol.
                .watermark(with: "ihuettel") // And finally we use our watermark modifier.

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
