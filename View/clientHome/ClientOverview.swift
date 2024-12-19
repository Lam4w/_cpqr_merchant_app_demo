//
//  ClientOverview.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 18/12/24.
//

import SwiftUI

struct ClientOverview: View {
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text("Số dư")
                            .font(.title3)
                        
                        Spacer()
                        
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
                    }
                    
                    HStack {
                        HStack{
                            Text("250.000")
                                .font(.title2)
                                .bold()
                            Text("vnd")
                                .font(.title3)
                        }
                        
                        Spacer()
                        
//                        Button(action: {
//                            
//                        }) {
//                            
//                            Image(systemName: "eye")
//                                .font(.system(size: 15))
//                                .padding(10)
//                                .background(.ultraThinMaterial)
//                                .clipShape(.circle)
//                                .foregroundColor(Color(hex: "6b6b6b"))
//                        }
//                        .padding(0)
                    }
                }
            }
            
            Divider()
            
            HStack {
                Button(action: {
                    
                }) {
                    HStack {
                        Image(systemName: "qrcode")
                        
                        Text("Tạo mã QR")
                            .font(.subheadline)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(Color.accent)
                .cornerRadius(10)
                .foregroundColor(.white)
                
                Spacer()
                
                HStack {
                    Image(systemName: "arrow.left.arrow.right")
                    
                    Text("Chuyển tiền")
                        .font(.subheadline)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(Color.mutedBackground)
                .foregroundColor(.secondary)
                .cornerRadius(10)
                
                Spacer()
                
                Image(systemName: "square.grid.2x2")
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(.circle)
            }
        }
    }
}

#Preview {
    ClientOverview()
}
