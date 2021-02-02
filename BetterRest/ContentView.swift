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
    
    var test_date: Date{
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? Date()
        return date
    }
    
    var hourxminute: (Int,Int){
        let components = Calendar.current.dateComponents([.hour, .minute], from: test_date)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        return (hour, minute)
        
    }
    
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
