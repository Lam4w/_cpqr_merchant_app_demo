//
//  LoginView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var loginVM = MainViewModel.shared
    
    var body: some View {
        GeometryReader{ _ in
            VStack {
                Color(.white)
                VStack{
                    HStack{
                        Button{
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image("close")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 5)
                
                VStack{
                    Text("Đăng nhập")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                        .padding(.bottom, 5)
                    
                    Text("Vui lòng điền đầy đủ thông tin")
                        .font(.title3)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.black)
                    
                    InputField(title: "MerchantID", placeHolder: "Nhập tên tài khoản", txt: $loginVM.txtId)
                    
                    InputField(title: "MerchantID", placeHolder: "Nhập mật khẩu", txt: $loginVM.txtId)
                    
                    NavigationLink{
                        
                    } label: {
                        Text("Quên mật khẩu?")
                            .foregroundColor(.black.opacity(0.6))
                            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .trailing)
                            .padding(.top, 5)
                            .underline()
                    }
                    
                    Spacer()
                        .frame(height: 320)
                    
                    RoundedButton(title: "Đăng nhập") {
                        loginVM.logIn()
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    NavigationLink {
                        
                    } label: {
                        HStack{
                            //add font size
                            Text("Chưa đăng ký?")
                                .foregroundColor(.black.opacity(0.7))
                            
                            //add font size
                            Text("Đăng ký ngay")
                                .foregroundColor(.black)
                                .underline()
                        }
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.top, .topInsets + 20)
        .padding(.bottom, .bottomInsets)
        .padding(.horizontal, 20)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationView {
        LoginView()
    }
}
