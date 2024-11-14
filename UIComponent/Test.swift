//
//  Test.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

struct Test: View {
    @State var amount: Decimal = 0.0
    
    var body: some View {
        VStack {
            Text(amount, format: .currency(code: "VND"))
            TextField("Amount", value: $amount, format: .number.precision(.fractionLength(2))
            )
                .keyboardType(.decimalPad)
        }
        .padding()
    }
}

#Preview {
    Test()
}

