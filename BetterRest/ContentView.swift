//
//  ContentView.swift
//  BetterRest
//
//  Created by Ibukunoluwa Soyebo on 02/02/2021.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    
    @State private var someNumber = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
//    @State private var time_calculated = ""
    
    var test_date: Date{
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? Date()
        return date
    }
    
    var hourxminute: (Int,Int) {
        let components = Calendar.current.dateComponents([.hour, .minute], from: test_date)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        return (hour, minute)
        
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var time_calculated:String {
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let model = try SleepCalculator(configuration: MLModelConfiguration())
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            return formatter.string(from: sleepTime)
            
            // more code here
        } catch {
            return ""
        }
        
    }
    
    var body: some View {
        NavigationView {
            Form {
        
                Section(header: Text("When do you want to wake up?")
                            .font(.headline)){
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
//                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleep")
                            .font(.headline)){
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                
                Section(header: Text("Daily coffee intake")
                            .font(.headline)){
                    
                    Picker("Number of cups", selection: $coffeeAmount){
                        ForEach(1 ..< 21) {
                            Text("\($0)")
                        }
                    }.pickerStyle(WheelPickerStyle())
                    
//                    Stepper(value: $coffeeAmount, in: 1...20) {
//                        if coffeeAmount == 1 {
//                            Text("1 cup")
//                        } else {
//                            Text("\(coffeeAmount) cups")
//                        }
//                    }
                }
                
                
                Text("You should sleep by \(time_calculated)")
                    .font(.largeTitle)
                
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .navigationTitle(Text("Hmm"))
//            .navigationBarItems(trailing: Button(action: calculateBedtime) {
//                Text("Calculate")
//            })
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
