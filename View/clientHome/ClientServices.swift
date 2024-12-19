//
//  ClientServices.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 18/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct ClientServices: View {
    @StateObject var homeVM = HomeViewModel.shared
    
    var body : some View{
        HStack {
            Text("Chức năng ưa thích")
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
                        FontIcon.button(.ionicon(code: .md_swap), action: {
                            homeVM.selectTab = 1
                        },fontsize: 30)
                        .foregroundColor(.secondary)
                            .padding(15)
                            .background(Color.mutedBackground)
                            .clipShape(.circle)
                        
                        Text("Chuyển tiền")
                            .frame(width: 65)
                            .font(.caption2)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                    }
                }
                
                Spacer(minLength: 15)
                
                Button(action: {
                    
                }) {
                    VStack(spacing: 8){
                        FontIcon.button(.awesome5Solid(code: .qrcode), action: {
                            homeVM.selectTab = 1
                        },fontsize: 30)
                            .foregroundColor(.secondary)
                            .padding(15)
                            .background(Color.mutedBackground)
                            .clipShape(.circle)

                        Text("Mã QR")
                            .frame(width: 65)
                            .font(.caption2)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                    }
                }
                
                Spacer(minLength: 15)
                
                Button(action: {
                    
                }) {
                    
                    VStack(spacing: 8){
                        FontIcon.button(.ionicon(code: .md_card), action: {},fontsize: 30)
                            .foregroundColor(.secondary)
                            .padding(15)
                            .background(Color.mutedBackground)
                            .clipShape(.circle)
                        
                        Text("Thẻ")
                            .frame(width: 65)
                            .font(.caption)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                    }
                }
                
                Spacer(minLength: 15)
                
                Button(action: {
                    
                }) {
                    
                    VStack(spacing: 8){
                        FontIcon.button(.ionicon(code: .md_car), action: {},fontsize: 30)
                            .foregroundColor(.secondary)
                            .padding(15)
                            .background(Color.mutedBackground)
                            .clipShape(.circle)
                        
                        Text("Taxi")
                            .frame(width: 65)
                            .font(.caption)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .padding(.bottom, 10)
            
            Divider()
            
            HStack{
                Text("Tuỳ chỉnh")
                    .font(.subheadline)
                    .foregroundColor(.accent)
                    
                FontIcon.button(.ionicon(code: .md_options), action: {},fontsize: 18)
                    .padding(0)
                    .foregroundColor(.accent)
            }
            .padding(.vertical, 3)
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
    ClientServices()
}
