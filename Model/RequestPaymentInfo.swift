//
//  RequestPaymentInfo.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 11/11/2024.
//

import Foundation

struct RequestPaymentInfo: Codable {
    let proCode: String
    let transAmount: String
    let transmisDateTime: String
    let systemTraceNo: String
    let timeLocalTrans: String
    let dateLocalTrans: String
    let retrievalReferNo: String
    let transCurrencyCode: String
    let serviceCode: String
    
    enum CodingKeys: String, CodingKey {
        case proCode = "pro_code"
        case transAmount = "trans_amount"
        case transmisDateTime = "transmis_date_time"
        case systemTraceNo = "system_trace_no"
        case timeLocalTrans = "time_local_trans"
        case dateLocalTrans = "date_local_trans"
        case retrievalReferNo = "retrieval_refer_no"
        case transCurrencyCode = "trans_currency_code"
        case serviceCode = "service_code"
    }
}
