//
//  CardModel.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 11/09/2024.
//

import Foundation

struct CardModel : Hashable{
    let crediCardType : CardType
    let bankName : String
    let cardNumber : String
    let cardHolderName : String
    let expirationDate: String
}
let sampleCards: [CardModel] = [
    CardModel(crediCardType: .napas, bankName: "Sample Bank", cardNumber: "1234 1234 1234 1234", cardHolderName: "NGUYEN TUNG LAM", expirationDate: "01/2026"),
    CardModel(crediCardType: .visa, bankName: "Sample Bank", cardNumber: "1234 1234 1234 1234", cardHolderName: "NGUYEN TUNG LAM", expirationDate: "01/2026"),
    CardModel(crediCardType: .masterCard, bankName: "Sample Bank", cardNumber: "5678 5678 5678 5678", cardHolderName: "NGUYEN TUNG LAM", expirationDate: "01/2026")
]
