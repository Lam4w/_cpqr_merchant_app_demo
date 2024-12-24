//
//  Test.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

struct CountdownView: View {
    @State private var timeRemaining = 180 // 3 minutes = 180 seconds
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            Text(formatTime(timeRemaining))
                .font(.largeTitle)
                .padding()
            
            Button(action: startCountdown) {
                Text("Bắt đầu đếm ngược")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onDisappear {
            timer?.invalidate() // stop the timer when the remaining time runs out
        }
    }
    
    // start the counr down
    func startCountdown() {
        timer?.invalidate() // delete the old timer if exists
        timeRemaining = 180
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                countdownDidFinish()
            }
        }
    }
    
    // called when the timer finishes
    func countdownDidFinish() {
        print("Thời gian kết thúc!")
        // Gọi bất kỳ logic nào bạn muốn ở đây
    }
    
    // format the display time
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ContentView: View {
    var body: some View {
        CountdownView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

