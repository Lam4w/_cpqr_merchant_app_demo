//
//  TimerManager.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 19/12/24.
//

import Foundation

class TimerManager: ObservableObject {
    @Published var paymentNotification: NotificationQrResponse?
    @Published var isSucccessful = false
    var qrVM = QRViewModel.shared
    private var timer: DispatchSourceTimer?

    func startTimer() {
        let queue = DispatchQueue.global(qos: .userInitiated)
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.schedule(deadline: .now(), repeating: 3.0)

        timer?.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                ServiceCall.get(path: Path.GET_NOTI_PURCHASE) { responseObj in
                    guard let responseData = responseObj else {
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        
                        self?.paymentNotification = try decoder.decode(NotificationQrResponse.self, from: responseData)
                        
                    } catch {
                        return
                    }
                    
                    print("checking response \(String(describing: self?.paymentNotification?.payload.payment.status))")
                    
                    if ((self?.paymentNotification?.payload.payment.status) != nil && (self?.paymentNotification?.payload.payment.status)!) {
                        self?.isSucccessful = true
                    }
                } failure: { error in
                    print("Service call purchase failed with error: \(String(describing: error))")
                }
            
            }
        }

        timer?.resume()
    }

    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
}
