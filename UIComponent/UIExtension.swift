//
//  UIExtension.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

extension Color {
    static var primary: Color {
        return Color(hex: "b0ec70")
    }

    static var secondary: Color {
        return Color(hex: "154617")
    }
    
    static var accent: Color {
        return Color(hex: "006eb6")
    }
    
    static var mutedBackground: Color {
        return Color(hex: "f3fce7")
    }

    static var foreground: Color {
        return Color(hex: "6b6b6b")
    }

    static var txtPrimary: Color {
        return Color(hex: "eff6ff")
    }

    static var txtSecondary: Color {
        return Color(hex: "231323")
    }

    static var txtPlaceholder: Color {
        return Color(hex: "231323")
    }
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension CGFloat {
    static var screenWidth: Double {
        return UIScreen.main.bounds.size.width
    }
    
    static var screenHeight: Double {
        return UIScreen.main.bounds.size.height
    }
    
    static var topInsets: Double {
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.safeAreaInsets.top
        }
        
        return 0.0
    }
    
    static var bottomInsets: Double {
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.safeAreaInsets.bottom
        }
        
        return 0.0
    }
    
    static var horInsets: Double {
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.safeAreaInsets.left + keyWindow.safeAreaInsets.right
        }
        
        return 0.0
    }
}

extension View {
    func disableBounces() -> some View {
        modifier(DisableBouncesModifer())
    }
}

struct DisableBouncesModifer:ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear{
                UIScrollView.appearance().bounces = false
            }
            .onDisappear {
                UIScrollView.appearance().bounces = true
            }
    }
}
