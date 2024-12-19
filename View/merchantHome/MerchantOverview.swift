//
//  OverviewCard.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 12/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct MerchantOverview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Tổng quan trong")
                    .foregroundColor(.foreground)
                
                Button(action: {}) {
                    HStack {
                        Text("Hôm nay, 13 Dec")
                            .foregroundColor(.accent)
                        
                        FontIcon.button(.ionicon(code: .ios_arrow_down), action: {},fontsize: 18)
                            .padding(0)
//                            .background(.ultraThinMaterial)
//                            .clipShape(.circle)
                    }
                }
            }
            
            HStack(spacing: 40) {
                VStack(alignment: .leading) {
                    Text("Tổng doanh thu")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.systemGray))
                        .padding(.bottom, 1)
                    
                    Text("đ 50,000,000")
                        .font(.custom("Ubuntu-Bold", size: 20))
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Tổng giao dịch")
                        .font(.system(size: 14))
                        .foregroundColor(Color(.systemGray))
                        .padding(.bottom, 1)
                    
                    Text("1200")
                        .font(.custom("Ubuntu-Bold", size: 20))
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
//        .frame(width: .screenWidth)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "ECEDF3"), lineWidth: 2)
        )
    }
}

#Preview {
    MerchantOverview()
}
