//
//  TransactionDetail.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 08/08/2024.
//

import SwiftUI

struct TransactionDetail: Identifiable {
    var id: UUID
    var tag: String = ""
    var tagDetail: String = ""
    var value: String = ""
    
    init(tag: String, tagDetail: String, value: String) {
        self.id = UUID()
        self.tag = tag
        self.tagDetail = tagDetail
        self.value = value
    }
    
    init() {
        self.id = UUID()
    }
}
