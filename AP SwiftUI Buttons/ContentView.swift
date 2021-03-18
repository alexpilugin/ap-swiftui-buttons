//
//  ContentView.swift
//  AP SwiftUI Buttons
//
//  Created by Alex Pilugins on 17/03/2021.
//

/**
 # Button Initializers:
 
 ```Button(String, action: Closure)```
 The first attribute is a string that defines the button's label, and the action attribute is a closure with the code to be executed when the button is pressed
 
 ```Button(action: Closure, label: Closure)```
 The action attribute is a closure with the code to be executed when the button is pressed, and the label attribute is a closure that returns the views to be displayed as the button's label.
 */

import SwiftUI

func printOut() {
    print("Button clicked")
}

struct ButtonView: View {
    var body: some View {
        Button(action: {
            print("Clicked")
        }) {
            HStack {
                Image(systemName: "person")
                Text("Button Label")
            }
        }
        .padding()
        .overlay( RoundedRectangle(cornerRadius: 20.0).stroke() )
    }
}

//Custom Button Style:
struct BtnStyle: ButtonStyle {
   func makeBody(configuration: BtnStyle.Configuration) -> some View {
      let pressed = configuration.isPressed
      return configuration.label
         .padding()
        .border(Color.blue, width: 5)
         .scaleEffect(pressed ? 1.5 : 1.0)
   }
}

struct ContentView: View {
    @State private var colorActive: Bool = false
    @State private var showInfo: Bool = false
    @State private var btnDisabled = false
    @State private var isPlaying = false
    @State private var expanded: Bool = false

    var body: some View {
        VStack(spacing: 10) {
            Button("Print out", action: printOut)
            
            Group {
                Text("Default Title")
                    .padding()
                    .frame(width: expanded ? 300 : 150, height: 50)
                    .background(colorActive ? Color.green : Color.clear)
                    .border(Color.green, width: 2)

                Button("Change Color and expand") {
                    self.colorActive.toggle()
                    self.expanded.toggle()
                }
            }

            //Adding and removing views from the interface:
            Group {
                Button(showInfo ? "Hide Info" : "Show Info") { self.showInfo.toggle() }
                
                if showInfo { Text("This is the information") }
            }
            
            //Applying Custom Button Style:
            Group {
                Button("Custom Button Style"){}.buttonStyle(BtnStyle())
                
                Button(action: {}, label: {
                    //SF symbols
                    Image(systemName: "lasso.sparkles")
                        .font(Font.system(size: 50))
                        .foregroundColor(Color.blue)
                }).buttonStyle(BtnStyle())
            }
            
            //Disabling a button:
            Button("Change Color and disable") { self.btnDisabled = true }
                .accentColor(Color.green)
                .disabled(btnDisabled)
            
            Button(action: {
                self.isPlaying.toggle()
            }) {
                //Displaying and styling SF symbols
                Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                    .font(Font.system(size: 50).weight(.semibold))
                    .accentColor(isPlaying ? Color.red: Color.green)
            }
                       
            Spacer()
            ButtonView() // Pre-defined Button's View
      }.padding()
   }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
