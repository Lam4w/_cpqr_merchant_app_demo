import SwiftUI
import NVActivityIndicatorView

struct ActivityIndicatorView: UIViewRepresentable {
    var isAnimating: Bool
    var type: NVActivityIndicatorType
    var color: UIColor
    var size: CGFloat

    func makeUIView(context: Context) -> NVActivityIndicatorView {
        let indicator = NVActivityIndicatorView(
            frame: CGRect(x: 0, y: 0, width: size, height: size),
            type: type,
            color: color
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
