//
//  Tag.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 08/08/2024.
//

import Foundation

class Tag {
    class func getTagName(tag: String) -> String {
        let tagList: [String:String] = [
            "85": "POI",
            "61": "Application template",
            "63": "Application Specific Transparent Template",
            "62": "Common data template",
            "64": "Common data transparent template",
            //data objests in tag 61 (or 62)
            "4F": "Application ID",
            "50": "Application label",
            "5A": "Token/Application PAN",
            "5F24": "Token/Application Expiry date",
            "5F34": "Token/Application PSN",
            "9F05": "Appilcation discretionary data",
            "9F08": "Application version number",
            "5F20": "Card holder name",
            "5F50": "Issuer URL for customer notification",
            "9F25": "Last 4 digits of PAN",
            "5F2D": "Language preference",
            "57": "Track 2 equivalent data",
            "9F19": "Token requestor Id",
            "9F24": "Payment account reference",
            //tranparent data objects in tag 63 (or 64)
            "5F2A": "Transaction currency code",
            "9F02": "Amount, authorized",
            "9F36": "Application transaction counter",
            "9F26": "Application cryptogram (AC)",
            "82": "Application interchange profile",
            "9F10": "Issuer application data (IAD)",
            "9F37": "Unpredictable number (UN)",
            "9F27": "Cryptogram information data (CID)",
            "95": "Terminal verification result",
            "9A": "Transaction date",
            "9C": "Transaction type",
            "9F1A": "Terminal country code",
            "9F34": "CVM result",
            "9F03": "Other amount",
            "84": "Dedicated File (DF) Name"
        ]
        
        if let name = tagList[tag] {
            return name
        }
        
        return "Unknown"
        
//        return tagList[tag]
    }
}

