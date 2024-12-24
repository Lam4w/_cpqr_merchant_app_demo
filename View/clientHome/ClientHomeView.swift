//
//  ClientHomeView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 18/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct ClientHomeView: View {
    @StateObject var loginVM = MainViewModel.shared
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ZStack(alignment: .top) {
                        Image("clientBG1")
                            .resizable()
//                            .scaledToFit()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: .screenWidth, height: 180)
                        
                        HStack {
                            HStack {
                                FontIcon.button(.ionicon(code: .md_person), action: {},fontsize: 30)
                                    .padding(12)
                                    .background(Color(.white))
                                    .clipShape(.circle)
                                    .foregroundColor(.black.opacity(0.7))
                                
                                VStack {
                                    HStack {
                                        Text("Xin chào,")
                                            .font(.subheadline)
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        Text("Nguyen Tung Lam")
                                            .bold()
                                        Spacer()
                                    }
                                }
                            }
                            
                            Spacer()
                            
                            FontIcon.button(.ionicon(code: .md_notifications), action: {},fontsize: 30)
                                .padding(12)
                                .background(Color.white)
                                .clipShape(.circle)
                            
                            FontIcon.button(.ionicon(code: .md_log_out), action: {
                                loginVM.logOut()
                            },fontsize: 30)
                                .padding(12)
                                .background(Color.white)
                                .clipShape(.circle)
                                .foregroundColor(.black)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 50)
                        
                        VStack {
                            VStack(alignment: .leading, spacing: 20) {
                                
                                ClientCards()
                                
                                ClientServices()
                                
                                ClientTransactionList()
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 130)
                            .background(Color.white)
                        }
                        .padding(.top, 200)
                        
                        VStack {
                            ClientOverview()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: .foreground.opacity(0.3), radius: 15, x: 0, y: 0)
                        .padding(.top, 140)
                        .padding(.horizontal, 20)
//                        6
                    }
                
                }
            }
            
        }
        .ignoresSafeArea()
        .padding(.bottom, .bottomInsets + 80)
        .disableBounces()
    }
}

#Preview {
    ClientHomeView()
}
