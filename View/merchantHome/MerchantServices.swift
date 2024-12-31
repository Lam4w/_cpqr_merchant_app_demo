//
//  Services.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 13/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct MerchantServices : View {
    @StateObject var homeVM = HomeViewModel.shared
    
    var body : some View{
        HStack {
            Text("Chức năng")
                .bold()
                .font(.system(size: 20))
                .foregroundColor(.foreground)
            
            Spacer()
            
            Button(action: {}) {
                HStack {
                    Text("Xem tất cả")
                        .foregroundColor(.accent)
                    
                    FontIcon.button(.ionicon(code: .ios_arrow_forward), action: {}, fontsize: 20)
                        .foregroundColor(.accent)
                }
            }
        }
        
        VStack{
            HStack(alignment: .top){
                
                Button(action: {
                    
                }) {
                    VStack(spacing: 8){
                        FontIcon.button(.ionicon(code: .md_qr_scanner), action: {
                            homeVM.selectTab = 1
                        },fontsize: 30)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color.accent)
                            .clipShape(.circle)
                        
                        Text("Quét QR")
                            .frame(width: 55)
                            .font(.caption2)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                    }
                }
                
                Spacer(minLength: 15)
                
                Button(action: {
                    
                }) {
                    VStack(spacing: 8){
                        FontIcon.button(.ionicon(code: .md_stats), action: {
                            homeVM.selectTab = 3
                        },fontsize: 30)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color.accent)
                            .clipShape(.circle)

                        Text("Lịch sử")
                            .frame(width: 55)
                            .font(.caption2)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                    }
                }
                
                Spacer(minLength: 15)
                
                Button(action: {
                    
                }) {
                    VStack(spacing: 8){
                        FontIcon.button(.ionicon(code: .ios_more), action: {},fontsize: 30)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color.accent)
                            .clipShape(.circle)
                        
                        Text("Thống kê")
                            .frame(width: 55)
                            .font(.caption)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                    }
                }
                
                Spacer(minLength: 15)
                
                Button(action: {
                    
                }) {
                    
                    VStack(spacing: 8){
                        FontIcon.button(.ionicon(code: .ios_more), action: {},fontsize: 30)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color.accent)
                            .clipShape(.circle)
                        
                        Text("Service")
                            .frame(width: 55)
                            .font(.caption)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            
            Divider()
            
            HStack{
                Text("Tuỳ chỉnh")
                    .font(.subheadline)
                    .foregroundColor(.accent)
                    
                
                FontIcon.button(.ionicon(code: .md_options), action: {},fontsize: 18)
                    .padding(0)
                    .foregroundColor(.accent)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 8)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )
        .padding(.top, 0)
    }
}


#Preview {
    MerchantServices()
}
