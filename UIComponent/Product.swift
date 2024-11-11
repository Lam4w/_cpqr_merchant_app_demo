//
//  Product.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

struct Product: View {
    @State var pObj: ProductModel = ProductModel(dict: [:])
    @State var width:Double = 180.0
    var didAddCart: (()->())?
    
    
    var body: some View {
        NavigationLink {

        } label: {
            VStack{
                Image("banana")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 80)
                
                Spacer()
                
                Text(pObj.name)
                    .font(.title2)
                    .foregroundColor(.black)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text("$/pcs, price")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                HStack{
                    Text("\(pObj.price, specifier: "%.2f" )vnd")
                        .font(.title3)
                        .foregroundColor(.black)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Button {
                        didAddCart?()
                    } label: {
                        Image("add_white")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                    }
                    .frame(width: 40, height: 40)
                    .background( Color.blue)
                    .cornerRadius(15)
                }
                
            }
            .padding(15)
            .frame(width: 180, height: 230)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
           )
        }
        
    }
}

struct Product_Previews: PreviewProvider {
    static var previews: some View {
        Product(pObj: ProductModel(dict: [
            "id": 1,
            "qty": 1,
            "name": "Banana",
            "unit_name": "pcs",
            "unit_value": "7",
            "price": 10.000,
        ])){}
        Product()
    }
}

//#Preview {
//    Product()
//}

