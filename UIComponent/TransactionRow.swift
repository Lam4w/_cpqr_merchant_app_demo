//
//  TransactionRow.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 09/08/2024.
//

import SwiftUI

struct TransactionRow: View {
    @State var txObj: TransactionDetail = TransactionDetail()

    var body: some View {
        VStack{
            Divider()
            HStack{
                HStack{
                    Text(txObj.tag)
                        .frame(minWidth: 50,maxWidth: 60)
                    Text(txObj.tagDetail)
                        .frame(minWidth: 50, maxWidth: 200)
//                    Divider()
                    
                }
                .frame(maxWidth: 150)
                
                HStack{
                    Text(txObj.value)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            Divider()
        }
    }
}

struct TransactionRow_Preview: PreviewProvider {
    static var previews: some View {
        TransactionRow(txObj: TransactionDetail(tag: "qqwe", tagDetail: "52", value: "qweqeqwe"))
        .padding(.horizontal, 20)
    }
}
