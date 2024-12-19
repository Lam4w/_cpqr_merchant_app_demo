//
//  ClientTransactionList.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 18/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct ClientTransactionList: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Giao dịch gần đây")
                    .bold()
                    .font(.system(size: 20))
                    .foregroundColor(.foreground)
                
                Spacer()
                
                Button(action: {}) {
                    HStack {
                        Text("Xem tất cả")
                            .foregroundColor(.accent)
                        
                        FontIcon.button(.ionicon(code: .ios_arrow_forward), action: {}, fontsize: 20)
                            .foregroundColor(.accent)
                    }
                }
            }
            
            ForEach(0..<3) { index in
                ClientTransactionRow(
                    name: ["#2211312326", "#2211312325", "#2211312324"][index],
                    date: ["15/12/2024", "10/12/2024", "7/12/2024"][index],
                    status: ["In", "In", "Out"][index],
                    amount: ["30.000", "40.000", "40.000"][index]
                )
                
                Divider()
                    .background(Color(hex: "F0F2F5"))
            }
        }
    }
}

#Preview {
    ClientTransactionList()
}
