//
//  PurchaseDeviceInfo.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 11/11/2024.
//

import Foundation

struct DeviceInfo: Codable {
    let merchantType: String
    let acceptInstitutionCode: String
    let pointServiceEntryCode: String
    let pointServiceConCode: String
    let cardAcptTerminalCode: String
    let cardAcptIdenCode: String
    let cardAcptNameLocation: String
    
    enum CodingKeys: String, CodingKey {
        case merchantType = "merchant_type"
        case acceptInstitutionCode = "card_acpt_institution_code"
        case pointServiceEntryCode = "point_service_entry_code"
        case pointServiceConCode = "point_service_con_code"
        case cardAcptTerminalCode = "card_acpt_terminal_code"
        case cardAcptIdenCode = "card_acpt_iden_code"
        case cardAcptNameLocation = "card_acpt_name_location"
    }
}
