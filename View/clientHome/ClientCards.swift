//
//  ClientCards.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 18/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct ClientCards: View {
    var body: some View {
        HStack {
            Text("Thẻ")
                .bold()
                .font(.system(size: 20))
                .foregroundColor(.foreground)
            
            Spacer()
            HStack {
                Button(action: {
                    
                }) {
                    
                    FontIcon.button(.ionicon(code: .md_add), action: {},fontsize: 30)
                        .padding(14)
                        .background(Color.mutedBackground)
                        .foregroundColor(.secondary)
                        .clipShape(.circle)
                }
            }
            
            
            HStack(spacing: 5) {
                Image("card1")
                    .resizable()
//                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 60)
                    .cornerRadius(3)
                    .shadow(color: .foreground.opacity(0.7), radius: 3, x: 0, y: 0)
                
                Image("card2")
                    .resizable()
//                                            .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 60)
                    .cornerRadius(3)
                    .shadow(color: .foreground.opacity(0.7), radius: 3, x: 0, y: 0)
            }
        }
    }
}

#Preview {
    ClientCards()
}
