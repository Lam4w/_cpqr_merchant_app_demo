//
//  FundSourceModel.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 24/12/24.
//

import Foundation

struct FundSource: Identifiable {
    var id: UUID
    var type: String = ""
    var image: String = ""
    var token: String = ""
    
    init(type: String, image: String, token: String) {
        self.id = UUID()
        self.type = type
        self.image = image
        self.token = token
    }
    
    init() {
        self.id = UUID()
    }
}
