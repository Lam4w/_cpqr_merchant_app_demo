//
//  Test.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

struct CountdownView: View {
    @State private var timeRemaining = 180 // 3 phút = 180 giây
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
            timer?.invalidate() // Dừng timer khi view biến mất
        }
    }
    
    // Function khởi động đếm ngược
    func startCountdown() {
        timer?.invalidate() // Xóa timer cũ nếu có
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
    
    // Function gọi khi thời gian đếm ngược kết thúc
    func countdownDidFinish() {
        print("Thời gian kết thúc!")
        // Gọi bất kỳ logic nào bạn muốn ở đây
    }
    
    // Function định dạng thời gian hiển thị
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

