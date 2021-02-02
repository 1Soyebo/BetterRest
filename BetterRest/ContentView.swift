//
//  ContentView.swift
//  BetterRest
//
//  Created by Ibukunoluwa Soyebo on 02/02/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var someNumber = 8.0
    @State private var wakeUp = Date()
    
    
    var body: some View {
        NavigationView{
            Form{
                HStack{
                    Text("\(someNumber, specifier: "%g")")
                    Stepper(value: $someNumber, in: 4...12, step: 0.25){
                        
                    }
                }
                
                Section{
                    DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
                }
                
                
            }
            .navigationBarTitle(Text("Hmm"))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
