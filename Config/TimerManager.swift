//
//  TimerManager.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 19/12/24.
//

import Foundation

class TimerManager: ObservableObject {
    @Published var timerAction: String = "Waiting..."
    private var timer: DispatchSourceTimer?

    func startTimer() {
        let queue = DispatchQueue.global(qos: .userInitiated)
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer?.schedule(deadline: .now(), repeating: 10.0)

        timer?.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                self?.timerAction = "Timer fired at \(Date())"
            }
        }

        timer?.resume()
    }

    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
}