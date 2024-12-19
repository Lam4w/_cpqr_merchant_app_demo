//
//  TransactionListView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 12/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct MerchantTransactionListView: View {
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
                MerchantTransactionRow(
                    name: ["Đơn hàng #2211312326", "Đơn hàng #2211312325", "Đơn hàng #2211312324"][index],
                    status: ["Success", "Success", "Failed"][index],
                    amount: ["30.000", "40.000", "40.000"][index]
                )
                
                Divider()
                    .background(Color(hex: "F0F2F5"))
            }
        }
    }
}

#Preview {
    MerchantTransactionListView()
}
