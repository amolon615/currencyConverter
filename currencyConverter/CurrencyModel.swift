//
//  CurrencyModel.swift
//  currencyConverter
//
//  Created by Artem on 01/06/2023.
//

import Foundation


struct Currency: Codable {
    let motd: MOTD
    let success: Bool
    let base: String
    let date: String
    let rates: [String: Double]
}

struct MOTD: Codable {
    let msg: String
    let url: String
}


let allCurrencies = ["DKK", "BWP", "EGP", "TWD", "CDF", "ANG", "RSD", "WST", "NIO", "HTG", "NGN", "KYD", "MMK", "STD", "SBD", "VND", "BTC", "SRD", "KGS", "RON", "MZN", "MUR", "CLF", "ETB", "SEK", "JMD", "CLP", "PLN", "OMR", "BSD", "BDT", "BHD", "PAB", "FJD", "GTQ", "TND", "CNH", "INR", "RWF", "BND", "VES", "JOD", "PYG", "THB", "TRY", "JPY", "SZL", "CHF", "PHP", "UZS", "MRU", "XPT", "NOK", "NAD", "AMD", "LAK", "SVC", "NZD", "STN", "XOF", "PGK", "HUF", "YER", "BZD", "SGD", "ZAR", "HNL", "BTN", "RUB", "HRK", "ALL", "KWD", "KHR", "XAG", "HKD", "MAD", "LBP", "DJF", "KES", "DZD", "GYD", "UAH", "XAF", "KMF", "SOS", "SSP", "XCD", "GGP", "GEL", "COP", "AOA", "UGX", "ARS", "ISK", "ILS", "CAD", "BBD", "IMP", "UYU", "MNT", "XAU", "LRD", "MYR", "GNF", "AZN", "USD", "MKD", "EUR", "XPF", "CNY", "MGA", "MWK", "SDG", "MVR", "SCR", "GBP", "AUD", "TJS", "BOB", "GIP", "SYP", "ERN", "SLL", "XPD", "SHP", "AED", "KRW", "LKR", "LYD", "CVE", "MOP", "PEN", "TTD", "FKP", "IDR", "KPW", "SAR", "TMT", "KZT", "GMD", "DOP", "PKR", "VUV", "BAM", "CRC", "MXN", "NPR", "BIF", "CUP", "GHS", "CUC", "JEP", "TZS", "MDL", "ZWL", "XDR", "AWG", "IQD", "LSL", "CZK", "IRR", "BGN", "BMD", "QAR", "BRL", "BYN", "ZMW", "TOP", "AFN"]
