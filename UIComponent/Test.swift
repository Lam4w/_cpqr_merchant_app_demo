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
            // Default the currency to match the users locale,
            // or fall back to a certain if we can't figure out the locale
            Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            // Displays "$0.00"
                
            // We can ensure our text to only ever display a certain type
            // of currency by using the following line (instead of the one above)
            Text(amount, format: .currency(code: "GBP"))
            // Displays ￡0.00 (no matter what locale you have choosen)
                
            // Accepting a number as input to a text field
            TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
        .padding()
    }
}

#Preview {
    Test()
}


// import SwiftUI

// struct ContentView: View {
//     @State var amount: Decimal = 0.0
    
//     var body: some View {
//         Text(amount, format: .currency(code: "GBP"))
//         TextField("Amount", value: $amount, format: .number.precision(.fractionLength(2)))
//             .keyboardType(.decimalPad)
//     }
// }