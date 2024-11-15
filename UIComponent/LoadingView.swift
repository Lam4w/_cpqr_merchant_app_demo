//
//  LoadingView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 08/11/2024.
//

import SwiftUI
import NVActivityIndicatorView

struct LoadingView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 2 : 0)
                
                ActivityIndicatorView(
                    isAnimating: self.isShowing,
                    type: .circleStrokeSpin,
                    size: 50
                )
                .frame(width: 50, height: 50)
            }
        }
    }
}
