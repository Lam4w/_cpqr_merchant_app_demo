//
//  FundSourceListView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 24/12/24.
//

import SwiftUI

struct FundSourceListView: View {
    @Binding var isShowing: Bool
    @StateObject var QrVM = QRViewModel.shared()
    @State private var currHeight: CGFloat = 400
    
    let minHeight: CGFloat = 400
    let maxHeight: CGFloat = 580
    
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
                    .frame(width: 40, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.0001))
            .gesture(dragGesture)
            
            ZStack {
                VStack {
                    // list of fund sources
                    ForEach(QrVM.fundSourceList , id: \.id, content: {
                        fsObj in
                        FundSourceView(isShowing: $isShowing, fundSrc: fsObj)
                    })
                    
                    // FundSourceView(isSelected: true)
                    // Divider()
                    // FundSourceView(isSelected: false)
                    // Divider()
                    // FundSourceView(isSelected: false)
                }
            }
            .frame(maxHeight: .infinity)
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
                
//                if currHeight < minHeight {
//                    isShowing = false
//                }
                
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
