//
//  CartItem.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

struct CartItem: View {
    @State var cObj: CartItemModel = CartItemModel(dict: [:])
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                Image("banana")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                
            
                VStack(spacing: 4){
                    HStack {
                        Text(cObj.name)
                            .font(.title2)
                            .foregroundColor(.black)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button {
//                            CartViewModel.shared.removeItem(cObj: cObj)
                        } label: {
                            Image("close")
                                .resizable()
                                .frame(width: 18, height: 18)
                        }

                    }
                    .padding(.bottom, 10)

                    HStack{
                        Text("\(cObj.unitValue)\(cObj.unitName), price")
                            .font(.title3)
                            .foregroundColor(.black)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                        
                        
                        HStack{
                            Button {
                                //                            CartViewModel.shared.serviceCallUpdateQty(cObj: cObj, newQty: cObj.qty - 1)
                            } label: {
                                
                                Image( "subtack"  )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(5)
                            }
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                            
                            Text( "\(cObj.qty)" )
                                .font(.title)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .frame(width: 45, height: 45, alignment: .center)
                            
                            
                            Button {
                                //                            CartViewModel.shared.serviceCallUpdateQty(cObj: cObj, newQty: cObj.qty + 1)
                            } label: {
                                
                                Image("add_green")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(5)
                            }
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                            )
                        }
                    }
                }
            }
            Divider()
        }
    }
}

struct CartItem_Previews: PreviewProvider {
    static var previews: some View {
        CartItem(cObj: CartItemModel(dict: [
            "id": 5,
            "qty": 1,
            "name": "Organic Banana",
            "unit_name": "pcs",
            "unit_value": "7",
            "price": 2.99,
        ]))
        .padding(.horizontal, 20)
    }
}

