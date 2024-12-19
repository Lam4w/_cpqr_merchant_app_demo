//
//  ClientHomeView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 18/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct ClientHomeView: View {
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
                                .background(Color(.white))
                                .clipShape(.circle)
        
                            FontIcon.button(.ionicon(code: .md_list), action: {},fontsize: 30)
                                .padding(12)
                                .background(Color(.white))
                                .clipShape(.circle)
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
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color(hex: "ECEDF3"), lineWidth: 2)
                        )
                    }
                
                }
            }
            
        }
        .ignoresSafeArea()
        .padding(.bottom, .bottomInsets + 60)
        .disableBounces()
    }
}

#Preview {
    ClientHomeView()
}
