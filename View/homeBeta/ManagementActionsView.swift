//
//  ManagementActionsView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 12/12/24.
//

import SwiftUI

struct ManagementActionsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 10) {
                ForEach(0..<4) { index in
                    AsyncImage(url: URL(string: "http://b.io/ext_\(index + 8)-&format=webp")) { image in
                        image.resizable()
                            .frame(width: 25, height: 25)
                    } placeholder: {
                        Color.clear
                    }
                }
            }
            
            HStack(spacing: 12) {
                Text("My Designs")
                Text("My Promotions")
                Text("My Discount")
                Text("Settings")
            }
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.blue)
        }
        .padding(.top, 14)
    }
}

#Preview {
    ManagementActionsView()
}
