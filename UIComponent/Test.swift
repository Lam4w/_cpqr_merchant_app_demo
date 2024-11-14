//
//  Test.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

struct Test: View {
 @State private var isSubtitleHidden = false
    @State private var value = 0
    
    private var numberFormatter: NumberFormatter
    
    init(numberFormatter: NumberFormatter = NumberFormatter()) {
        self.numberFormatter = numberFormatter
        self.numberFormatter.numberStyle = .currency
        self.numberFormatter.maximumFractionDigits = 2
    }

    var body: some View {
        VStack(spacing: 20) {
            
            Text("Send money")
                .font(.title)
            
            CurrencyTextField(numberFormatter: numberFormatter, value: $value)
                .padding(20)
                .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 2))
                .frame(height: 100)
            
            Rectangle()
                .frame(width: 0, height: 40)
            
            Text("Send")
                .fontWeight(.bold)
                .padding(30)
                .frame(width: 180, height: 50)
                .background(Color.yellow)
                .cornerRadius(20)
                .onTapGesture {
                    if !isSubtitleHidden {
                        isSubtitleHidden.toggle()
                    }
                }
                
                
            if isSubtitleHidden {
                Text("Sending \(value)")
            }
            
            Spacer()
        }
        .padding(.top, 60)
        .padding(.horizontal, 20)
    }
}

#Preview {
    Test()
}
