//
//  FundSourceListView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 24/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct FundSourceListView: View {
    @Binding var isShowing: Bool
    @StateObject var qrVM = QRViewModel.shared
    @State private var currHeight: CGFloat = 650
    
    let minHeight: CGFloat = 500
    let maxHeight: CGFloat = 750
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.foreground
                    .opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                
                mainView
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(.easeIn)
    }
    
    var mainView: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 50, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.0001))
            .gesture(dragGesture)
            
            ZStack {
                VStack {
                    HStack {
                        Text("Chọn tài khoản/thẻ")
                    }
//                    .padding(.horizontal, 20)
//                    .padding(.vertical, 17)
                    
                    // list of fund sources
                    ForEach(qrVM.fundSourceList , id: \.id, content: {
                        fsObj in
                        FundSourceView(isShowing: $isShowing, fundSrc: fsObj)
                    })
                    
                    HStack {
                        HStack {
                            Image(systemName: "plus.square.on.square.fill")
                                .foregroundColor(.accent)
                        }
                        .frame(width: 35, height: 12)
                        .padding(.vertical, 7)
                        .padding(.horizontal, 5)
                        
                        Text("Thêm nguồn tiền")
                            .foregroundColor(.accent)
                        
                        Spacer()
                        
                        FontIcon.text(.awesome5Solid(code: .chevron_right))
                            .foregroundColor(.accent)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 17)
                }
            }
//            .frame(maxHeight: .infinity)
            
            Spacer()
        }
        .frame(height: currHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: currHeight / 2)
            }
                .foregroundColor(.white)
        )
    }
    
    @State private var prevDragTransittion = CGSize.zero
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged {val in
                let dragAmount = val.translation.height - prevDragTransittion.height
                
                if currHeight > maxHeight || currHeight < minHeight {
                    currHeight -= dragAmount / 6
                } else {
                    currHeight -= dragAmount
                }
                
                if currHeight < minHeight {
                    isShowing = false
                    currHeight = 400
                }
                
                prevDragTransittion = val.translation
            }
            .onEnded {val in
                prevDragTransittion = .zero
            }
    }
}

#Preview {
    QRView()
}
