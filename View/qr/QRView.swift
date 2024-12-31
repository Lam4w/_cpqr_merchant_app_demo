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
                .padding(.bottom, 8)
                
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
                    
                    HStack {
                        Image("vietqr")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 45)
                        
                        Spacer()
                        
                        Image("napas")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 45)
                    }
                    
                    HStack {
                        
                        Spacer()
                        
                        Text("Hết hạn sau")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Text("\(formatTime(qrVM.timeRemaining)).")
                            .font(.subheadline)
//                            .foregroundColor(.red)
                        
                        Button {
                            qrVM.callServiceGetQR()
                        } label : {
                            Text("Cập nhật")
                                .bold()
                                .foregroundColor(.accent)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                    }
                    
                }
                .padding(28)
                .frame(width: .screenWidth - 40, height: 440)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
                
                HStack {
                    Text("Tài khoản/Thẻ")
                        .bold()
                    
                    Spacer()
                    
                    Button {
                        isShowingFundSource = true
                    } label: {
                        Text("Xem tất cả")
                            .foregroundColor(.accent)
                            .bold()
                        
                        FontIcon.text(.awesome5Solid(code: .chevron_right), fontsize: 15, color: .accent)
                    }
                }
                .padding(.vertical, 10)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(qrVM.fundSourceList , id: \.id, content: {
                            fsObj in
                            FundSourceHorList(fundSrc: fsObj)
                        })
                        
                        HStack {
                            HStack {
                                Image(systemName: "plus.square.on.square.fill")
                                    .foregroundColor(.accent)
                            }
                            .frame(width: 30, height: 30)
                            
//                            Text("Thêm nguồn tiền")
//                                .foregroundColor(.accent)
                        }
//                        .frame(minWidth: 150)
                        .padding(.vertical, 15)
                        .padding(.horizontal, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                    }
                }
                
                Spacer()
                
//                RoundedButton(title: "Tạo mã QR mới") {
//                    //                    reloadView()
//                    qrVM.callServiceGetQR()
//                }
//                .padding(.bottom, .bottomInsets + 80)
                
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
    
    // format the display time
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct FundSourceHorList: View {
    @StateObject var qrVM = QRViewModel.shared
    @State var fundSrc: FundSource = FundSource()
    
    var body: some View {
        Button {
            qrVM.curFundSource = fundSrc
        } label: {
            HStack {
                HStack {
                    Image(fundSrc.image)
                        .resizable()
                    //                            .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                }
                .frame(width: 30, height: 20)
                .padding(.vertical, 7)
                .padding(.horizontal, 5)
                .background(.white)
                .cornerRadius(5)
                
                VStack {
                    HStack {
                        Text(fundSrc.type)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .bold()
                        //                                .font(.caption)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text(fundSrc.token)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .font(.caption)
                        Spacer()
                    }
                }
                
                Spacer()
                
            }
            .frame(minWidth: 150)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 5)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
    }
}

#Preview {
    QRView()
}
