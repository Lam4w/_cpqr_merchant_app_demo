////
////  CartView.swift
////  cpqr_merchant_demo
////
////  Created by Macbook on 07/08/2024.
////
//
//import SwiftUI
//
//struct CartView: View {
//    @StateObject var cartVM = CartViewModel.shared
//    var body: some View {
//        ZStack{
//            
//            if(cartVM.listArr.count == 0) {
//                Text("You Card is Empty")
//                    .font(.title)
//                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//            }
//            
//            ScrollView{
//                LazyVStack {
//                    ForEach( cartVM.listArr , id: \.id, content: {
//                        cObj in
//                        CartItem(cObj: cObj)
//                    })
//                    .padding(.vertical, 8)
//                }
//                .padding(20)
//                .padding(.top, .topInsets + 46)
//                .padding(.bottom, .bottomInsets + 60)
//                
//            }
//            
//            
//            VStack {
//                
//                HStack{
//                    
//                    Spacer()
//                    
//                    Text("Giỏ hàng")
//                        .font(.title)
//                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                        .frame(height: 46)
//                    Spacer()
//                    
//                }
//                .padding(.top, .topInsets)
//                .background(Color.white)
//                .shadow(color: Color.black.opacity(0.2),  radius: 2 )
//                
//                Spacer()
//                
//                if(cartVM.listArr.count > 0) {
//                    Button {
//                        cartVM.showCheckout = true
//                    } label: {
//                        ZStack {
//                            Text("Thanh toán")
//                                .font(.title2)
//                                .foregroundColor(.white)
//                                .multilineTextAlignment(.center)
//                            
////                            HStack {
////                                Spacer()
////                                Text("\(cartVM.total)")
////                                    .font(.title3)
////                                    .foregroundColor(.white)
////                                    .padding(.horizontal, 8)
////                                    .padding(.vertical, 4)
////                                    .background(Color.gray.opacity(0.2))
////                                    .cornerRadius(5)
////                            }
////                            .padding(.trailing)
//                        }
//                        
//                    }
//                    .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
//                    .background(.blue)
//                    .cornerRadius(20)
//                    .padding(.horizontal, 20)
//                    .padding(.bottom, .bottomInsets + 80)
//                }
//                
//            }
//            if(cartVM.showCheckout) {
//                Color.black
//                    .opacity(0.3)
//                    .ignoresSafeArea()
//                    .onTapGesture {
//                        withAnimation {
//                            cartVM.showCheckout = false
//                        }
//                    }
//                
//                CheckoutView(isShow: $cartVM.showCheckout )
//                    .transition(.opacity.combined(with: .move(edge: .bottom)))
//            }
//        }
//        .onAppear{
//            cartVM.getCartItemList()
//        }
////        .background( NavigationLink(destination: OrderView(), isActive: $cartVM.showOrderAccept  , label: {
////            EmptyView()
////        }) )
////        .alert(isPresented: $cartVM.showError, content: {
////            Alert(title: Text(Globs.AppName), message: Text(cartVM.errorMessage), dismissButton: .default(Text("OK")) )
////        })
//        .animation(.easeInOut, value: cartVM.showCheckout)
//        .ignoresSafeArea()
//    }
//}
//
//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            CartView()
//        }
//        
//    }
//}
