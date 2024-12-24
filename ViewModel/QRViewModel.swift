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
    @Published var isSucccessful: Bool = false
    @Published var qrData: UIImage? = nil
    @Published var fundSourceList = [FundSource(type: "Tài khoản", image: "napas", token: "121323463"), FundSource(type: "Thẻ", image: "napas", token: "123123132123123"), FundSource(type: "Thẻ", image: "napas", token: "12123123123123")]
    @Published var curFundSource: FundSource = FundSource(type: "Tài khoản", image: "napas", token: "121323463")
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func callServiceGetQR() -> () {
        return ServiceCall.get(path: Path.GET_QR) { responseObj in
            guard let responseData = responseObj else {
                self.handleError(message: "Empty response data")
                return
            }
            
            do {
                let qrResponse = try self.decodeResponse(from: responseData)
                
                self.qrData = self.setQr(qrResponse.payload.qr)
                
            } catch {
                self.handleError(message: "Decoding error: \(error)")
                return
            }
        } failure: { error in
            print("Service call get qr failed with error: \(String(describing: error))")
        }
    }
    
    func setQr(_ response: String) -> UIImage {
        let stringData = Data(response.utf8)

        self.filter.setValue(stringData, forKey: "inputMessage")
        
        if let qrCodeImage = self.filter.outputImage {
            if let qrCodeCGImage = self.context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        
        return UIImage(systemName: "paperplane") ?? UIImage()
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
