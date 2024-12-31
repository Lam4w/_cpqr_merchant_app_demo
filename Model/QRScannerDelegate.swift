//
//  QRScannerDelegate.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 25/12/24.
//

import SwiftUI
import AVKit

class QRScannerDelegate: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var scannedCode: String?
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection){
        if let metaObject = metadataObjects.first{
            guard let readableObject = metaObject as? AVMetadataMachineReadableCodeObject else {return}
            guard let scannedCode = readableObject.stringValue else {return}
            self.scannedCode = scannedCode
        }
    }
}
