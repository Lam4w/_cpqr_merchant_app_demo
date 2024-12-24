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
    
    private enum Field: Int {
        case textIdEdit
        case textPasswordEdit
    }
    
    @FocusState private var focusField: Field?
    
    var body: some View {
        GeometryReader { _ in
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
                    
                    Text("Tài khoản")
                        .foregroundColor(.white)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment:  .leading)
                    
                    TextField("Nhập tên tài khoản", text: $loginVM.txtId)
                        .keyboardType(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
                        .disableAutocorrection(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .frame(height: 40)
                        .font(.title3)
                        .focused($focusField, equals: .textIdEdit)
                    
                    Text("Mật khẩu")
                        .foregroundColor(.white)
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment:  .leading)
                    
                    TextField("Nhập mật khẩu", text: $loginVM.txtPassword)
                        .keyboardType(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
                        .disableAutocorrection(true)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .frame(height: 40)
                        .font(.title3)
                        .focused($focusField, equals: .textPasswordEdit)
                    
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
        .onTapGesture {
            if (focusField != nil) {
                focusField = nil
            }
        } 
    }
}

#Preview {
    NavigationView {
        LoginView()
    }
}
