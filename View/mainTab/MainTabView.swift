//
//  MainTabView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI
import SwiftUIFontIcon

struct MainTabView: View {
    @StateObject var homeVM = HomeViewModel.shared
    @StateObject var mainVM = MainViewModel.shared
    
    var body: some View {
        GeometryReader{ _ in
            ZStack{
                if(homeVM.selectTab == 0 && mainVM.isMerchant) {
                    MerchantHomeView()
                }else if(homeVM.selectTab == 0) {
                    ClientHomeView()
                }else if(homeVM.selectTab == 1 && mainVM.isMerchant) {
                    CheckoutView()
                }else if(homeVM.selectTab == 1) {
                    QRView()
                }else if(homeVM.selectTab == 2) {
                    AccountView()
                }else if(homeVM.selectTab == 3) {
                    AccountView()
                }else if(homeVM.selectTab == 4) {
                    AccountView()
                }
                
                VStack{
                    
                    Spacer()
                    
                    HStack{
                        TabButton(title: "Trang chính", icon: .md_home, isSelect: homeVM.selectTab == 0) {
                            DispatchQueue.main.async {
                                withAnimation {
                                    homeVM.selectTab = 0
                                }
                            }
                        }
                        
                        TabButton(title: "Lịch sử", icon: .md_stats, isSelect: homeVM.selectTab == 3) {
//                            DispatchQueue.main.async {
//                                withAnimation {
//                                    homeVM.selectTab = 3
//                                }
//                            }
                        }
                        
                        TabButton(title: "QR", icon: .md_qr_scanner, isSelect: homeVM.selectTab == 1) {
                            DispatchQueue.main.async {
                                withAnimation {
                                    homeVM.selectTab = 1
                                }
                            }
                        }
                        
                        TabButton(title: "Thẻ", icon: .md_card, isSelect: homeVM.selectTab == 4) {
//                            DispatchQueue.main.async {
//                                withAnimation {
//                                    homeVM.selectTab = 4
//                                }
//                            }
                        }
                        
                        TabButton(title: "Tài khoản", icon: .md_person, isSelect: homeVM.selectTab == 2) {
//                            DispatchQueue.main.async {
//                                withAnimation {
//                                    homeVM.selectTab = 2
//                                }
//                            }
                        }
                    }
                    .padding(.top, 15)
                    .padding(.bottom, .bottomInsets)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: -2)
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainTabView()
        }
        
    }
}
