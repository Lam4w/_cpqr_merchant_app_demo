//
//  ResponsePaymentInfo.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 11/11/2024.
//

import Foundation

struct ResponsePaymentInfo: Codable {
    let proCode: String
    let transAmount: String
    let settAmount: String
    let transmisDateTime: String
    let settConversionRate: String
    let systemTraceNo: String
    let timeLocalTrans: String
    let dateLocalTrans: String
    let dateSett: String
    let retrievalReferNo: String
    let authIdenRes: String
    let transCurrencyCode: String
    let serviceCode: String
    let transRefNumber: String
    
    enum CodingKeys: String, CodingKey {
        case proCode = "pro_code"
        case transAmount = "trans_amount"
        case settAmount = "sett_amount"
        case transmisDateTime = "transmis_date_time"
        case settConversionRate = "sett_conversion_rate"
        case systemTraceNo = "system_trace_no"
        case timeLocalTrans = "time_local_trans"
        case dateLocalTrans = "date_local_trans"
        case dateSett = "date_sett"
        case retrievalReferNo = "retrieval_refer_no"
        case authIdenRes = "auth_iden_res"
        case transCurrencyCode = "trans_currency_code"
        case serviceCode = "service_code"
        case transRefNumber = "trans_ref_number"
    }
}
