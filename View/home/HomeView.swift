//
//  T.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 10/09/2024.
//

import SwiftUI
import SwiftUIFontIcon

struct HomeView : View {
    @StateObject var homeVM = HomeViewModel.shared
    
    var body : some View{
        VStack(spacing: 5){
            HStack {
                SearchTextField(placholder: "Tìm kiếm", txt: $homeVM.txtSearch)
                    .padding(.horizontal, 0)
                    .padding(.vertical, 5)
                Spacer()
                
                FontIcon.button(.ionicon(code: .md_notifications), action: {},fontsize: 25)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(.circle)
                
                FontIcon.button(.ionicon(code: .md_list), action: {},fontsize: 25)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(.circle)
            }
            .padding(.vertical, 0)
            
            ScrollView{
                CardView()
                
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
                
//                Row1().padding(.top, 5)
//                
//                Row2()
                
                Services()
                
                Spacer(minLength: 0)
            }
        }
        .padding(.top, .topInsets)
        .padding(.bottom, .bottomInsets + 80)
        .padding(.horizontal, 15)
        .ignoresSafeArea()
    }
}

struct Services : View {
    @StateObject var homeVM = HomeViewModel.shared
    
    var body : some View{
        
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
                            .background(.blue)
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
                        FontIcon.button(.awesome5Solid(code: .qrcode), action: {
                            homeVM.selectTab = 3
                        },fontsize: 30)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(.blue)
                            .clipShape(.circle)

                        Text("Tạo CPQR")
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
                        FontIcon.button(.ionicon(code: .md_card), action: {},fontsize: 30)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(.blue)
                            .clipShape(.circle)
                        
                        Text("Service")
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
                        FontIcon.button(.ionicon(code: .md_card), action: {},fontsize: 30)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(.blue)
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
                Text("Thêm")
                    .font(.subheadline)
                    .bold()
                
                FontIcon.button(.ionicon(code: .ios_arrow_down), action: {},fontsize: 25)
                    .padding(0)
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


struct Row1 : View {
    
    var body : some View{
        
        HStack(alignment: .top){
            
            Button(action: {
                
            }) {
                VStack(spacing: 8){
                    VStack{
                        FontIcon.button(.ionicon(code: .md_qr_scanner), action: {},fontsize: 35)
                            .padding(0)
                        
                    }.padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                    Text("TT CPQR")
                    .frame(width: 55)
                    .font(.caption)
                    .foregroundColor(Color.black.opacity(0.5))
                    .multilineTextAlignment(.center)
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                
            }) {
                VStack(spacing: 8){
                    VStack{
                        FontIcon.button(.ionicon(code: .md_card), action: {},fontsize: 35)
                            .padding(0)
                    }.padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                    Text("Service")
                    .frame(width: 55)
                    .font(.caption)
                        .foregroundColor(Color.black.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                
            }) {
                
                VStack(spacing: 8){
                    
                    VStack{
                        FontIcon.button(.ionicon(code: .md_card), action: {},fontsize: 35)
                            .padding(0)
                    }.padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                    Text("Service")
                    .frame(width: 55)
                    .font(.caption)
                    .foregroundColor(Color.black.opacity(0.5))
                    .multilineTextAlignment(.center)
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                
            }) {
                
                VStack(spacing: 8){
                    
                    VStack{
                        FontIcon.button(.ionicon(code: .md_card), action: {},fontsize: 35)
                            .padding(0)
                    }.padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                    Text("Service")
                    .frame(width: 55)
                    .font(.caption)
                    .foregroundColor(Color.black.opacity(0.5))
                    .multilineTextAlignment(.center)
                }
            }
        }
    }
}


struct Row2 : View {
    
    var body : some View{
        
        HStack(alignment: .top){
            
            Button(action: {
                
            }) {
                
                VStack(spacing: 8){
                    
                    VStack{
                        FontIcon.button(.ionicon(code: .md_card), action: {},fontsize: 35)
                            .padding(0)
                    }.padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                    Text("Service")
                    .frame(width: 55)
                    .font(.caption)
                    .foregroundColor(Color.black.opacity(0.5))
                    .multilineTextAlignment(.center)
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                
            }) {
                
                VStack(spacing: 8){
                    
                    VStack{
                        FontIcon.button(.ionicon(code: .md_card), action: {},fontsize: 35)
                            .padding(0)
                    }.padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                    Text("Service")
                    .frame(width: 55)
                    .font(.caption)
                        .foregroundColor(Color.black.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
                
            }) {
                
                VStack(spacing: 8){
                    
                    VStack{
                        FontIcon.button(.ionicon(code: .md_card), action: {},fontsize: 35)
                            .padding(0)
                    }.padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                    Text("Service")
                    .frame(width: 55)
                    .font(.caption)
                    .foregroundColor(Color.black.opacity(0.5))
                    .multilineTextAlignment(.center)
                }
            }
            
            Spacer(minLength: 15)
            
            Button(action: {
              
                
            }) {
                
                VStack(spacing: 8){
                    
                    VStack{
                        FontIcon.button(.ionicon(code: .md_card), action: {},fontsize: 35)
                            .padding(0)
                    }.padding()
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    
                    Text("Service")
                    .frame(width: 55)
                    .font(.caption)
                    .foregroundColor(Color.black.opacity(0.5))
                    .multilineTextAlignment(.center)
                }
            }
        }
    }
}

var names = ["Bill","Steve","Kavuya","Tim"]

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
        }
    }
}


