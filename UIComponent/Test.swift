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

struct Test: View {
	@State private var amount = Decimal()
	@State private var currency: Currency = .EUR // change this to any other currency to get different (and expected) results

    var body: some View {
        CurrencyAmount(
        title: "Some label",
        amount: $amount,
        currency: $currency)
    }
}

struct CurrencyAmount: View {
	let title: String
	@Binding var amount: Decimal
	@Binding var currency: Currency
	let prompt: String = ""

	var body: some View {
		TextField(
			title,
			value: $amount,
			format: .currency(code: currency.rawValue),
			prompt: Text(prompt))
	}
}

enum Currency: String, CaseIterable, Identifiable {
	case AUD, CAD, EUR, GBP, NZD, USD
	var id: String { self.rawValue }
}

#Preview {
    Test()
}