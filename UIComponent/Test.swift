//
//  Test.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

struct Test: View {
    @State var amount: Decimal = 0.0
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text(amount, format: .currency(code: "VND"))
            TextField("Amount", value: $amount, formatter: formatter)
                .keyboardType(.numberPad)
        }
        .padding()
    }
}

#Preview {
    Test()
}
