//
//  ClientPaymentResultView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 19/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct ClientPaymentResultView: View {
//    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var homeVM = HomeViewModel.shared
    @StateObject var qrVM = QRViewModel.shared
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Image("napas")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 110)
                    
                    Spacer()
                    
                    Button {
                        homeVM.selectTab = 0
//                        checkoutVM.showPaymentResult = false
//                        checkoutVM.showTransactionConfirmation = false
                    } label: {
                        FontIcon.text(.materialIcon(code: .home),fontsize: 25, color: .accent)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(.circle)
                    }
                }
                .padding(.top, 15)
                
                FontIcon.text(.ionicon(code: .ios_done_all),fontsize: 60, color: .primary)
                    .padding(18)
                    .background(Color.mutedBackground)
                    .clipShape(.circle)
                
                Text("Giao dịch thành công!")
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.black)
                    .padding(.bottom, 1)
                
                HStack{
                    Text("200.000")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .bold()
                        .foregroundColor(.accent)
                    Text("vnd")
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .foregroundColor(.accent)
                }
                    .padding(.bottom, 2)
                
                Text("18/12/2024")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.bottom, 20)

                VStack{
                    HStack {
                        Text("Phương thức thanh toán")
                            .font(.title3)
                            .foregroundColor(.black)
                            .frame(height: 46)
                        
                        Spacer()
                        
                        Image(systemName: "qrcode.viewfinder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 20)
                    }
                }
                .padding(20)
                .background(Color.gray.opacity(0.05))
                .cornerRadius(15)
                .padding(.top, 0)
                
                Spacer()
                
                RoundedButton(title: "OK") {
                    homeVM.selectTab = 1
//                    checkoutVM.showPaymentResult = false
//                    checkoutVM.showTransactionConfirmation = false

                }
            }
            .padding(.horizontal, 20)
            
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .padding(.bottom , .bottomInsets)
    }
    
//    func getDisplayTime() -> String {
//        let transDateString = checkoutVM.purchaseResponse?.payload.payment.transmisDateTime
//        let transDate = Utils.convertToDate(from: (transDateString)!)
//        let displayDate = Utils.formatDateToString(transDate!)
//        
//        return displayDate
//    }
}

#Preview {
    ClientPaymentResultView()
}
