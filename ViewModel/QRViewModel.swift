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
    static var shared: QRViewModel = QRViewModel()
    
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var qr = UIImage(systemName: "xmark") ?? UIImage()
 
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func callServiceGetQR() {
        ServiceCall.get(path: Path.GET_QR) { responseObj in
            guard let responseData = responseObj else {
                self.handleError(message: "Empty response data")
                return
            }

            do {
                let qrResponse = try self.decodeResponse(from: responseData)
                
                let stringData = Data(qrResponse.payload.qr.utf8)
                
                self.filter.setValue(stringData, forKey: "inputMessage")
                
                if let qrCodeImage = self.filter.outputImage {
                    if let qrCodeCGImage = self.context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                        self.qr =  UIImage(cgImage: qrCodeCGImage)
                    }
                }
                
                self.qr = UIImage(systemName: "xmark") ?? UIImage()
            } catch {
//                self.isLoading = false
                self.handleError(message: "Decoding error: \(error)")
                return
            }
        } failure: { error in
//            self.isLoading = false
            print("Service call get qr failed with error: \(String(describing: error))")
            self.handleError(message: "Server error")
        }
        
//        let res: String = "hQVDUFYwMWFaTwegAAAHJxAQUAtOQVBBUyBERUJJVJ8lApEjWgqXBBGZMphAif//Xy0HRW5nbGlzaFcTlwQRmTKYQInScDIRAAAAAAD//58ZBjExMTExMV8kAycDMV80AgAAY3GfAgYAAAAFVVWfAwYAAAAAAACfGgIHBJUFAAAAgABfKgIHBJoDJBEFnAEAnzcEPWHOZZ80Az8AAJ8nAYCfNgIAVp8QIA+lAaoB+AQAAAAAAAAAAAAPAQEAAAAAAAAAAAAAAAAAggIJAIQHoAAABycQEA=="
    }
    
    func decodeResponse(from data: Data) throws -> GenerateQrResponse {
        let decoder = JSONDecoder()
        return try decoder.decode(GenerateQrResponse.self, from: data)
    }
    
    func handleError(message: String) {
        print(message)
        self.showError = true
        self.errorMessage = message
    }
}
