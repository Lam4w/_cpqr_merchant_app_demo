//
//  TransactionHistoryView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 25/12/24.
//

import SwiftUI

struct TransactionHistoryView: View {
    @State private var searchText = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                StatusBarView()
                
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
                AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/7b7f949f3fc13b823c6c38bf1c5105d23030534ba50c00f5dd4289afc450b22c?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp"))
                    .frame(width: 24, height: 24)
                AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/592d1fe65db31deb51406e44b03e16000db63a8abfd76514bbcd4b6593fdfd36?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp"))
                    .frame(width: 32, height: 33)
            }
            
            Spacer()
            
            Text("Transaction History")
                .font(.custom("Ubuntu-Bold", size: 16))
                .letterSpacing(0.02)
            
            AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/69c2cf2c2ed4be32a544acaf3ee96b7d905c655352f6333087c7739da914cdce?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp"))
                .frame(width: 24, height: 24)
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
            HStack {
                AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/7736715df06e864ed9beabb4912b585f5114da8bd8226b0325d3f936cee96552?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp"))
                    .frame(width: 24, height: 24)
                
                TextField("Search", text: $searchText)
                    .font(.custom("Ubuntu-Regular", size: 17))
                    .foregroundColor(Color(red: 175/255, green: 174/255, blue: 175/255))
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(red: 240/255, green: 242/255, blue: 245/255))
            .cornerRadius(8)
        }
        .padding(.horizontal, 16)
    }
}

struct FilterView: View {
    var body: some View {
        HStack {
            Text("Success")
                .font(.custom("Ubuntu-Regular", size: 12))
                .foregroundColor(Color(red: 45/255, green: 183/255, blue: 128/255))
                .padding(.horizontal, 8)
                .padding(.vertical, 3)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color(red: 45/255, green: 183/255, blue: 128/255), lineWidth: 1)
                )
            
            Spacer()
            
            HStack(spacing: 25) {
                Text("Failed")
                    .font(.custom("Ubuntu-Regular", size: 12))
                    .foregroundColor(Color(red: 240/255, green: 107/255, blue: 5/255))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(red: 240/255, green: 107/255, blue: 5/255), lineWidth: 1)
                    )
                
                Text("Last Updated At 13:00")
                    .font(.custom("Ubuntu-Bold", size: 12))
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
            HStack(spacing: 8) {
                HStack(spacing: 8) {
                    VStack {
                        Text("01")
                            .font(.custom("Ubuntu-Bold", size: 17))
                        Text("Sep")
                            .font(.custom("Ubuntu-Regular", size: 10))
                            .padding(.top, 4)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .background(Color(red: 240/255, green: 242/255, blue: 245/255))
                    .cornerRadius(8)
                    
                    VStack(alignment: .leading) {
                        Text("Wilson _Chettiar")
                            .font(.custom("Ubuntu-Bold", size: 14))
                        Text("ID: #2211312324")
                            .font(.custom("Ubuntu-Regular", size: 12))
                            .foregroundColor(Color(red: 175/255, green: 174/255, blue: 175/255))
                            .padding(.top, 10)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 4) {
                    Text("₹40.00")
                        .font(.custom("Ubuntu-Bold", size: 15))
                    AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/6fdcd52cd12cbdb7b771adf61fd433b0240092b386e0c367d3b59cf249708f86?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp"))
                        .frame(width: 16, height: 16)
                }
            }
            
            Divider()
                .background(Color(red: 240/255, green: 242/255, blue: 245/255))
        }
    }
}
