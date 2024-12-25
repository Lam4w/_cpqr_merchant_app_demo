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
    @Published var fundSourceList = [FundSource(type: "Tài khoản", image: "vcb", token: "1016868016"), FundSource(type: "Thẻ", image: "napas", token: "970413 ... 9704"), FundSource(type: "Thẻ", image: "napas", token: "970414 ... 9705")]
    @Published var curFundSource: FundSource = FundSource(type: "Tài khoản", image: "vcb", token: "1016868016")
    @Published var timeRemaining = 180 // 3 minutes = 180 seconds
    @Published var timer: Timer?
    
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
                self.startCountdown()
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
    
    // start the counr down
    func startCountdown() {
        self.timer?.invalidate() // delete the old timer if exists
        self.timeRemaining = 180
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                self.countdownDidFinish()
            }
        }
    }
    
    // called when the timer finishes
    func countdownDidFinish() {
        self.callServiceGetQR()
    }
}
