//
//  PaymentFailure.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 08/11/2024.
//

import SwiftUI
import SwiftUIFontIcon

struct PaymentFailure: View {
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
//                            mode.wrappedValue.dismiss()
                            homeVM.selectTab = 0
                            checkoutVM.showPaymentAccepted = false
                            checkoutVM.showTransactionConfirmation = false
                        } label: {
                            FontIcon.text(.materialIcon(code: .home),fontsize: 25, color: .blue)
                                .padding(12)
                                .background(.ultraThinMaterial)
                                .clipShape(.circle)
                        }
                    }
                    .padding(.top, 15)
                    
                    FontIcon.text(.ionicon(code: .ios_close),fontsize: 60, color: .red)
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
                        Text("250.000")
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
                    
                    Text("14:53 Thứ Sáu 23/08/2024")
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
                            
                            Text("101")
                                .font(.title3)
                                .foregroundColor(.black)
                                .frame(height: 46)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Nội dung phản hồi")
                                .font(.title3)
                                .foregroundColor(.black)
                                .frame(height: 46)
                            
                            Spacer()
                            
                            Text("INVAIID FORMAT")
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
                        checkoutVM.showPaymentAccepted = false
                        checkoutVM.showTransactionConfirmation = false

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
    }

    struct PaymentFailureView_Previews: PreviewProvider {
        static var previews: some View {
            PaymentFailure()
        }
    }
