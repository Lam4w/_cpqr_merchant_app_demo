//
//  PaymentConfirmationView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 20/09/2024.
//

import SwiftUI
import SwiftUIFontIcon

struct PaymentConfirmationView: View {
    @StateObject var checkoutVM = CheckoutViewModel.shared
    @StateObject var homeVM = HomeViewModel.shared
    
    var body: some View {
        LoadingView(isShowing: $checkoutVM.isLoading) {
            ZStack{
                VStack{
                    HStack{
                        FontIcon.button(.awesome5Solid(code: .chevron_left), action: {
                            checkoutVM.showTransactionConfirmation = false
                        },fontsize: 25)
                        .foregroundColor(.gray)
                        
                        Image("napas")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110, height: 110)
                            .padding(.leading, 5)
                        
                        Spacer()
                        
                        Button {
                            homeVM.selectTab = 0
                            checkoutVM.showTransactionConfirmation = false
                            
                        } label: {
                            FontIcon.text(.materialIcon(code: .home),fontsize: 25, color: .accent)
                                .padding(12)
                                .background(.ultraThinMaterial)
                                .clipShape(.circle)
                        }
                    }
                    .padding(.top, 15)
                    
                    //                Spacer()
                    
                    VStack{
//                        HStack {
//                            Text("Nội dung")
//                                .font(.title3)
//                                .foregroundColor(.black)
//                                .frame(height: 46)
//                            
//                            Spacer()
//                            
//                            Text("Thanh toan ABC")
//                                .font(.title3)
//                                .foregroundColor(.black)
//                                .frame(height: 46)
//                        }
                        
                        //                    Divider()
                        
                        HStack {
                            Text("Phí chuyển tiền")
                                .font(.title3)
                                .foregroundColor(.black)
                                .frame(height: 46)
                            
                            Spacer()
                            
                            Text("Miễn phí")
                                .font(.title3)
                                .foregroundColor(.black)
                                .frame(height: 46)
                        }
                        
                        //                    Divider()
                        
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
                            Text("Số tiền")
                                .font(.title3)
                                .foregroundColor(.black)
                                .frame(height: 46)
                            
                            Spacer()
                            
                            HStack{
                                Text(checkoutVM.total)
                                    .multilineTextAlignment(.center)
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.blue)
                                Text("VND")
                                    .multilineTextAlignment(.center)
                                    .font(.title3)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding(20)
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(15)
                    .padding(.top, 0)
                    
                    Spacer()
                    
                    VStack {
                        HStack{
                            FontIcon.text(.ionicon(code: .md_alert),fontsize: 35, color: .blue)
                                .opacity(0.9)
                            
                            VStack{
                                HStack{
                                    Text("Quý khách vui lòng")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("kiểm tra và xác nhận")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.black)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                Text("thông tin giao dịch.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                            }
                        }
                    }
                    
                    RoundedButton(title: "Xác nhận") {
                        checkoutVM.serviceCallCreatePayment()
                    }
                }
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .ignoresSafeArea()
            .padding(.horizontal, 20)
            .padding(.bottom , .bottomInsets)
            .background(NavigationLink(destination: PaymentResultView(), isActive: $checkoutVM.showPaymentResult  , label: {
                EmptyView()
            }) )
        }
    }
}

#Preview {
    PaymentConfirmationView()
}
