//
//  FundSourceView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 24/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct FundSourceView: View {
    @StateObject var qrVM = QRViewModel.shared
    @Binding var isShowing: Bool
    @State var fundSrc: FundSource = FundSource()
    
    var body: some View {
        Button {
            qrVM.curFundSource = fundSrc
            isShowing = false
        } label: {
            HStack {
                HStack {
                    HStack {
                        Image(fundSrc.image)
                            .resizable()
//                            .scaledToFit()
                            .aspectRatio(contentMode: .fill)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 5)
                    }
                    .frame(width: 35, height: 20)
                    .padding(.vertical, 7)
                    .padding(.horizontal, 5)
                    .background(.white)
                    .cornerRadius(5)
                    
                    VStack {
                        HStack {
                            Text(fundSrc.type)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .bold()
//                                .font(.caption)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text(fundSrc.token)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
//                                .font(.caption)
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    
                    if qrVM.curFundSource.token == fundSrc.token {
                        FontIcon.text(.ionicon(code: .md_checkmark_circle_outline), fontsize: 30)
                            .foregroundColor(Color.green)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 17)
            }
            .background{
                if qrVM.curFundSource.token == fundSrc.token {
                    Color.mutedBackground.opacity(0.6)
                }
            }
        }
    }
}

struct FundSourceView_Preview: PreviewProvider {
    static var previews: some View {
        QRView()
    }
}
