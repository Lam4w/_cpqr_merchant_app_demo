//
//  CardType.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 11/09/2024.
//

import SwiftUI

enum CardType{
    case visa
    case masterCard
    case napas
        
    var gradient : Gradient{
        switch self {
        case .visa:
            return Gradient(colors: [Color(red: 0.08, green: 0.52, blue: 0.98), Color(red: 0.49, green: 0.15, blue: 0.93)])
        case .masterCard:
            return Gradient(colors: [Color(red: 0.00, green: 0.01, blue: 0.54), Color(red: 0.85, green: 0.21, blue: 0.30)])
        case .napas:
            return Gradient(colors: [Color(red: 29/255, green: 56/255, blue: 96/255), Color(red: 77/255, green: 148/255, blue: 255/255)])
        }
    }
    
    var imageName : String{
        switch self{
            case .visa:
                return "visa"
            case .masterCard:
                return "mastercard"
        case .napas:
                return "napas"
        }
    }
}
