//
//  TransactionDetails.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 25/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionDetailsView: View {
    @Binding var isShowing: Bool
    @Binding var txDetails: TransactionDetails
    @State private var currHeight: CGFloat = 560
    
    var statusColor: Color {
        switch txDetails.status {
            case "Success": return Color(hex: "32A64D")
            case "Pending": return Color(hex: "E4AC04")
            case "Failed": return Color(hex: "EE4540")
            default: return Color.black
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.foreground
                    .opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                
                mainView
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeIn)
    }
    
    var mainView: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 50, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.0001))
            
            ZStack {
                VStack {
                    HStack {
                        Text("Thông tin giao dịch")
                    }
                    .font(.title)
//                    .padding(.horizontal, 20)
//                    .padding(.vertical, 17)
                    
                    // list of fund sources
                    
                    HStack {
                        Text("Số tiền ")
                        
                        Spacer()
                        
                        Text("\(txDetails.amount) đ")
                    }
                    .padding(.vertical, 10)
                    
                    Divider()
                    
//                    HStack {
//                        Text("ID")
//                        
//                        Spacer()
//                        
//                        Text("\(txDetails.id)")
//                    }
//                    
//                    Divider()
                    
                    HStack {
                        Text("Số trace")
                        
                        Spacer()
                        
                        Text(txDetails.traceNo)
                    }
                    .padding(.vertical, 10)
                    
                    Divider()
                    
                    HStack {
                        Text("Ngày giao dịch")
                        
                        Spacer()
                        
                        Text(txDetails.transDate)
                    }
                    .padding(.vertical, 10)
                    
                    Divider()
                    
                    HStack {
                        Text("Trạng thái")
                        
                        Spacer()
                        
                        Text(txDetails.status)
                            .foregroundColor(statusColor)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 50)
                    
                    if txDetails.status == "Success" {
                        RoundedButton(title: "Void") {

                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 15)
            }
            
            Spacer()
        }
        .frame(height: currHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: currHeight / 2)
            }
                .foregroundColor(.white)
        )
    }
}

#Preview {
    TransactionHistoryView()
}
