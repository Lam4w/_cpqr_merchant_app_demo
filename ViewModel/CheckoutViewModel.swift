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
    var traceNo = ""
    var transDateTime = ""

    @Published var token: String = ""
    @Published var purchaseResponse: PurchaseResponse?
    @Published var isShowScanner: Bool = false
    @Published var isLoading: Bool = false
    @Published var showTransactionConfirmation: Bool = false
    @Published var showPaymentResult: Bool = false
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    init(){
        
    }
    
    func handleScanResult(result: String) {
        self.isShowScanner = false
        self.token = result
        self.showTransactionConfirmation = true
    }
    
    func serviceCallCreatePayment() {
        let card = CardInfo(token: self.token)
        guard let transAmount = Utils.reformatAmount(self.total) else {
            self.handleError(message: "Can not convert transaction amount")
            return
        }
        self.traceNo = Utils.generateRandomTraceNo()
        self.transDateTime = Utils.getTransmisDateTime()
        let payment = RequestPaymentInfo(
            proCode: "000000", 
            transAmount: transAmount, 
            transmisDateTime: self.transDateTime,
            systemTraceNo: self.traceNo,
            timeLocalTrans: Utils.getTimeLocalTrans(),
            dateLocalTrans: Utils.getDateLocalTrans(), 
            retrievalReferNo: "120010123456", 
            transCurrencyCode: "704", 
            serviceCode: "CPQR_PC"
        )
        let device = DeviceInfo(
            merchantType: "4412", 
            pointServiceEntryCode: "039", 
            pointServiceConCode: "00", 
            cardAcptTerminalCode: "06450645", 
            cardAcptIdenCode: "ABC 1234", 
            cardAcptNameLocation: "NAPAS Bank 7041111 HaNoiLyThuongKiet"
        )
                
        guard let pathJwePub = Bundle.main.path(forResource: "CER_JWE_NP", ofType: "pem") else {
            self.handleError(message: "Req - Can not get path of public key")
            return
        }
        
//        print("jwe cert path: \(pathJwePub)")
        
        guard let serverPubKey = try? KeyUtils.readPublicKey(from: pathJwePub) else {
            self.handleError(message: "Req - Can not read public key from cert")
            return
        }
        
//        print("key: \(String(describing: serverPubKey))")

        guard let cardJson = Utils.jsonString(from: card) else {
            self.handleError(message: "Req - Failed to encode card data to JSON")
            return
        }
        
//        print("Card json: \(cardJson)")

        guard let strJwe = KeyUtils.encryptJWE(originalData: cardJson, publicKey: serverPubKey) else {
            self.handleError(message: "Req - Failed to encrypt JWE")
            return
        }
        
//        print("string jwe: \(strJwe)")
        
        guard let pathJwsPri = Bundle.main.path(forResource: "PK_JWS_DEVICE", ofType: "key") else {
            self.handleError(message: "Req - Can not get path of private key JWS")
            return
        }
        
//        print("jws key path: \(pathJwsPri)")
        
        guard let devicePrikey = try? KeyUtils.readPrivateKey(from: pathJwsPri) else {
            self.handleError(message: "Req - Can not read private key from path JWS")
            return
        }
        
        guard let strJws = KeyUtils.signerJWS(strData: strJwe, privateKey: devicePrikey) else {
            self.handleError(message: "Req - Failed to sign JWS")
            return
        }
        
//        print("string jws: \(strJws)")
        
        guard let pathSigPri = Bundle.main.path(forResource: "PK_SIG_DEVICE", ofType: "key") else {
            self.handleError(message: "Req - Can not get path of private key Sig")
            return
        }
        
//        print("jws key path: \(pathJwsPri)")
        
        guard let devicePriSig = try? KeyUtils.readPrivateKey(from: pathSigPri) else {
            self.handleError(message: "Req - Can not read private key from path Sig")
            return
        }
        
        let requestPayload = PurchaseRequestPayload(card: strJws, payment: payment, device: device)
        
        let jsonPayload = "{\"card\":\"\(strJws)\",\"payment\":{\"pro_code\":\"000000\",\"trans_amount\":\"\(transAmount)\",\"transmis_date_time\":\"\(payment.transmisDateTime)\",\"system_trace_no\":\"\(payment.systemTraceNo)\",\"time_local_trans\":\"\(payment.timeLocalTrans)\",\"date_local_trans\":\"\(payment.dateLocalTrans)\",\"retrieval_refer_no\":\"\("120010123456")\",\"trans_currency_code\":\"704\",\"service_code\":\"CPQR_PC\"},\"device\":{\"merchant_type\":\"4412\",\"point_service_entry_code\":\"039\",\"point_service_con_code\":\"00\",\"card_acpt_terminal_code\":\"06450645\",\"card_acpt_iden_code\":\"ABC 1234\",\"card_acpt_name_location\":\"NAPAS Bank 7041111 HaNoiLyThuongKiet\"}}"
             
//        let jsonString = converToJson(arrayObject: array)
        
//        let jsonPayload = jsonCard + "," + jsonString.dropFirst()
//             
//        guard let payloadJson = Utils.jsonString(from: requestPayload) else {
//            self.handleError(message: "Req - Failed to encode payload data to JSON")
//            return
//        }
        
        print("Request JSON: \(jsonPayload)")
        
        guard let strSignatureDevice = try? KeyUtils.genSignature(plainText: jsonPayload, privateKey: devicePriSig) else {
            self.handleError(message: "Req - Can not generate signature")
            return
        }
        
        print("string signature: \(strSignatureDevice)")
        
        let body = PurchaseRequest(payload: PurchaseRequestPayload(card: strJws, payment: payment, device: device), signature: strSignatureDevice)
      
        self.isLoading = true
        
        ServiceCall.post(parameter: body, path: Path.PURCHASE) { responseObj in
            self.handleServicePurchaseResponse(responseObj)
        } failure: { error in
            self.isLoading = false
            print("Service call purchase failed with error: \(String(describing: error))")
            self.handleError(message: "Server error")
        }
    }
             
    func converToJson(arrayObject: [String: Any]) -> String {
         do {
             let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
             if let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                 return jsonString as String
             }
         }
         catch let error as NSError {
             print(error.localizedDescription)
         }
         return ""
     }
    
    func handleError(message: String) {
        print(message)
        self.showError = true
        self.errorMessage = message
    }

    func handleServicePurchaseResponse(_ responseObj: Data?) {
        guard let responseData = responseObj else {
            handleError(message: "Empty response data")
            return
        }

        do {
            self.purchaseResponse = try decodeResponse(from: responseData)
        } catch {
            self.isLoading = false
            self.handleError(message: "Decoding error: \(error)")
            return
        }
        
        guard let pathSigPub = Bundle.main.path(forResource: "CER_SIG_NP", ofType: "pem") else {
            self.isLoading = false
            self.handleError(message: "Res - Can not get path of public key Sig")
            return
        }
        
        guard let serverPubKey = try? KeyUtils.readPublicKey(from: pathSigPub) else {
            self.isLoading = false
            self.handleError(message: "Res - Can not read public key from cert Sig")
            return
        }
        
        guard ((self.purchaseResponse?.signature) != nil) else {
            self.isLoading = false
            self.handleError(message: "Res - Can not generate signature")
            return
        }
        
        guard let payloadJson = Utils.jsonString(from: self.purchaseResponse?.payload) else {
            self.isLoading = false
            self.handleError(message: "Res - Failed to encode payload data to JSON")
            return
        }
        
//        guard KeyUtils.verifySignature(plainText: payloadJson, signature: self.purchaseResponse!.signature, publicKey: serverPubKey) else {
//            self.isLoading = false
//            self.handleError(message: "Res - Verify signature failed")
//            return
//        }
        
        if let result = self.purchaseResponse?.payload.result {
            print("Result code: \(result.code)")
            print("Message: \(result.message)")
            
            if result.code == "105" {
                self.createReversal(attemp: 1)
            }
            
            self.showPaymentResult = true
        }
        
        self.isLoading = false
    }
    
    func createReversal(attemp: Int) {
        print("attemp: \(attemp)")
        let card = CardInfo(token: self.token)
        guard let transAmount = Utils.reformatAmount(self.total) else {
            self.handleError(message: "Can not convert transaction amount")
            return
        }
        let payment = RequestPaymentInfo(
            proCode: "000000",
            transAmount: transAmount,
            transmisDateTime: Utils.getTransmisDateTime(),
            systemTraceNo: Utils.generateRandomTraceNo(),
            timeLocalTrans: Utils.getTimeLocalTrans(),
            dateLocalTrans: Utils.getDateLocalTrans(),
            retrievalReferNo: "120010123456",
            transCurrencyCode: "704",
            serviceCode: "CPQR_PC"
        )
        let device = DeviceInfo(
            merchantType: "4412",
            pointServiceEntryCode: "039",
            pointServiceConCode: "00",
            cardAcptTerminalCode: "06450645",
            cardAcptIdenCode: "ABC 1234",
            cardAcptNameLocation: "NAPAS Bank 7041111 HaNoiLyThuongKiet"
        )
        let originalData = "0200\(self.traceNo)\(self.transDateTime)9704120000000000000000"
        let original = OriginalInfo(
            originalData: originalData,
            count: attemp
        )
        
        guard let pathJwePub = Bundle.main.path(forResource: "CER_JWE_NP", ofType: "pem") else {
            self.handleError(message: "Req - Can not get path of public key")
            return
        }
        
        //        print("jwe cert path: \(pathJwePub)")
        
        guard let serverPubKey = try? KeyUtils.readPublicKey(from: pathJwePub) else {
            self.handleError(message: "Req - Can not read public key from cert")
            return
        }
        
        //        print("key: \(String(describing: serverPubKey))")
        
        guard let cardJson = Utils.jsonString(from: card) else {
            self.handleError(message: "Req - Failed to encode card data to JSON")
            return
        }
        
        //        print("Card json: \(cardJson)")
        
        guard let strJwe = KeyUtils.encryptJWE(originalData: cardJson, publicKey: serverPubKey) else {
            self.handleError(message: "Req - Failed to encrypt JWE")
            return
        }
        
        //        print("string jwe: \(strJwe)")
        
        guard let pathJwsPri = Bundle.main.path(forResource: "PK_JWS_DEVICE", ofType: "key") else {
            self.handleError(message: "Req - Can not get path of private key JWS")
            return
        }
        
        //        print("jws key path: \(pathJwsPri)")
        
        guard let devicePrikey = try? KeyUtils.readPrivateKey(from: pathJwsPri) else {
            self.handleError(message: "Req - Can not read private key from path JWS")
            return
        }
        
        guard let strJws = KeyUtils.signerJWS(strData: strJwe, privateKey: devicePrikey) else {
            self.handleError(message: "Req - Failed to sign JWS")
            return
        }
        
        //        print("string jws: \(strJws)")
        
        guard let pathSigPri = Bundle.main.path(forResource: "PK_SIG_DEVICE", ofType: "key") else {
            self.handleError(message: "Req - Can not get path of private key Sig")
            return
        }
        
        //        print("jws key path: \(pathJwsPri)")
        
        guard let devicePriSig = try? KeyUtils.readPrivateKey(from: pathSigPri) else {
            self.handleError(message: "Req - Can not read private key from path Sig")
            return
        }
        
        let requestPayload = ReversalRequestPayload(card: strJws, payment: payment, device: device, original: original)
        
        let jsonPayload = "{\"card\":\"\(strJws)\",\"payment\":{\"pro_code\":\"000000\",\"trans_amount\":\"\(transAmount)\",\"transmis_date_time\":\"\(payment.transmisDateTime)\",\"system_trace_no\":\"\(payment.systemTraceNo)\",\"time_local_trans\":\"\(payment.timeLocalTrans)\",\"date_local_trans\":\"\(payment.dateLocalTrans)\",\"retrieval_refer_no\":\"\("120010123456")\",\"trans_currency_code\":\"704\",\"service_code\":\"CPQR_PC\"},\"device\":{\"merchant_type\":\"4412\",\"point_service_entry_code\":\"039\",\"point_service_con_code\":\"00\",\"card_acpt_terminal_code\":\"06450645\",\"card_acpt_iden_code\":\"ABC 1234\",\"card_acpt_name_location\":\"NAPAS Bank 7041111 HaNoiLyThuongKiet\"},\"original\":{\"original_data\":\"\(originalData)\",\"count\":\(attemp)}}"
        
        //        let jsonString = converToJson(arrayObject: array)
        
        //        let jsonPayload = jsonCard + "," + jsonString.dropFirst()
        //
        //        guard let payloadJson = Utils.jsonString(from: requestPayload) else {
        //            self.handleError(message: "Req - Failed to encode payload data to JSON")
        //            return
        //        }
        
        print("Request JSON: \(jsonPayload)")
        
        guard let strSignatureDevice = try? KeyUtils.genSignature(plainText: jsonPayload, privateKey: devicePriSig) else {
            self.handleError(message: "Req - Can not generate signature")
            return
        }
        
        print("string signature: \(strSignatureDevice)")
        
        let body = ReversalRequest(payload: ReversalRequestPayload(card: strJws, payment: payment, device: device, original: original), signature: strSignatureDevice)
        
        ServiceCall.post(parameter: body, path: Path.REVERSAL) { responseObj in
            self.handleServiceReversalResponse(responseObj, attemp: attemp)
        } failure: { error in
//            print("Service call reversal failed with error: \(String(describing: error))")
            self.handleError(message: "Network error attemp \(attemp)")
            if attemp + 1 < 4 {
                self.createReversal(attemp: attemp + 1)
            }
        }
    }

    func handleServiceReversalResponse(_ responseObj: Data?, attemp: Int) {
        guard let responseData = responseObj else {
            handleError(message: "Empty response data")
            return
        }
        
        let decoder = JSONDecoder()
        var reversalResponse: ReversalResponse?
        do {
            reversalResponse = try decodeReversalResoonse(from: responseData)
        } catch {
            self.isLoading = false
            self.handleError(message: "Decoding error: \(error)")
            return
        }
        
        guard let pathSigPub = Bundle.main.path(forResource: "CER_SIG_NP", ofType: "pem") else {
            self.isLoading = false
            self.handleError(message: "Res - Can not get path of public key Sig")
            return
        }
        
        guard let serverPubKey = try? KeyUtils.readPublicKey(from: pathSigPub) else {
            self.isLoading = false
            self.handleError(message: "Res - Can not read public key from cert Sig")
            return
        }
        
        guard ((reversalResponse?.signature) != nil) else {
            self.isLoading = false
            self.handleError(message: "Res - Can not generate signature")
            return
        }
        
        guard let payloadJson = Utils.jsonString(from: reversalResponse?.payload) else {
            self.isLoading = false
            self.handleError(message: "Res - Failed to encode payload data to JSON")
            return
        }
        
//        guard KeyUtils.verifySignature(plainText: payloadJson, signature: self.purchaseResponse!.signature, publicKey: serverPubKey) else {
//            self.isLoading = false
//            self.handleError(message: "Res - Verify signature failed")
//            return
//        }
        
        if let result = reversalResponse?.payload.result {
            print("Result code: \(result.code)")
            print("Message: \(result.message)")
            
            if result.code == "00" {
                print("reversal success")
                return
            } else {
                if attemp + 1 < 4 {
                    self.createReversal(attemp: attemp + 1)
                }
            }
        }
    }
    
    func decodeReversalResoonse(from data: Data) throws -> ReversalResponse {
        let decoder = JSONDecoder()
        return try decoder.decode(ReversalResponse.self, from: data)
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
