//
//  ContentView.swift
//  currencyConverter
//
//  Created by Artem on 01/06/2023.
//

import SwiftUI




struct ContentView: View {
    @StateObject var vm = CurrenciesOperation()
    
    var body: some View {
        ZStack {
            Color.cyan.opacity(0.2).ignoresSafeArea()
            VStack {
                HStack (spacing: 15){
                    TextField("Enter value", text: $vm.amount)
                        .customTextField()
                    Picker("Pick 1 currency", selection: $vm.input) {
                        ForEach(allCurrencies.sorted(), id: \.self){item in
                           Text(item)
                                .foregroundColor(.black)
                        }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: vm.input, perform: { newValue in
                        Task {
                           await vm.fetchRate()
                        }
                    })
                        .frame(width: 80, height: 50)
                }
                HStack (spacing: 15){
                    TextField("Result", text: $vm.result)
                        .customTextField()
                    
                    Picker("Pick 2 currency", selection: $vm.output) {
                        ForEach(allCurrencies.sorted(), id: \.self){item in
                           Text(item)
                                .foregroundColor(.black)
                        }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: vm.output, perform: { newValue in
                        Task {
                           await vm.fetchRate()
                        }
                    })
                }
                
                HStack(spacing: 15){
                    Text("Calculate")
                        .customButton(width: 180, height: 50)
                        .padding(.leading)
                        .onTapGesture {
                            vm.calculate()
                        }
                    Image(systemName: "arrow.up.arrow.down")
                        .customButton(width: 80, height: 50)
                        .onTapGesture {
                            vm.reverse()
                        }
                }
                
            }
            .sheet(isPresented: $vm.errorLoading) {
                Text("Error loading data")
            }
        }
      
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
