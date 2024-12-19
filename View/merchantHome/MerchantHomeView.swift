//
//  HomeBetaView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 12/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct MerchantHomeView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ZStack(alignment: .top) {
                        Image("merchantBG1")
                            .resizable()
//                            .scaledToFit()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: .screenWidth, height: 200)
                        
                        HStack {
                            Spacer()
                            
                            FontIcon.button(.ionicon(code: .md_notifications), action: {},fontsize: 30)
                                .padding(12)
                                .background(Color(.white))
                                .clipShape(.circle)
        
                            FontIcon.button(.ionicon(code: .md_list), action: {},fontsize: 30)
                                .padding(12)
                                .background(Color(.white))
                                .clipShape(.circle)
                        }
                        .padding(.horizontal, 15)
                        .padding(.top, 30)
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 20) {
                            Image("merchantLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                                .cornerRadius(15)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                HStack(spacing: 10) {
                                    Text("Cafe Bistro")
                                        .font(.system(size: 26, weight: .semibold))
                                        .foregroundColor(.black)
                                    
                                    FontIcon.text(.ionicon(code: .ios_done_all),fontsize: 20, color: .white)
                                        .padding(5)
                                        .background(Color.green)
                                        .clipShape(.circle)
                                }
                                Text("83B Lý Thường Kiệt")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.foreground)
                                
                                HStack {
                                    HStack {
                                        Text("Powered by")
                                            .foregroundColor(.gray)
                                        Image("napas")
                                            .resizable()
                                        //                                            .scaledToFit()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 60, height: 20)
                                            .padding(.horizontal, 5)
                                            .padding(.top, 3)
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                        
                        MerchantOverview()
                        
                        MerchantServices()
                        
                        MerchantTransactionListView()
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(20)
                }
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white, lineWidth: 1)
                )
                .frame(maxWidth: .infinity)
            }
        }
        .ignoresSafeArea()
        .padding(.bottom, .bottomInsets + 60)
        .disableBounces()
    }
}

#Preview {
    MerchantHomeView()
}

