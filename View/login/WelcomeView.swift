//
//  WelcomeView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack{
            Color(.blue)
            
            VStack{
                Spacer()
                
                Text("Ứng dụng dành cho cửa hàng")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .font(.title2)
                    .padding(.bottom, 5)
                    .fontWeight(.bold)
                
                Text("Ứng dụng cung cấp đầy đủ nền tảng trải nghiệm thanh toán tốt nhất cho khách hàng")
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 15)
                
                NavigationLink{
                    LoginView()
                } label: {
                    Text("Đăng ký cửa hàng")
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(Color.black)
                .cornerRadius(20)
                
                Spacer()
                    .frame(height: 10)
                
                NavigationLink{
                    LoginView()
                } label: {
                    //add font size
                    Text("Đăng nhập")
                        .font(.title2)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                .background(Color.white)
                .cornerRadius(20)
                
                Spacer()
                    .frame(height: 50)
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationView{
        WelcomeView()
    }
}
