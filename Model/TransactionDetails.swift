//
//  TransactionDetails.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 25/12/24.
//

import Foundation

struct TransactionDetails: Identifiable {
    var id: UUID
    var amount: String = ""
    var traceNo: String = ""
    var transDate: String = ""
    var status: String = ""
    
    init(amount: String, traceNo: String, transDate: String, status: String) {
        self.id = UUID()
        self.amount = amount
        self.traceNo = traceNo
        self.transDate = transDate
        self.status = status
    }
    
    init() {
        self.id = UUID()
    }
}
