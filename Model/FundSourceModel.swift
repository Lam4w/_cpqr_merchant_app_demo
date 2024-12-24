//
//  FundSourceModel.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 24/12/24.
//

import Foundation

struct FundSourceModel: Identifiable {
    var id: UUID
    var type: String = ""
    var image: String = ""
    var num: String = ""
    
    init(type: String, image: String, num: String) {
        self.id = UUID()
        self.type = type
        self.image = image
        self.num = num
    }
    
    init() {
        self.id = UUID()
    }
}
