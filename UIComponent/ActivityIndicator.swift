//
//  ActivityIndicator.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 13/11/2024.
//

import SwiftUI
import NVActivityIndicatorView

struct ActivityIndicatorView: UIViewRepresentable {
    var isAnimating: Bool
    var type: NVActivityIndicatorType
    var size: CGFloat

    func makeUIView(context: Context) -> NVActivityIndicatorView {
        let indicator = NVActivityIndicatorView(
            frame: CGRect(x: 0, y: 0, width: size, height: size),
            type: type,
            color: UIColor(Color.blue)
        )
        return indicator
    }

    func updateUIView(_ uiView: NVActivityIndicatorView, context: Context) {
        if isAnimating {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}

