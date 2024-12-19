//
//  RoundedButton.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

struct RoundedButton: View {
    @State var title: String = ""
    var clicked: () -> ()
    
    var body: some View {
        Button {
            clicked()
        } label: {
            Text(title)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .font(.title2)
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
        .background(Color.accent)
        .cornerRadius(20)
    }
}

#Preview {
    RoundedButton(title: "Button") {
        
    }
}
