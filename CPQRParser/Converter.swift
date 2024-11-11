//
//  Converter.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 08/08/2024.
//

import Foundation

class Converter {
    //create hex string from base64
    class func base64ToHex(str: String) -> String? {
        guard let data = Data(base64Encoded: str) else { return nil }
        
        let hexString = data.map{
            String(format: "%02X", $0)
        }.joined()
        
        return hexString
    }
    
    //create u16 int from hex string
    class func hexToInt(hex: String) -> Int {
        guard let num = Int(hex, radix: 16) else { return 0}
        return num
    }
    
    //create string from hex data
    class func hexToString(hex: String) -> String? {
        guard hex.count % 2 == 0 else {
            return nil
        }
        
        var bytes = [CChar]()
        
        var startIndex = hex.index(hex.startIndex, offsetBy: 2)
        while startIndex < hex.endIndex {
            let endIndex = hex.index(startIndex, offsetBy: 2)
            let substr = hex[startIndex..<endIndex]
            
            if let byte = Int8(substr, radix: 16) {
                bytes.append(byte)
            } else {
                return nil
            }
            
            startIndex = endIndex
        }
        
        bytes.append(0)
        return String(cString: bytes)
    }
}
