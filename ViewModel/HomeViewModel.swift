//
//  HomeViewModel.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

class HomeViewModel: ObservableObject
{
    static var shared: HomeViewModel = HomeViewModel()
    
    @Published var selectTab: Int = 0
    @Published var txtSearch: String = ""
    
    @Published var productArr: [ProductModel] = []
    
    init() {
        getProductList()
    }
    
    //MARK: ServiceCall
    
    func getProductList(){
        //api fetching emulator
        let resPayload = [
            [
                "id": 1,
                "prod_id": 1,
                "order_id": 1,
                "qty": 1,
                "name": "Banana",
                "unit_name": "pcs",
                "unit_value": "7",
                "price": 10.000,
            ],
            [
                "id": 2,
                "prod_id": 2,
                "order_id": 2,
                "qty": 1,
                "name": "Banana",
                "unit_name": "pcs",
                "unit_value": "7",
                "price": 10.000,
            ],
            [
                "id": 3,
                "prod_id": 3,
                "order_id": 3,
                "qty": 1,
                "name": "Banana",
                "unit_name": "pcs",
                "unit_value": "7",
                "price": 10.000,
            ],
            [
                "id": 4,
                "prod_id": 4,
                "order_id": 4,
                "qty": 1,
                "name": "Banana",
                "unit_name": "pcs",
                "unit_value": "7",
                "price": 10.000,
            ],
            [
                "id": 5,
                "prod_id": 5,
                "order_id": 5,
                "qty": 1,
                "name": "Banana",
                "unit_name": "pcs",
                "unit_value": "7",
                "price": 10.000,
            ],
            [
                "id": 6,
                "prod_id": 6,
                "order_id": 6,
                "qty": 1,
                "name": "Banana",
                "unit_name": "pcs",
                "unit_value": "7",
                "price": 10.000,
            ],
        ]

          self.productArr = resPayload.map({ obj in
              return ProductModel(dict: obj as NSDictionary)
          })
    }
}
