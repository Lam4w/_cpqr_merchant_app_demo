//
//  ActivityIndicator.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 08/11/2024.
//

import Foundation
import SwiftUI

struct Loader: View {
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from:0, to: 0.7)
                .stroke(Color.blue, lineWidth: 4)
                .frame(width: 60, height: 60)
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .foregroundColor(Color.blue)
                .onAppear() {
                    withAnimation(Animation
                        .linear(duration: 1)
                        .repeatForever(autoreverses: false)
                    ) {
                        self.isAnimating = true
                    }
                }
        }
    }
}

#Preview {
    Loader()
}
