//
//  BetaCheckoutView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 11/09/2024.
//

import SwiftUI
import SwiftUIFontIcon
import CodeScanner

struct CheckoutView: View {
    @StateObject var checkoutVM = CheckoutViewModel.shared
    @State var amount: String = ""
    
    private enum Field: Int {
        case textEdit
    }
    
    @FocusState private var focusField: Field?

    var body: some View {
        VStack{
            VStack{
                Text("Thông tin giao dịch")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                    .padding(.bottom, 5)
                
                Text("Vui lòng điền đầy đủ thông tin")
                    .font(.title3)
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.black)
                
                HStack{
                    TextField("Nhập số tiền", text: $amount)
                        .keyboardType(.numberPad)
                        .disableAutocorrection(true)
                        .frame(height: 40)
                        .font(.title3)
                        .focused($focusField, equals: .textEdit)
                        .onChange(of: amount) {
                            let cleanedText = amount.replacingOccurrences(of: ",", with: "")
                            if let number = Int(cleanedText) {
                                let formattedText = formatWithCommas(number: number)
                                if formattedText != amount {
                                    amount = formattedText
                                }
                            } else {
                                amount = ""
                            }
                        }
                    
                    Text("VND")
                        .foregroundColor(.black)
                        .font(.title3)
                        .frame(minWidth: 50, maxWidth: 50, alignment:  .leading)
                }
                
                Divider()
                
                VStack{
                    HStack {
                        Text("Phương thức thanh toán")
                            .font(.title3)
                            .foregroundColor(.black)
                            .frame(height: 46)
                        
                        Spacer()
                        
                        Image(systemName: "qrcode.viewfinder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 20)
                    }
                    Divider()
                }
                
                NavigationLink{
                    
                } label: {
                    HStack{
                        Spacer()
                        
                        FontIcon.text(.ionicon(code: .md_pricetag),fontsize: 23, color: .accent)
                            .padding(5)
                        
                        Text("Thêm nội dung thanh toán")
                            .foregroundColor(.black.opacity(0.6))
                            .underline()
                    }
                }
            }
            
            Spacer()
            //                .frame(height: 280)
            VStack{
//                VStack {
//                    Text("Bằng cách tiếp tục, bạn đồng ý với")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                    
//                    HStack{
//                        Text("Điều khoản dịch vụ")
//                            .font(.subheadline)
//                            .foregroundColor(.black)
//                        
//                        Text("và")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                        
//                        Text("Chính sách bảo mật.")
//                            .font(.subheadline)
//                            .foregroundColor(.black)
//                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                    }
//                }
//                .padding(.vertical, .screenWidth * 0.03)
                HStack {
                    FontIcon.text(.awesome5Solid(code: .shield_alt), fontsize: 18)
                        .foregroundColor(.green)
                    
                    Text("Giao dịch này được đảm bảo bởi")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    
                    Image("napas")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 18)
                        .padding(.horizontal, 5)
                        .padding(.top, 3)
                }
                
                RoundedButton(title: "Quét mã QR") {
                    if amount.isEmpty {
                        checkoutVM.showError = true
                        checkoutVM.errorMessage = "Amount can not be empty"
                    } else {
                        checkoutVM.total = amount
                        checkoutVM.isShowScanner = true
//                        checkoutVM.showTransactionConfirmation = true
                    }
                }
                .padding(.bottom, .bottomInsets + 80)
            }
        }
        .padding(.top, .topInsets)
        .padding(.horizontal, 20)
        .frame(width: .screenWidth, height: .screenHeight)
        .background(.white)
        .ignoresSafeArea(.keyboard)
        .sheet(isPresented: $checkoutVM.isShowScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "test data", completion: checkoutVM.handleScan)
        }
        .background(NavigationLink(destination: PaymentConfirmationView(), isActive: $checkoutVM.showTransactionConfirmation  , label: {
            EmptyView()
        }) )
        .alert(isPresented: $checkoutVM.showError) {
            Alert(title: Text("Error"), message: Text(checkoutVM.errorMessage), dismissButton: .default(Text("OK")))
        }
        .onTapGesture {
            if (focusField != nil) {
                focusField = nil
            }
        }
    }

    private func formatWithCommas(number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}

#Preview {
    CheckoutView()
}
