//
//  ProductModel.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI
import SwiftUI

struct ProductModel:  Identifiable, Equatable {
    var id: Int = 0
    var qty: Int = 0
    var name: String = ""
    var unitName: String = ""
    var unitValue: String = ""
    var price: Double = 0.0

    init(dict: NSDictionary) {
        self.id = dict.value(forKey: "id") as? Int ?? 0
        self.qty = dict.value(forKey: "qty") as? Int ?? 0
        self.name = dict.value(forKey: "name") as? String ?? ""
        self.unitName = dict.value(forKey: "unit_name") as? String ?? ""
        self.unitValue = dict.value(forKey: "unit_value") as? String ?? ""
        self.price = dict.value(forKey: "price") as? Double ?? 0.0
    }
    
    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        return lhs.id == rhs.id
    }
}
