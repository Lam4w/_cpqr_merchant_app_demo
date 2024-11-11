//
//  QRViewModel.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 22/09/2024.
//

import SwiftUI
import Foundation
import CoreImage.CIFilterBuiltins

class QRViewModel: ObservableObject {
    static var share: QRViewModel = QRViewModel()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func callServiceGetQR() -> UIImage {
        let res: String = "hQVDUFYwMWFaTwegAAAHJxAQUAtOQVBBUyBERUJJVJ8lApEjWgqXBBEREjRWeJEjXy0HRW5nbGlzaFcTlwQRESNFZ4kSPScDYBAAAAAAD58ZBjExMTExMV8kAycDMV80AgABY3yfAgYAAAAAAACfAwYAAAAAAACfGgIHBJUFAAAAAABfKgIHBJoDCRMxnAEAnzcEEjRWeJ80AyQAAp8nAYCfNgIBQ58mCJFWDZos2GiInxAgD6UBoAD4AAAAAAAAAAAAAA8AAAAAAAAAAAAAAAAAAACCAgkAhAegAAAHJxAQ"
        
        let stringData = Data(res.utf8)
        
        filter.setValue(stringData, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        
        return UIImage(systemName: "xmark") ?? UIImage()
    }
    
}
