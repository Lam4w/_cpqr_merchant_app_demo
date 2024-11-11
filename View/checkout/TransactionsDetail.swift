//
//  TransactionsDetail.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 09/08/2024.
//

import SwiftUI

struct TransactionsDetail: View {    
    @StateObject var scannerVM = CheckoutViewModel.shared
    
    var body: some View {
        ZStack{
            if(scannerVM.transactions.count == 0) {
                Text("No details")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            ScrollView{
                LazyVStack {
                    ForEach( scannerVM.transactions , id: \.id, content: {
                        txObj in
                        TransactionRow(txObj: txObj)
                    })
                }
                .padding(10)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets)
            }
            
            VStack {
//                HStack{
//                    Spacer()
//                    Text("Transactions Details ")
//                        .font(.title)
//                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                        .frame(height: 46)
//                    Spacer()
//                }
//                .padding(.top, .topInsets)
                
                
                VStack{
                    HStack{
                        HStack{
                            Text("Tag")
                                .frame(minWidth: 50,maxWidth: 60)
                            Text("Ý nghĩa")
                                .frame(minWidth: 50, maxWidth: 200)
                            
                        }
                        .frame(maxWidth: 150)
                        
                        HStack{
                            Text("Giá trị")
                                .multilineTextAlignment(.leading)
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    }
                    Divider()
                }
                .padding(.top, .topInsets + 20)
                .padding(.horizontal, 10)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                
                Spacer()
            }
        }
        .ignoresSafeArea()
        .alert(isPresented: $scannerVM.showError) {
            Alert(title: Text("Error"), message: Text(scannerVM.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    TransactionsDetail()
}
