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
    @State private var reloadTrigger = UUID()
    
    private var timer: DispatchSourceTimer?
    
    var body: some View {
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
            
            VStack{
                VStack{
                    Spacer()
                    if let qrImage = qrVM.qrData {
                        Image(uiImage: qrImage)
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .id(reloadTrigger)
                    } else {
                        Image(uiImage: UIImage(systemName: "xmark") ?? UIImage())
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .id(reloadTrigger)
                    }
                    
                    Spacer()
                }
                .frame(width: .screenWidth - 60, height: 350)
                .background(Color.gray.opacity(0.05))
                .cornerRadius(15)
                
                Spacer()
                
                Text("Thời gian hiệu lực:")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .padding(.top, 2)
                
                Text("15:00:00")
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    .padding(.top, 0)
                
            }
            .padding(28)
            .frame(width: .screenWidth - 40, height: 425)
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
        .frame(width: .screenWidth, height: .screenHeight)
        .background(.white)
        .cornerRadius(20)
        .onAppear{
            qrVM.callServiceGetQR()
        }
    }

    func reloadView() {
        reloadTrigger = UUID()
    }
}

//#Preview {
//    QRView()
//}
