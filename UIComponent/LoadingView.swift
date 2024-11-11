//
//  LoadingView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 08/11/2024.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .blur(radius: self.isShowing ? 2 : 0)
                
                Loader()
                    .opacity(self.isShowing ? 1 : 0)
            }
        }
    }
}
