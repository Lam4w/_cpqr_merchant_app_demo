//
//  QuickActionsView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 12/12/24.
//

import SwiftUI

struct QuickActionsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 10) {
                ForEach(0..<4) { index in
                    AsyncImage(url: URL(string: "http://b.io/ext_\(index + 4)-&format=webp")) { image in
                        image.resizable()
                            .frame(width: 25, height: 25)
                    } placeholder: {
                        Color.clear
                    }
                }
            }
            
            HStack(spacing: 16) {
                Text("Manage\nQR")
                Text("Provider\nWallet")
                Text("POS QR")
                Text("Received\nPayments")
            }
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.blue)
            .multilineTextAlignment(.center)
        }
        .padding(.top, 16)
    }

}

#Preview {
    QuickActionsView()
}
