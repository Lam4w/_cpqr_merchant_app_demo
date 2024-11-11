//
//  CartViewModel.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

class CartViewModel: ObservableObject
{
    static var shared: CartViewModel = CartViewModel()

    // @Published var showError = false
    // @Published var showOrderAccept = false
    // @Published var errorMessage = ""
    
    @Published var listArr: [CartItemModel] = []
    @Published var total: String = "10000"
    
    @Published var showCheckout: Bool = false
    
    init() {
        getCartItemList()
    }
    
    func getCartItemList(){
//            if let response = responseObj as? NSDictionary {
//                if response.value(forKey: KKey.status) as? String ?? "" == "1" {
//                  
//                    self.listArr = (response.value(forKey: KKey.payload) as? NSArray ?? []).map({ obj in
//                        return CartItemModel(dict: obj as? NSDictionary ?? [:])
//                    })
        let res = [
            [
                "prod_id": 1,
                "order_id": 1,
                "qty": 1,
                "name": "Organic Banana",
                "unit_name": "pcs",
                "unit_value": "7",
                "price": 10.000,
                "item_price": 2.49,
                "total_price": 2.49
            ],
            [
                "prod_id": 2,
                "order_id": 2,
                "qty": 1,
                "name": "Organic Banana",
                "unit_name": "pcs",
                "unit_value": "7",
                "price": 10.000,
                "item_price": 2.49,
                "total_price": 2.49
            ],
            [
                "prod_id": 3,
                "order_id": 3,
                "qty": 1,
                "name": "Organic Banana",
                "unit_name": "pcs",
                "unit_value": "7",
                "price": 10.000,
                "item_price": 2.49,
                "total_price": 2.49
            ],
            [
                "prod_id": 4,
                "order_id": 4,
                "qty": 1,
                "name": "Organic Banana",
                "unit_name": "pcs",
                "unit_value": "7",
                "price": 10.000,
                "item_price": 2.49,
                "total_price": 2.49
            ]
        ]
        
        self.listArr = res.map({ obj in
            return CartItemModel(dict: obj as NSDictionary)
        })
    }

    func updateQty(cObj: CartItemModel, newQty: Int){
      
    }
    
    func removeItem(cObj: CartItemModel) {

    }
    
    func serviceCallOrderPlace(){
        
    }

    class func addItemToCart(product: ProductModel, qty: Int) {
        
    }
}
