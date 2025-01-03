//
//  ScannerView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 25/12/24.
//

import SwiftUI
import AVKit
import SwiftUIFontIcon

struct ScannerView: View {
    @StateObject var checkoutVM = CheckoutViewModel.shared
    /// QR Code Scanner properties
    @State private var isScanning: Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    
    /// QR scanner AV Output
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    
    /// Error properties
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @Environment(\.openURL) private var openURL
    
    /// Camera QR Output delegate
    @StateObject private var qrDelegate = QRScannerDelegate()
    
    /// Scanned code
    @State private var scannedCode: String = ""
    
    var body: some View {
        ZStack {
            CameraView(frameSize: UIScreen.main.bounds.size, session: $session)
                .ignoresSafeArea()
            
            Rectangle()
                .fill(.black.opacity(0.3))
                .ignoresSafeArea()
            
            VStack(spacing: 8) {
                HStack {
                    Button {
                        checkoutVM.isShowScanner = false
                    } label: {
                        FontIcon.text(.awesome5Solid(code: .chevron_left),fontsize: 25, color: .white)
                    }
                    
                    Spacer()
                }
                .padding(10)
                
                Text("Quét mã QR")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .bold()

                Text("Đưa mã QR và trong khung để quét")
                    .font(.callout)
                    .foregroundColor(.white)

                Spacer(minLength: 0)

                GeometryReader { geometry in
                    let size = geometry.size
                    ZStack {
                        // Transparent scanner area
                        RoundedRectangle(cornerRadius: 10)
                            .blendMode(.destinationOut)
//                            .fill(Color.clear)
                            .frame(width: size.width, height: size.width)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
//                                    .blendMode(.destinationOut)
                                    .stroke(Color.white, lineWidth: 3)
                            )
                        // Scanner corners
                        ForEach(0...4, id: \.self) { index in
                            let rotation = Double(index) * 90
                            RoundedRectangle(cornerRadius: 2, style: .circular)
                                .trim(from: 0.61, to: 0.64)
                                .stroke(Color.white, style: StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round))
                                .rotationEffect(.init(degrees: rotation))
                        }
                    }
                    .frame(width: size.width, height: size.width)

                    // Scanning animation
                    .overlay(alignment: .top, content: {
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 2.5)
                            .shadow(color: .white.opacity(0.8), radius: 8, x: 0, y: isScanning ? 15 : -15)
                            .offset(y: isScanning ? size.width : 0)
                    })
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 45)
//                .padding(.bottom, 45)
                
                Spacer(minLength: 0)

                VStack {
                    HStack(spacing: 10) {
                        Spacer()
                        Image("vietqr")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 35)
                        Divider()
                        Image("napas")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 35)
                            .padding(.top, 5)
                        
                        Spacer()
                    }
                    .frame(height: 30)
                    .padding(.top, 40)
                    
                    Spacer()
                }
                                
                Spacer(minLength: 15)

                Button {
                    if !session.isRunning && cameraPermission == .approved {
                        reactivateCamera()
                        activateScannerAnimation()
                    }
                } label: {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }

                Spacer(minLength: 45)
            }
            .padding(15)
//            .padding(.top, .topInsets)
            
        }
        // Checking camera permission, when the view is visible
        .onAppear(perform: checkCameraPermisssion)
        .alert(errorMessage, isPresented: $showError){
            // Showing settings button, if permission is denined
            if cameraPermission == .denied{
                Button("Settings"){
                    let settingString = UIApplication.openSettingsURLString
                    if let settingURL = URL(string: settingString){
                        /// Opening Apps setting, using openURL SwiftUI API
                        openURL(settingURL)
                    }
                }
                
                // Along with cancel button
                Button("Cancel", role: .cancel){
                }
            }
        }
        .onDisappear{
            session.stopRunning()
        }
        .onChange(of: qrDelegate.scannedCode){ newValue in
            if let code = newValue{
                checkoutVM.handleScanResult(result: code)
                scannedCode = code
                
                // When the first code scan is available, immediately stop the camera.
                session.stopRunning()
                
                // Stopping scanner animation
                deActivateScannerAnimation()
                // Clearing the data on delegate
                
//                qrDelegate.scannedCode = nil
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
    
    func reactivateCamera(){
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
    
    // Activating Scanner Animation Method
    func activateScannerAnimation(){
        // Adding Delay for each reversal
        withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)){
            isScanning = true
        }
    }
    
    // DeActivating scanner animation method
    func deActivateScannerAnimation(){
        /// Adding Delay for each reversal
        withAnimation(.easeInOut(duration: 0.85)){
            isScanning = false
        }
    }
    
    
    // Checking camera permission
    func checkCameraPermisssion(){
        Task{
            switch AVCaptureDevice.authorizationStatus(for: .video){
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty{
                    /// New setup
                    setupCamera()
                }else{
                    /// Already existing one
                    reactivateCamera()
                }
            case .notDetermined:
                /// Requesting camera access
                if await AVCaptureDevice.requestAccess(for: .video){
                    /// Permission Granted
                    cameraPermission = .approved
                    setupCamera()
                }else{
                    /// Permission Denied
                    cameraPermission = .denied
                    /// Presenting Erro message
                    presentError("Vui lòng cấp quyền sử dụng camera")
                    
                }
            case .denied, .restricted:
                cameraPermission = .denied
            default: break
            }
        }
    }
    
    /// Setting up camera
    func setupCamera(){
        do{
            ///Finding back camera
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInUltraWideCamera, .builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else{
                presentError("UNKNOWN DEVICE ERROR")
                return
            }
            
            /// Camera input
            let input = try AVCaptureDeviceInput(device: device)
            /// For Extra Safety
            /// Checking whether input & output can be added to the session
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else{
                presentError("UNKNOWN INPUT/OUTPUT ERROR")
                return
            }
            
            /// Adding input & output to camera session
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            /// Setting output config to read qr codes
            qrOutput.metadataObjectTypes = [.qr]
            /// Adding delegate to retreive the fetched qr code from camera
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            session.commitConfiguration()
            /// Note session must be started on background thread
            
            DispatchQueue.global(qos: .background).async{
                session.startRunning()
            }
            activateScannerAnimation()
        }catch{
            presentError(error.localizedDescription)
        }
    }
    
    // Presenting Error
    func presentError(_ message: String){
        errorMessage = message
        showError.toggle()
    }
    
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
