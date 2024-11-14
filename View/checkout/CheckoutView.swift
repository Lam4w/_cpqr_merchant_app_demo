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
    @State private var amount: String
    
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
                    TextField("Nhập số tiền", value: $amount, format: .currency(code: "VND"))
                        .keyboardType(.numberPad)
                        .disableAutocorrection(true)
                        .frame(height: 40)
                        .font(.title3)
                        .focused($focusField, equals: .textEdit)
                        .onChange(of: currentText) { newValue in
                            // Remove commas from the input
                            let cleanedText = newValue.replacingOccurrences(of: ",", with: "")
                            
                            // Check if the cleaned text can be converted to a number
                            if let number = Int(cleanedText) {
                                // Format the number with commas as thousands separators
                                let formattedText = formatWithCommas(number: number)
                                // Update the current text with the formatted version
                                if formattedText != currentText {
                                    currentText = formattedText
                                }
                            } else {
                                // If the input is not a valid number, reset to empty
                                currentText = ""
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
                        
                        FontIcon.text(.ionicon(code: .md_pricetag),fontsize: 23, color: .blue)
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
                VStack {
                    Text("Bằng cách tiếp tục, bạn đồng ý với")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        Text("Điều khoản dịch vụ")
                            .font(.subheadline)
                            .foregroundColor(.black)
                        
                        Text("và")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text("Chính sách bảo mật.")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.vertical, .screenWidth * 0.03)
                
                RoundedButton(title: "Quét mã QR") {
                    checkoutVM.isShowScanner = true
//                    checkoutVM.showTransactionConfirmation = true
                }
                .padding(.bottom, .bottomInsets + 80)
            }
            
        }
        .padding(.top, .topInsets)
        .padding(.horizontal, 20)
        .frame(width: .screenWidth, height: .screenHeight)
        .background(.white)
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

    // Function to format numbers with commas as thousands separators
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
