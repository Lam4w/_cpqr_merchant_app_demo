//
//  ClientTransactionRow.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 18/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct ClientTransactionRow: View {
    let name: String
    let date: String
    let status: String
    let amount: String
    
    var statusColor: Color {
        switch status {
            case "In": return Color(hex: "32A64D")
            case "Out": return Color(hex: "E64547")
            default: return Color.black
        }
    }
    
    var statusAmount: String {
        switch status {
            case "In": return "+"
            case "Out": return "-"
            default: return ""
        }
    }
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 10) {
                Text(name)
                    .font(.custom("Ubuntu-Bold", size: 14))
                
                HStack(spacing: 4) {
                    Text(date)
                        .foregroundColor(Color(.systemGray))
                }
                .font(.custom("Ubuntu-Regular", size: 12))
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("\(statusAmount) \(amount) vnd")
                    .font(.custom("Ubuntu-Bold", size: 15))
                    .foregroundColor(statusColor)
            }
        }
    }
}

