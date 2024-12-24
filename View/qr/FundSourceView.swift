//
//  FundSourceView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 24/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct FundSourceView: View {
    var isSelected: Bool
    
    var body: some View {
        HStack {
            HStack {
                HStack {
                    Image("napas")
                        .resizable()
                    //                                            .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 12)
                        .padding(.horizontal, 5)
                        .padding(.top, 3)
                }
                .padding(.vertical, 7)
                .padding(.horizontal, 5)
                .background(.white)
                .cornerRadius(5)
                
                VStack {
                    HStack {
                        Text("Thẻ")
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .font(.caption)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("970414 ... 9704")
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .font(.caption)
                        Spacer()
                    }
                }
                
                Spacer()
                
                if isSelected {
                    FontIcon.text(.ionicon(code: .md_checkmark_circle_outline), fontsize: 30)
                        .foregroundColor(Color.green)
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 17)
        }
        .background{
            if isSelected {
                Color.mutedBackground.opacity(0.6)
            }
        }
    }
}

#Preview {
    QRView()
}
