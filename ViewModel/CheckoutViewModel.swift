//
//  ScannerViewModel.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 08/08/2024.
//

import SwiftUI
import CodeScanner
import Foundation
import CryptoTokenKit

class CheckoutViewModel: ObservableObject {
    static var shared: CheckoutViewModel = CheckoutViewModel()
    var total: String = ""
    
    var mandatoryTags: [String] = [
        "85",
        "61",
        "63",
        "4F",
        "5A",
        "5F24",
        "9F25",
        "57",
        "9F19",
        "5F2A",
        "9F02",
        "9F36",
        "9F26",
        "82",
        "9F10",
        "9F37",
        "95",
        "9A",
        "9C",
        "9F1A",
        "9F34",
        "9F03"
    ]
    var chipData: String = ""
    
    @Published var transactions: [TransactionDetail] = []
    @Published var token: String = ""
    @Published var purchaseResponse: PurchaseResponse?
    @Published var isShowScanner: Bool = false
    @Published var isLoading: Bool = false
    @Published var showTransactionsDetail: Bool = false
    @Published var showTransactionConfirmation: Bool = false
    @Published var showPaymentResult: Bool = false
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    init(){
        
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        self.isShowScanner = false
        switch result {
        case .success(let result):
            let details = result.string
            
            // parsing result
            if details.rangeOf(r: Range(0...6)) != "hQVDUFY" {
                self.showError = true
                self.errorMessage = "Invalid QR"
            }
            
            if let hex = Converter.base64ToHex(str: details) {
//                self.transactions = []
//                self.parseTransactions(tlvString: hex)
//                self.checkMTags()
//                let decodedEMV = self.decode(hex)
//                self.createTransactions(from: decodedEMV)
//                self.showTransactionConfirmation = true
            } else {
                print("Invalid")
                self.showError = true
                self.errorMessage = "Invalid QR"
            }
            
            // Sending payment
            self.token = details
            
            self.serviceCallCreatePayment()
            
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
            self.showError = true
            self.errorMessage = error.localizedDescription
        }
    }
    
    func parseTransactions(tlvString: String, startIndex: Int = 0 ,startingLength: Int = 0) {
        // Tags can be either two or four character in legnth. theFirstTag is checking to see if the first two characters in the string can be read as a valid Tag
        let firstTag = tlvString.rangeOf(r: Range(startIndex...(startIndex + 1)))
        
        // If the first two characters can not make a tag - then the first four might be able too
        let secondTag = tlvString.rangeOf(r: Range(startIndex...(startIndex + 3)))
        
        /// Get tag
        var tagName: String = ""
        
        if Tag.getTagName(tag: firstTag) != "Unknown" {
            tagName = Tag.getTagName(tag: firstTag)
        } else {
            tagName = Tag.getTagName(tag: secondTag)
        }            
        
        var actualTag: String = ""
        if Tag.getTagName(tag: firstTag) != "Unknown" {
            actualTag = firstTag
        } else {
            actualTag = secondTag
        }
        
        if tagName != "Unknown" {
            
            /// Get length
            let lengthStart = actualTag.count + startingLength
            // The legnth start takes in account the amount of characters in the tag along with where the last value ended
            let lengthEnd = (actualTag.count + 1) + startingLength
            // The legnth end takes in account the amount of characters in the tag along with where the last value ended while also disreguarding the first character in the length
            let hexLength = tlvString.rangeOf(r: Range(lengthStart...lengthEnd))
            // The hex value of the Length
            let length = Converter.hexToInt(hex: hexLength)
            // Converted hex to Int for use in the following equations
            /// Get value
            let value = tlvString.rangeOf(r: Range((lengthStart)...(length * 2) + lengthEnd))
            // Length is doubled as there are two bytes in each character
            
            
            let formattedNumberString = value.dropFirst(2)
            
            if (actualTag == "85" || actualTag == "50" || actualTag == "5F20") {
                let stringValue = Converter.hexToString(hex: value)
                let td = TransactionDetail(tag: actualTag, tagDetail: tagName, value: stringValue!)
                self.transactions.append(td)
            } else {
                let td = TransactionDetail(tag: actualTag, tagDetail: tagName, value: String(formattedNumberString))
                self.transactions.append(td)
            }
            
            if (actualTag == "61" || actualTag == "62" || actualTag == "63") {
                parseTransactions(tlvString: String(formattedNumberString), startIndex: 0, startingLength: 0)
            }
            
            /// Manage recursion
            // Total count for this transaction, and where the next transaction starts
            let endOfTransaction = (length * 2 + (lengthEnd + 1))
            if endOfTransaction != tlvString.count {
                //
                parseTransactions(tlvString: tlvString, startIndex: endOfTransaction, startingLength: endOfTransaction)
            }
        }
    }
    
    func decode(_ inputTLV: String) -> [String: Any] {
        var result: [String: Any] = [:]
        if let records = TKBERTLVRecord.sequenceOfRecords(from: hexStringToData(inputTLV)) {
            for record in records {
                let hexTag = String(record.tag, radix: 16).uppercased()
                let value = decodeValue(record.value, tag: record.tag)
                result["\(hexTag)"] = value
            }
        }
        return result
    }
    
    private func decodeValue(_ data: Data, tag: UInt64) -> Any {
        // Check if the tag is constructed (first bit of first byte is set to 1)
        let isConstructed = (tag & 0x20) != 0
        
        if isConstructed, let nestedRecords = TKBERTLVRecord.sequenceOfRecords(from: data) {
            // Recursively decode constructed data
            var nestedResult: [String: Any] = [:]
            for nestedRecord in nestedRecords {
                let nestedTag = String(nestedRecord.tag, radix: 16).uppercased()
                nestedResult["\(nestedTag)"] = decodeValue(nestedRecord.value, tag: nestedRecord.tag)
                
            }
            return ["nestedData": nestedResult, "value": hexEncodedString(from: data)]
        } else {
            // If not constructed, return the hex string value
            return hexEncodedString(from: data)
        }
    }

    private func hexEncodedString(from data: Data) -> String {
        return data.map { String(format: "%02X", $0) }.joined()
    }

    private func hexStringToData(_ hexString: String) -> Data {
        let hexString = hexString.replacingOccurrences(of: " ", with: "")
        var data = Data(capacity: hexString.count / 2)
        
        var index = hexString.startIndex
        while index < hexString.endIndex {
            let nextIndex = hexString.index(index, offsetBy: 2)
            let byteString = hexString[index..<nextIndex]
            if var byte = UInt8(byteString, radix: 16) {
                data.append(&byte, count: 1)
            }
            index = nextIndex
        }
        
        return data
    }
    
    func createTransactions(from decodedData: [String: Any]) {
        // Recursive function to process the decoded data
        func processDecodedData(_ data: Any, parentTag: String = "") {
            if let nestedData = data as? [String: Any] {
                for (tag, value) in nestedData {
                    let constructedTags = ["61", "62"]
                    let isConstructedTag = constructedTags.contains(tag)
                    
                    if isConstructedTag {
                        // If the tag is constructed, process its nested data
                        if let nestedDict = value as? [String: Any] {
                            if let nestedValues = nestedDict["nestedData"] {
                                processDecodedData(nestedValues, parentTag: tag)
                            }
                            // Add the overall value of the constructed data
                            if let overallValue = nestedDict["value"] as? String {
                                let actualTag = Tag.getTagName(tag: tag)
                                transactions.append(TransactionDetail(tag: tag, tagDetail: actualTag, value: overallValue))
                            }
                        }
                    } else {
                        // Add the tag and its value if it's not constructed
                        if let stringValue = value as? String {
                            let actualTag = Tag.getTagName(tag: tag)
                            transactions.append(TransactionDetail(tag: tag, tagDetail: actualTag, value: stringValue))
                        }
                    }
                }
            }
        }

        // Start processing the decoded data from the top level
        processDecodedData(decodedData)
    }
    
    func checkMandatoryTags(in dictionary: [String: Any], mandatoryTags: [String]) -> [String: Bool] {
        var foundTags: Set<String> = []
        var missingTags: [String: Bool] = [:]
        
        // Helper function to recursively check tags
        func checkTags(_ dict: [String: Any]) {
            for (tag, value) in dict {
                // Check if the tag is in the list of mandatory tags
                if mandatoryTags.contains(tag) {
                    foundTags.insert(tag)
                }
                
                // Recursively check nested dictionaries
                if let nestedDict = value as? [String: Any] {
                    checkTags(nestedDict)
                }
            }
        }
        
        // Start checking tags in the main dictionary
        checkTags(dictionary)
        
        // Identify which mandatory tags are missing
        for tag in mandatoryTags {
            missingTags[tag] = foundTags.contains(tag)
        }
        
        return missingTags
    }
    
    func checkMTags() {
        var foundTags: Set<String> = []
        var missingTags: [String] = []
        
        for tx in transactions {
            if mandatoryTags.contains(tx.tag) {
                foundTags.insert(tx.tag)
            }
        }
        
        for tag in mandatoryTags {
            if (!foundTags.contains(tag)) {
                missingTags.append(tag)
            }
        }
        
        for tag in missingTags {
            transactions.append(TransactionDetail(tag: tag, tagDetail: Tag.getTagName(tag: tag), value: "Missing"))
        }
        
        print(missingTags)
    }
    
    
    func parserQR() {
        let mockQRData = "85054350563031615F9F0507060000000050004F07A0000007300006500E46696E616E6369657261204543499F250290685A0A6008339300000499068F5F2D0665737074656E57136008339300000499068D27036010000000000FC501865F24032703315F340100636F5F2A0207049F02060000000010009F360200019F260891560D9A2CD86888820218009F102001150000000000000000000000000000000000000000000000000000000000009F3704773FCB7A950500000000009A032403229C01029F1A0207049F34032400029F0306000000000000"

        self.parseTransactions(tlvString: mockQRData)
        self.checkMTags()
        for tx in self.transactions {
            print("tag name: \(tx.tag)")
            print("tag detail: \(tx.tagDetail)")
            print("tag value: \(tx.value)")
        }
    }
    
    func serviceCallCreatePayment() {
        let card = CardInfo(token: "123123123")
        let payment = RequestPaymentInfo(proCode: "000000", transAmount: "000000700000", transmisDateTime: Utils.getTransmisDateTime(), systemTraceNo: "111111", timeLocalTrans: Utils.getTimeLocalTrans(), dateLocalTrans: Utils.getDateLocalTrans(), retrievalReferNo: "120010123456", transCurrencyCode: "704", serviceCode: "CPQR_PC")
        let device = DeviceInfo(merchantType: "4412", acceptInstitutionCode: "9004401", pointServiceEntryCode: "00", pointServiceConCode: "06450645", cardAcptTerminalCode: "06450645", cardAcptIdenCode: "ABC 1234", cardAcptNameLocation: "NAPAS Bank 7041111 HaNoiLyThuongKiet")
                
        guard let pathJwePub = Bundle.main.path(forResource: "CER_JWE_NP", ofType: "pem") else {
            print("Error: Can not get path of public key.")
            self.showError = true
            self.errorMessage = "Public key error"
            return
        }
        
        print("jwe cart path: \(pathJwePub)")
        
        guard let serverPubKey = try? KeyUtils.readPublicKey(from: pathJwePub) else {
            print("Error: Can not read public key from cert")
            self.showError = true
            self.errorMessage = "Public key error"
            return
        }
        
        print("key: \(String(describing: serverPubKey))")

        guard let cardJson = Utils.jsonString(from: card) else {
            print("Error: Failed to encode card data to JSON.")
            self.showError = true
            self.errorMessage = "JSON encoding error"
            return
        }
        
        print("Card json: \(cardJson)")

        guard let strJwe = KeyUtils.encryptJWE(originalData: cardJson, publicKey: serverPubKey) else {
            print("Error: Failed to encrypt JWE.")
            self.showError = true
            self.errorMessage = "Encryption error"
            return
        }
        
        print("string jwe: \(strJwe)")
        
        guard let pathJwsPri = Bundle.main.path(forResource: "PK_JWS_DEVICE", ofType: "key") else {
            print("Error: Can not get path of private key.")
            self.showError = true
            self.errorMessage = "Private key error"
            return
        }
        
        print("jws key path: \(pathJwsPri)")
        
        guard let devicePrikey = try? KeyUtils.readPrivateKey(from: pathJwsPri) else {
            print("Error: Can not read private key from path")
            self.showError = true
            self.errorMessage = "Private key error"
            return
        }
        
        guard let strJws = KeyUtils.signerJWS(strData: strJwe, privateKey: devicePrikey) else {
            print("Error: Failed to encrypt JWE.")
            self.showError = true
            self.errorMessage = "Encryption error"
            return
        }
        
        print("string jws: \(strJws)")
        
        guard let pathSigPri = Bundle.main.path(forResource: "PK_SIG_DEVICE", ofType: "key") else {
            print("Error: Can not get path of private key.")
            self.showError = true
            self.errorMessage = "Private key error"
            return
        }
        
        print("jws key path: \(pathJwsPri)")
        
        guard let devicePriSig = try? KeyUtils.readPrivateKey(from: pathSigPri) else {
            print("Error: Can not read private key from path")
            self.showError = true
            self.errorMessage = "Private key error"
            return
        }
        
        let requestPayload = PurchaseRequestPayload(card: strJws, payment: payment, device: device)
        
        guard let payloadJson = Utils.jsonString(from: requestPayload) else {
            print("Error: Failed to encode payload data to JSON.")
            self.showError = true
            self.errorMessage = "JSON encoding error"
            return
        }
        
        guard let strSignatureDevice = try? KeyUtils.genSignature(plainText: payloadJson, privateKey: devicePriSig) else {
            print("Error: Can not generate signature")
            self.showError = true
            self.errorMessage = "Private key error"
            return
        }
        
        print("string signature: \(strSignatureDevice)")
        
        let body = PurchaseRequest(payload: PurchaseRequestPayload(card: strJws, payment: payment, device: device), signature: strSignatureDevice)
      
        self.isLoading = true
        
        ServiceCall.post(parameter: body, path: Path.PURCHASE) { responseObj in
            self.handleServiceResponse(responseObj)
        } failure: { error in
            self.isLoading = false
            print("Service call failed with error: \(String(describing: error))")
            self.errorMessage = "Network error"
            self.showError = true
        }
    }
    
    func handleError(message: String) {
        print(message)
        self.showError = true
        self.errorMessage = message
    }


    func handleServiceResponse(_ responseObj: Data?) {
        guard let responseData = responseObj else {
            handleError(message: "Empty response data")
            return
        }
        
        let decoder = JSONDecoder()
        do {
            self.purchaseResponse = try decodeResponse(from: responseData)
            if let result = self.purchaseResponse?.payload.result {
                print("Result code: \(result.code)")
                print("Message: \(result.message)")
                self.showPaymentResult = true
            }
        } catch {
            handleError(message: "Decoding error: \(error)")
        }
        
        self.isLoading = false
    }

    func decodeResponse(from data: Data) throws -> PurchaseResponse {
        let decoder = JSONDecoder()
        return try decoder.decode(PurchaseResponse.self, from: data)
    }
}

extension String {
    func rangeOf(r: Range<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: r.lowerBound)
        let end = self.index(self.startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }
}


