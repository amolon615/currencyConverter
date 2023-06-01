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
    
    
    //push error fetching to View
    @Published var errorLoading: Bool = false
    
    func reverse(){
        self.buffer = input
        self.input = output
        self.output = buffer
    }
    
    
    init(){
        loadFromFileRate()
        if !currencyRates.isEmpty{
        } else {
            Task {
                await fetchRate()
            }
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
             
             guard currency != nil else { return }
             saveToFileRate()
             loadFromFileRate()
         } catch {
             print("Error: \(error)")
         }
     }


    func saveToFileRate() {
          do {
              let furl = try FileManager.default
                  .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                  .appendingPathComponent("currencyRate\(input)")
                  .appendingPathExtension("json")
              let data = try JSONEncoder().encode(currency)
              try data.write(to: furl)
              print("saved to file rate for \(input)")
          } catch {
              print("---> error saveToFile: \(error)")
          }
      }

    func loadFromFileRate() {
          do {
              let furl = try FileManager.default
                  .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                  .appendingPathComponent("currencyRate\(input)")
                  .appendingPathExtension("json")
              let data = try Data(contentsOf: furl)
              let currency = try JSONDecoder().decode(Currency.self, from: data)
              DispatchQueue.main.async {
                  self.currencyRates = Array(currency.rates.values)
                  self.currency = currency
              }
              print("loaded from file rate for \(input)")
          } catch {
              print("error: \(error)")
          }
      }
    
    

    
    func calculate(){
        guard let amount = Double(amount) else { return }
        self.result = String(amount * (currency?.rates[output] ?? 0))
    }
    
}

