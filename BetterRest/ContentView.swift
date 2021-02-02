//
//  ContentView.swift
//  BetterRest
//
//  Created by Ibukunoluwa Soyebo on 02/02/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var someNumber = 8.0
    
    
    var body: some View {
        Form{
            HStack{
                Text("\(someNumber, specifier: "%g")")
                Stepper(value: $someNumber, in: 4...12, step: 0.25){
                    
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
