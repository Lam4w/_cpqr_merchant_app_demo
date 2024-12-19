//
//  TransactionRow.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 12/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct MerchantTransactionRow: View {
    let name: String
    let status: String
    let amount: String
    
    var statusColor: Color {
        switch status {
            case "Success": return Color(hex: "32A64D")
            case "Pending": return Color(hex: "E4AC04")
            case "Failed": return Color(hex: "EE4540")
            default: return Color.black
        }
    }
    
    var body: some View {
        HStack(spacing: 8) {
            VStack {
                Text("01")
                    .font(.custom("Ubuntu-Bold", size: 17))
                Text("Sep")
                    .font(.custom("Ubuntu-Regular", size: 10))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .background(Color(hex: "F0F2F5"))
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(name)
                    .font(.custom("Ubuntu-Bold", size: 14))
                
                HStack(spacing: 4) {
                    Text("Thanh toán CPQR")
                        .foregroundColor(Color(.systemGray))
                    
                    if status != "Pending" {
                        Text(status)
                            .foregroundColor(statusColor)
                    }
                }
                .font(.custom("Ubuntu-Regular", size: 12))
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("\(amount) vnd")
                    .font(.custom("Ubuntu-Bold", size: 15))
                
                FontIcon.button(.ionicon(code: .md_return_left), action: {}, fontsize: 15)
            }
        }
    }
}
