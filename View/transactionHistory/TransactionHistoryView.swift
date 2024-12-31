//
//  TransactionHistoryView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 25/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionHistoryView: View {
    @State private var isShowingTxDetails: Bool = false
    @State private var curTx: TransactionDetails = TransactionDetails()
    @State private var searchText = ""
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    HeaderView()
                    
                    SearchBarView(searchText: $searchText)
                        .padding(.top, 16)
                    
                    FilterView()
                        .padding(.top, 16)
                    
                    TransactionListView(isShowingTxDetails: $isShowingTxDetails, curTx: $curTx)
                        .padding(.top, 16)
                }
                .background(Color.white)
            }
            .padding(.top, .topInsets)
            
            TransactionDetailsView(isShowing: $isShowingTxDetails, txDetails: $curTx)
        }
    }
}

struct HeaderView: View {
    @StateObject var homeVM = HomeViewModel.shared
    var body: some View {
        HStack {
            HStack(spacing: 6) {
                FontIcon.button(.awesome5Solid(code: .chevron_left), action: {
                    homeVM.selectTab = 0
                },fontsize: 25)
                .padding(.vertical, 12)
                    .foregroundColor(.accent)
                
                Text("Lịch sử giao dịch")
                    .font(.title2)
                    .padding(.horizontal, 12)
            }
            
            Spacer()
            
            Image("merchantLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .cornerRadius(6)
                
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        .background(Color.white)
        .border(Color(red: 236/255, green: 237/255, blue: 243/255), width: 1)
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            SearchTextField(placholder: "Tìm kiếm", txt: $searchText)
                .padding(.horizontal, 0)
                .padding(.vertical, 5)
            Spacer()
            
            FontIcon.button(.ionicon(code: .md_list), action: {},fontsize: 25)
                .padding(12)
                .background(.ultraThinMaterial)
                .clipShape(.circle)
        }
        .padding(.vertical, 0)
        .padding(.horizontal, 20)
    }
}

struct FilterView: View {
    var body: some View {
        HStack {
            Text("Success")
                .font(.caption)
                .foregroundColor(.green)
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.green, lineWidth: 1)
                )
            
            Text("Pending")
                .font(.caption)
                .foregroundColor(.yellow)
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.yellow, lineWidth: 1)
                )
            
            Text("Failed")
                .font(.caption)
                .foregroundColor(.red)
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.red, lineWidth: 1)
                )
            
            Spacer()
            Divider()
            Spacer()
            
            HStack(spacing: 25) {
                Text("Cập nhật lần cuối 13:00")
                    .font(.caption)
                    .foregroundColor(Color(red: 51/255, green: 51/255, blue: 51/255))
            }
        }
        .padding(.horizontal, 20)
    }
}

struct TransactionListView: View {
    @Binding var isShowingTxDetails: Bool
    @Binding var curTx: TransactionDetails
    
    var txs = [
        TransactionDetails(amount: "40.000", traceNo: "489234", transDate: "12/12/24 10:45 AM", status: "Pending"),
        TransactionDetails(amount: "50.000", traceNo: "489236", transDate: "12/12/24 09:20 AM", status: "Success"),
        TransactionDetails(amount: "60.000", traceNo: "489236", transDate: "13/12/24 02:05 PM", status: "Success"),
        TransactionDetails(amount: "70.000", traceNo: "489237", transDate: "13/12/24 04:00 PM", status: "Failed"),
        TransactionDetails(amount: "45.000", traceNo: "489238", transDate: "13/12/24 09:04 PM", status: "Success"),
        TransactionDetails(amount: "80.000", traceNo: "489239", transDate: "14/12/24 09:12 AM", status: "Failed"),
        TransactionDetails(amount: "95.000", traceNo: "489240", transDate: "16/12/24 11:15 AM", status: "Success")
    ]
    
    var body: some View {
        VStack(spacing: 18) {
            ForEach(txs , id: \.id, content: {
                txObj in
                TransactionHistoryRow(isShowingTxDetails: $isShowingTxDetails, curTx: $curTx, txDetails: txObj)
            })
        }
        .padding(.horizontal, 16)
    }
}

struct TransactionHistoryRow: View {
    @Binding var isShowingTxDetails: Bool
    @Binding var curTx: TransactionDetails
    @State var txDetails: TransactionDetails = TransactionDetails()
    
    var statusColor: Color {
        switch txDetails.status {
            case "Success": return Color(hex: "32A64D")
            case "Pending": return Color(hex: "E4AC04")
            case "Failed": return Color(hex: "EE4540")
            default: return Color.black
        }
    }
    
    var body: some View {
        Button {
            isShowingTxDetails = true
            curTx = txDetails
        } label: {
            HStack(spacing: 8) {
                HStack(spacing: 8) {
                    VStack {
                        Text("01")
                            .font(.custom("Ubuntu-Bold", size: 17))
                        Text("Dec")
                            .font(.custom("Ubuntu-Regular", size: 10))
                            .padding(.top, 4)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .background(Color(red: 240/255, green: 242/255, blue: 245/255))
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text("ID: \(txDetails.traceNo)")
                            
                        HStack {
                            Text("Trạng thái: ")
                            
                            Text(txDetails.status)
                                .foregroundColor(statusColor)
                            
                            Spacer()
                        }
                        .font(.subheadline)
                        
                    }
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Text("\(txDetails.amount) đ")
                        .font(.custom("Ubuntu-Bold", size: 15))
                    
                    FontIcon.button(.ionicon(code: .md_return_left), action: {}, fontsize: 15)
                }
                
                Divider()
                    .background(Color(red: 240/255, green: 242/255, blue: 245/255))
            }
        }
        .foregroundColor(.black)
    }
}

#Preview {
    TransactionHistoryView()
}
