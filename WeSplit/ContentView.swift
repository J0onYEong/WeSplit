//
//  ContentView.swift
//  WeSplit
//
//  Created by 최준영 on 2022/10/18.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 20
    
    @FocusState private var amoutIsFocused: Bool
    
    var totalAmountCheck: Double {
        let tipSelection = Double(self.tipPercentage)
        let tipAmountCheck = checkAmount / 100 * tipSelection
        return checkAmount + tipAmountCheck
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(self.numberOfPeople)
        return totalAmountCheck / peopleCount
    }
    
    var currentFormat: FloatingPointFormatStyle<Double>.Currency {
        FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("checkAmount", value: $checkAmount, format: currentFormat)
                        .keyboardType(.decimalPad)
                        .focused($amoutIsFocused)
                    Picker("number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentge", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalAmountCheck, format: currentFormat)
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                } header: {
                     Text("Total amout check")
                }
                
                Section {
                    Text(totalPerPerson, format: currentFormat)
                } header: {
                    Text("Total amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amoutIsFocused = false
                    }
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
