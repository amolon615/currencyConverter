//
//  CurrencyViewModel.swift
//  currencyConverter
//
//  Created by Artem on 01/06/2023.
//

import SwiftUI


 class CurrenciesOperation : ObservableObject{
     var currency: Currency? = nil
    
    @Published var currencyRates: [Double] = []
    @Published var input: String = "EUR"
    @Published var output: String = "UAH"
    @Published var amount: String = "0.0"
    @Published var result: String = ""
    
    @Published var buffer: String = ""
    
    
    @Published var errorLoading: Bool = false
    
    func reverse(){
        self.buffer = input
        self.input = output
        self.output = buffer
    }
    
     init(){
         Task {
             await fetchRate()
         }
     }

    func fetchRate() async {
         guard let url = URL(string: "https://api.exchangerate.host/latest?base=\(input)") else { return }
         
         do {
             let (data, response) = try await URLSession.shared.data(from: url)
             
             guard let httpResponse = response as? HTTPURLResponse,
                   (200..<300).contains(httpResponse.statusCode) else {
                 self.errorLoading = true
                 return
             }
             self.currency = try JSONDecoder().decode(Currency.self, from: data)
             if let currency {
                 DispatchQueue.main.async {
                     self.currencyRates = Array(currency.rates.values)
                 }
             }
         } catch {
             print("Error: \(error)")
             DispatchQueue.main.async {
                 self.errorLoading = true
             }
         }
     }

    func calculate(){
        guard let amount = Double(amount) else { return }
        self.result = String(amount * (currency?.rates[output] ?? 0))
    }
    
}

