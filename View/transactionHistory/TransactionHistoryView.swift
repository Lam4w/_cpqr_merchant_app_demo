//
//  TransactionHistoryView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 25/12/24.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionHistoryView: View {
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HeaderView()
                
                SearchBarView(searchText: $searchText)
                    .padding(.top, 16)
                
                FilterView()
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                
                TransactionListView()
                    .padding(.top, 16)
            }
            .background(Color.white)
        }
    }
}

struct StatusBarView: View {
    var body: some View {
        HStack {
            Text("9:41")
                .font(.custom("Ubuntu-Bold", size: 13))
            
            Spacer()
            
            HStack(spacing: 4) {
                AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/f5580ffafdceeae8f3fd079ec2922b6903e2c18b04d9a3bf8242356a4eb8095a?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp"))
                    .frame(width: 17, height: 10)
                AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/5f527610712aa27e326f8ef03c334dfac2b96b8138034f4b378c7054a0bdd2cf?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp"))
                    .frame(width: 15, height: 10)
                AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/fdaa997da4a109f30f907baa6c721a6235bb09d97a28cfe1136ff691f0d27d4b?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp"))
                    .frame(width: 24, height: 10)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            HStack(spacing: 6) {
                FontIcon.button(.awesome5Solid(code: .chevron_left), action: {},fontsize: 25)
                    .padding(12)
                    .foregroundColor(.accent)
                
                Text("Lịch sử giao dịch")
                    .font(.title2)
            }
            
            Spacer()
            
            Image("merchantLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .cornerRadius(6)
                
        }
        .padding(.horizontal, 14)
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
        .padding(.horizontal, 16)
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
    }
}

struct TransactionListView: View {
    var body: some View {
        VStack(spacing: 18) {
            ForEach(0..<2) { _ in
                TransactionItemView()
            }
        }
        .padding(.horizontal, 16)
    }
}

struct TransactionItemView: View {
    var body: some View {
        VStack(spacing: 16) {
            ForEach(0..<3) { index in
                TransactionHistoryRow(
                    name: ["Đơn hàng #2211312326", "Đơn hàng #2211312325", "Đơn hàng #2211312324"][index],
                    status: ["Success", "Pending", "Failed"][index],
                    amount: ["30.000", "40.000", "40.000"][index]
                )
            }
        }
    }
}

struct TransactionHistoryRow: View {
    let name: String
    let status: String
    let amount: String
    
    var statusColor: Color {
        switch status {
            case "Success": return Color(hex: "32A64D")
            case "Pending": return Color(hex: "E4AC04")
            case "Failed": return Color(hex: "EE4540")
            default: return Color.black
        }
    }
    
    var body: some View {
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
                    Text(name)
                        .font(.custom("Ubuntu-Bold", size: 14))
                    Text(status)
                        .foregroundColor(statusColor)
                }
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("\(amount) đ")
                    .font(.custom("Ubuntu-Bold", size: 15))
                
                FontIcon.button(.ionicon(code: .md_return_left), action: {}, fontsize: 15)
            }
            
            Divider()
                .background(Color(red: 240/255, green: 242/255, blue: 245/255))
        }
    }
}

#Preview {
    TransactionHistoryView()
}
