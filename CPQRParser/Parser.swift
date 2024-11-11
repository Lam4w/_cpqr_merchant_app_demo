////
////  Parser.swift
////  cpqr_merchant_demo
////
////  Created by Macbook on 08/08/2024.
////
//
//import Foundation
//
//class Parser {
//    static let sharedInstance = Parser()
//    
//    var transactions = [TransactionDetail]()
//    
//    func parseTransactions(tlvString: String, startIndex: Int = 0 ,startingLength: Int = 0) {
//
//        let firstTag = tlvString.rangeOf(r: Range(startIndex...(startIndex + 1)))
//        let secondTag = tlvString.rangeOf(r: Range(startIndex...(startIndex + 3)))
//        
//        //get tag name from either first tag or second tag
//        let tagName = Tag.getTagName(tag: firstTag) ?? Tag.getTagName(tag: secondTag)
//        let actualTag = Tag.getTagName(tag: firstTag) != nil ? firstTag : secondTag
//        
//        if tagName != nil {
//            //the legnth start takes in account the amount of characters in the tag along with where the last value ended
//            let lengthStart = actualTag.count + startingLength
//
//            // The legnth end takes in account the amount of characters in the tag along with where the last value ended while also disreguarding the first character in the length/
//            let lengthEnd = (actualTag.count + 1) + startingLength
//            
//            //get the hex value of the length
//            let hexLength = tlvString.rangeOf(r: Range(lengthStart...lengthEnd))
//
//            //convert hex to int for use in equatations
//            let length = Converter.hexToInt(hex: hexLength)
//
//            //get value
//            //length is doubled as there are 2 bytes in each char
//            let value = tlvString.rangeOf(r: Range((lengthStart)...(length * 2) + lengthEnd))
//
//            //convert the hex value into a string if possible
//            let stringValue = Converter.hexToString(hex: value)
//
//            //convert the hex value into a Int if possible
//            let intValue = Converter.hexToInt(hex: value)
//            
////            print("tag: \(actualTag)")
////            print("value: \(value)")
////            print("int value: \(intValue)")
////            print("string value: \(stringValue ?? "nil")")
//
//            if intValue == 0 && stringValue == nil {
////                print(actualTag)
//                //if the int value is 0 and the string value is nil -  take the value
//                let td = TransactionDetail(tag: tagName!, tagDetail:actualTag, value: value)
//                transactions.append(td)
//            } else if intValue == 0 && stringValue != nil {
//                //if the int value can be converted into a 0 and the stringValue can be created - we want the string
//                let td = TransactionDetail(tag: tagName!, tagDetail:actualTag, value: stringValue!)
//                transactions.append(td)
//            } else {
//                //IntValue case left, convert back to hex string
//                let numberString = String(intValue, radix: 16)
//                let formattedNumberString = numberString.dropFirst(1)
//                
//                let td = TransactionDetail(tag: tagName!, tagDetail:actualTag, value:formattedNumberString.uppercased())
//                transactions.append(td)
//            }
//            
//            //total count for this transaction, and where the next transaction starts
//            let endOfTransaction = (length * 2 + (lengthEnd + 1))
//            
//            if actualTag == "61" {
//                //recursion tag 61
//                parseTransactions(tlvString: value.rangeOf(r: Range(2...(value.count - 1))))
//            }
//            
//            if actualTag == "63" {
//                //recursion tag 63
//                parseTransactions(tlvString: value.rangeOf(r: Range(2...(value.count - 1))))
//            }
//            
//            if endOfTransaction != tlvString.count {
//                //recursion
//                parseTransactions(tlvString: tlvString, startIndex: endOfTransaction, startingLength: endOfTransaction)
//            }
//        }
//    }
//}
//
////extension String {
////    func rangeOf(r: Range<Int>) -> String {
////        let start = self.index(self.startIndex, offsetBy: r.lowerBound)
////        let end = self.index(self.startIndex, offsetBy: r.upperBound)
////        return String(self[start ..< end])
////    }
////}
