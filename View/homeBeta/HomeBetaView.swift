//
//  HomeBetaView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 12/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct HomeBetaView: View {
    var body: some View {
        VStack {
            ScrollView {
//                HStack {
//                    SearchTextField(placholder: "Tìm kiếm", txt: $homeVM.txtSearch)
//                        .padding(.horizontal, 0)
//                        .padding(.vertical, 5)
//                    Spacer()
//                    
//                    FontIcon.button(.ionicon(code: .md_notifications), action: {},fontsize: 25)
//                        .padding(12)
//                        .background(.ultraThinMaterial)
//                        .clipShape(.circle)
//                    
//                    FontIcon.button(.ionicon(code: .md_list), action: {},fontsize: 25)
//                        .padding(12)
//                        .background(.ultraThinMaterial)
//                        .clipShape(.circle)
//                }
                VStack {
                    ZStack(alignment: .top) {
                        Image("coffeeMerchantBG")
                            .resizable()
//                            .scaledToFit()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: .screenWidth, height: 160)
                    }
                        
//                        noti
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 10) {
                            Image("merchantLogo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 90, height: 90)
                                .cornerRadius(20)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Cafe Bistro")
                                    .font(.system(size: 26, weight: .semibold))
                                    .foregroundColor(.black)
                                
                                Text("M-31, Bhopal, Madhya Pradesh")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)
                                
                                HStack(spacing: 6) {
                                    Text("4.3")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 6)
                                        .background(Color.blue)
                                        .cornerRadius(6)
                                    
                                    Text("Rating (562)")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.gray)
                                }
                                .padding(.top, 6)
                            }
                        }
                        
                        //                    QuickActionsView()
                        //
                        //                    ManagementActionsView()
                        
                        HStack{
                            
                            Text("Tài khoản").bold()
                            
                            Spacer()
                        }.padding(.top, 0)
                        
                        HStack{
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Số dư")
                                    .font(.subheadline)
                                HStack{
                                    Text("250.000")
                                        .font(.title2)
                                        .bold()
                                    Text("vnd")
                                        .font(.title3)
                                }
                            }
                            Spacer()
                            
                            Button(action: {
                                
                            }) {
                                
                                FontIcon.button(.ionicon(code: .md_add), action: {},fontsize: 30)
                                    .padding(14)
                                    .background(.ultraThinMaterial)
                                    .clipShape(.circle)
                            }
                        }
                        .padding(20)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(15)
                        .padding(.top, 0)
                        
                        HStack{
                            
                            Text("Dịch vụ").bold()
                            
                            Spacer()
                            
                        }.padding(.top, 5)
                        
//                        Services()
                    }
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(20)
                }
//                .background(Color(.blue))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white, lineWidth: 1)
                )
                .frame(maxWidth: .infinity)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeBetaView()
}

