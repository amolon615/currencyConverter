//
//  Extensions.swift
//  currencyConverter
//
//  Created by Artem on 01/06/2023.
//

import SwiftUI

extension TextField {
    func customTextField() -> some View {
        self
            .keyboardType(.numberPad)
            .frame(width: 180, height: 50)
            .multilineTextAlignment(.center)
            .background(Color.blue.opacity(0.5))
            .cornerRadius(10)
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .padding(.leading)
    }
}

extension Text {
    func customButton(width: CGFloat, height: CGFloat) -> some View {
        self
            .frame(width: width, height: height)
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .background(Color.green)
            .cornerRadius(10)
           
    }
}
extension Image {
    func customButton(width: CGFloat, height: CGFloat) -> some View {
        self
            .frame(width: width, height: height)
            .background(Color.green)
            .cornerRadius(10)
    }
}
