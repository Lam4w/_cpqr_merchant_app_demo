//
//  PaymentAcceptedView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 20/09/2024.
//

import SwiftUI
import SwiftUIFontIcon

struct PaymentResultView: View {
//    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var homeVM = HomeViewModel.shared
    @StateObject var checkoutVM = CheckoutViewModel.shared
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
                        checkoutVM.showPaymentResult = false
                        checkoutVM.showTransactionConfirmation = false
//                        checkoutVM.isShowScanner = false
                    } label: {
                        FontIcon.text(.materialIcon(code: .home),fontsize: 25, color: .accent)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(.circle)
                    }
                }
                .padding(.top, 15)
                
                if checkoutVM.purchaseResponse?.payload.result.code == "00" {
                    FontIcon.text(.ionicon(code: .ios_done_all),fontsize: 100, color: .primary)
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
                        Text(checkoutVM.total)
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .bold()
                            .foregroundColor(.blue)
                        Text("vnd")
                            .multilineTextAlignment(.center)
                            .font(.title3)
                            .foregroundColor(.blue)
                    }
                        .padding(.bottom, 2)
                } else {
                    FontIcon.text(.ionicon(code: .ios_close),fontsize: 100, color: .red)
                        .padding(18)
                        .background(.ultraThinMaterial)
                        .clipShape(.circle)
                    
                    Text("Giao dịch không thành công!")
                        .multilineTextAlignment(.center)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.bottom, 1)
                    
                    HStack{
                        Text(checkoutVM.total)
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .bold()
                            .foregroundColor(.red)
                        Text("vnd")
                            .multilineTextAlignment(.center)
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                        .padding(.bottom, 2)
                }
                
                Text(getDisplayTime())
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
                    
                    Divider()
                    
                    HStack {
                        Text("Mã phản hồi")
                            .font(.title3)
                            .foregroundColor(.black)
                            .frame(height: 46)
                        
                        Spacer()
                        
                        Text((checkoutVM.purchaseResponse?.payload.result.code)!)
                            .font(.title3)
                            .foregroundColor(.black)
                            .frame(height: 46)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Nội dung")
                            .font(.title3)
                            .foregroundColor(.black)
                            .frame(height: 46)
                        
                        Spacer()
                        
                        Text((checkoutVM.purchaseResponse?.payload.result.message)!)
                            .font(.title3)
                            .foregroundColor(.black)
                            .frame(height: 46)
                    }
                }
                .padding(20)
                .background(Color.gray.opacity(0.05))
                .cornerRadius(15)
                .padding(.top, 0)
                
                Spacer()
                
                RoundedButton(title: "Thực hiện giao dịch mới") {
                    homeVM.selectTab = 1
                    checkoutVM.showPaymentResult = false
                    checkoutVM.showTransactionConfirmation = false
//                    checkoutVM.isShowScanner = false

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
    
    func getDisplayTime() -> String {
        let transDateString = checkoutVM.purchaseResponse?.payload.payment.transmisDateTime
        let transDate = Utils.convertToDate(from: (transDateString)!)
        let displayDate = Utils.formatDateToString(transDate!)
        
        return displayDate
    }
}

struct PaymentResultView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentResultView()
    }
}
