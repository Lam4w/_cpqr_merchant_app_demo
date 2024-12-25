//
//  CameraView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 25/12/24.
//

struct CameraView: UIViewRepresentable{
    var frameSize: CGSize
    
    /// Camera Session
    @Binding var session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView{
        /// Defining camera frame size
        let view = UIViewType(frame: CGRect(origin: .zero, size: frameSize))
        view.backgroundColor = .clear
        
        let cameraLayer = AVCaptureVideoPreviewLayer(session: session)
        cameraLayer.frame = .init(origin: .zero, size: frameSize)
        cameraLayer.videoGravity = .resizeAspectFill
        cameraLayer.masksToBounds = true
        view.layer.addSublayer(cameraLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context){
        
    }
    
}