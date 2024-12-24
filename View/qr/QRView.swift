//
//  QRView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 21/09/2024.
//

import SwiftUI
import SwiftUIFontIcon

struct QRView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var qrVM = QRViewModel.shared
    @StateObject var homeVM = HomeViewModel.shared
    
    @State private var isShowingFundSource: Bool = false
    @State private var reloadTrigger = UUID()
    
    @State private var timeRemaining = 180 // 3 minutes = 180 seconds
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    Text("Tạo QR thanh toán")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Button {
                        //                    mode.wrappedValue.dismiss()
                        homeVM.selectTab = 0
                    } label: {
                        FontIcon.text(.materialIcon(code: .close),fontsize: 20, color: .black)
                            .padding(5)
                            .background(.ultraThinMaterial)
                            .clipShape(.circle)
                    }
                }
                .padding(.top, 5)
                .padding(.bottom, 5)
                
                VStack {
                    Text("Đưa mã QR dưới đây cho điểm bán để thực hiện thanh toán cho đơn hàng của bạn")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 13)
                
                Button {
                    isShowingFundSource = true
                } label: {
                    HStack {
                        HStack {
                            Image(qrVM.curFundSource.image)
                                .resizable()
                            //                                            .scaledToFit()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 12)
                                .padding(.horizontal, 5)
                                .padding(.top, 3)
                        }
                        .padding(.vertical, 7)
                        .padding(.horizontal, 5)
                        .background(.white)
                        .cornerRadius(5)
                        
                        VStack {
                            HStack {
                                Text(qrVM.curFundSource.type)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .font(.caption)
                                
                                Spacer()
                            }
                            
                            HStack {
                                Text(qrVM.curFundSource.token)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .font(.caption)
                                Spacer()
                            }
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(Color.accent)
                    }
                    .padding(15)
                    
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(Color.foreground.opacity(0.05))
                .cornerRadius(15)
                
                VStack{
                    VStack{
                        Spacer()
                        if let qrImage = qrVM.qrData {
                            Image(uiImage: qrImage)
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 230, height: 230)
                                .id(reloadTrigger)
                        } else {
                            Image(uiImage: UIImage(systemName: "xmark") ?? UIImage())
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 230, height: 230)
                                .id(reloadTrigger)
                        }
                        
                        Spacer()
                    }
                    .frame(width: .screenWidth - 90, height: 300)
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(15)
                    
                    Spacer()
                    
                    Text("Thời gian hiệu lực:")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .padding(.top, 2)
                    
                    Text(formatTime(timeRemaining))
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .padding(.top, 0)
                    
                }
                .padding(28)
                .frame(width: .screenWidth - 40, height: 400)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                
                Spacer()
                
                RoundedButton(title: "Tạo mã QR mới") {
                    //                    reloadView()
                    qrVM.callServiceGetQR()
                }
                .padding(.bottom, .bottomInsets + 80)
                
            }
            .padding(.horizontal, 20)
            .padding(.top, .topInsets)
            
            FundSourceListView(isShowing: $isShowingFundSource)
        }
        .frame(width: .screenWidth, height: .screenHeight)
        .background(.white)
        .onAppear{
            qrVM.callServiceGetQR()
        }
    }

    func reloadView() {
        reloadTrigger = UUID()
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
        qrVM.callServiceGetQR()
    }
    
    // format the display time
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    QRView()
}
