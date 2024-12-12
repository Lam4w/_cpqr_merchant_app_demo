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
//        let atc = Utils.generateRandom4DigitNunber()
//        print("atc: \(atc)")
//        let qrString = "85054350563031615a4f07a0000007271010500b4e415041532044454249549f250291235a0a9704119932984089ffff5f2d07456e676c69736857139704119932984089D27032110000000000FFFF9f19063131313131315f24032703315f34020000637c9f02060000000555559f03060000000000009f1a020704950500000080005f2a0207049a032411059c01009f37043D61CE659f34033F00009f2701809f3602\(atc)9f2608799A8B183C15B2649f10200FA501AA01F8040000000000000000000F010100000000000000000000000000820209008407A0000007271010"
//  
//        let res = Utils.encodeBase64(qrString)
        
        let res: String = "hQVDUFYwMWFaTwegAAAHJxAQUAtOQVBBUyBERUJJVJ8lApEjWgqXBBGZMphAif//Xy0HRW5nbGlzaFcTlwQRmTKYQInScDIRAAAAAAD//58ZBjExMTExMV8kAycDMV80AgAAY3GfAgYAAAAFVVWfAwYAAAAAAACfGgIHBJUFAAAAgABfKgIHBJoDJBEFnAEAnzcEPWHOZZ80Az8AAJ8nAYCfNgIAVp8QIA+lAaoB+AQAAAAAAAAAAAAPAQEAAAAAAAAAAAAAAAAAggIJAIQHoAAABycQEA=="
      
//        let res: String = "hQVDUFYwMWFaTwegAAAHJxAQUAtOQVBBUyBERUJJVJ8lApEjWgqXBBEREjRWeJEjXy0HRW5nbGlzaFcTlwQRESNFZ4kSPScDYBAAAAAAD58ZBjExMTExMV8kAycDMV80AgABY3yfAgYAAAAAAACfAwYAAAAAAACfGgIHBJUFAAAAAABfKgIHBJoDCRMxnAEAnzcEEjRWeJ80AyQAAp8nAYCfNgIBQ58mCJFWDZos2GiInxAgD6UBoAD4AAAAAAAAAAAAAA8AAAAAAAAAAAAAAAAAAACCAgkAhAegAAAHJxAQ"
        
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
