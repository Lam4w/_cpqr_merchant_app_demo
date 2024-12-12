import SwiftUI

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                HeaderView()
                
                // Overview Card
                OverviewCard()
                
                // Settlement Card
                SettlementCard()
                
                // Recent Transactions
                TransactionListView()
                
                // Accept Payment Button
                AcceptPaymentButton()
            }
            .padding()
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("9:41")
                    .font(.custom("Ubuntu-Bold", size: 13))
                
                Spacer()
                
                HStack(spacing: 4) {
                    AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/f5580ffafdceeae8f3fd079ec2922b6903e2c18b04d9a3bf8242356a4eb8095a?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(width: 17, height: 10)
                    
                    AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/5f527610712aa27e326f8ef03c334dfac2b96b8138034f4b378c7054a0bdd2cf?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(width: 15, height: 10)
                    
                    AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/fdaa997da4a109f30f907baa6c721a6235bb09d97a28cfe1136ff691f0d27d4b?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(width: 24, height: 10)
                }
            }
            
            HStack {
                AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/aee8d6e7e1172616e96a87f4fc57f35f20ef8b30e2096b49f7bb444028807aa3?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 32, height: 32)
                
                Text("Merchant App")
                    .font(.custom("Ubuntu-Bold", size: 13))
                
                Spacer()
                
                AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/2a0440364f56cc642f634e81cae89efabd4c27ea2462d77cd543ec7bc5afd017?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 24, height: 24)
            }
        }
    }
}

struct OverviewCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Overview of")
                    .foregroundColor(Color(.systemGray))
                
                Button(action: {}) {
                    HStack {
                        Text("Today, 22 Sep")
                            .foregroundColor(Color(hex: "1C3FCA"))
                        
                        AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/8895e2d04c1c38c7c9cde4557c5b7777985f7fbbf549854f92abc8187830109f?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 16, height: 16)
                    }
                }
            }
            .font(.custom("Ubuntu-Bold", size: 14))
            
            HStack(spacing: 40) {
                VStack(alignment: .leading) {
                    Text("Total Amount")
                        .font(.custom("Ubuntu-Regular", size: 12))
                        .foregroundColor(Color(.systemGray))
                    
                    Text("₹ 5,000")
                        .font(.custom("Ubuntu-Bold", size: 28))
                }
                
                VStack(alignment: .leading) {
                    Text("No of Transactions")
                        .font(.custom("Ubuntu-Regular", size: 12))
                        .foregroundColor(Color(.systemGray))
                    
                    Text("1200")
                        .font(.custom("Ubuntu-Bold", size: 28))
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "ECEDF3"), lineWidth: 2)
        )
    }
}

struct SettlementCard: View {
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Settlement Overview")
                    .font(.custom("Ubuntu-Bold", size: 16))
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("₹ 11,000")
                        .font(.custom("Ubuntu-Bold", size: 16))
                    
                    Text("Pending Settlement")
                        .foregroundColor(Color(.systemGray))
                        .font(.custom("Ubuntu-Bold", size: 14))
                    
                    Text("Next Settlement : 02/02/22")
                        .font(.custom("Ubuntu-Regular", size: 10))
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12) {
                Button(action: {}) {
                    HStack {
                        Text("View all")
                            .foregroundColor(Color(hex: "1C3FCA"))
                        
                        AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/7ccafad46297f8abce39af82b66db2b8fe48d4ffd2279ca8de80dc338f70433e?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 24, height: 24)
                    }
                }
                .font(.custom("Ubuntu-Bold", size: 14))
                
                Text("₹ 5,000")
                    .font(.custom("Ubuntu-Bold", size: 16))
                
                Text("Last Settlement")
                    .foregroundColor(Color(.systemGray))
                    .font(.custom("Ubuntu-Bold", size: 14))
                
                Text("Settled On : 01/02/22")
                    .font(.custom("Ubuntu-Regular", size: 10))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "ECEDF3"), lineWidth: 2)
        )
    }
}

struct TransactionListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Transactions")
                    .font(.custom("Ubuntu-Bold", size: 20))
                
                Spacer()
                
                Button(action: {}) {
                    HStack {
                        Text("View all")
                            .foregroundColor(Color(hex: "1C3FCA"))
                        
                        AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/7ccafad46297f8abce39af82b66db2b8fe48d4ffd2279ca8de80dc338f70433e?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp")) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 24, height: 24)
                    }
                }
                .font(.custom("Ubuntu-Bold", size: 14))
            }
            
            ForEach(0..<3) { index in
                TransactionRow(
                    name: ["Akshat", "Wilson _Chettiar", "Sankeerth_Goud"][index],
                    status: ["Success", "Pending", "Failed"][index],
                    amount: ["30.00", "40.00", "40.00"][index]
                )
                
                Divider()
                    .background(Color(hex: "F0F2F5"))
            }
        }
    }
}

struct TransactionRow: View {
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
            VStack {
                Text("01")
                    .font(.custom("Ubuntu-Bold", size: 17))
                Text("Sep")
                    .font(.custom("Ubuntu-Regular", size: 10))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .background(Color(hex: "F0F2F5"))
            .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(name)
                    .font(.custom("Ubuntu-Bold", size: 14))
                
                HStack(spacing: 4) {
                    Text("ID: #2211312324")
                        .foregroundColor(Color(.systemGray))
                    
                    if status != "Pending" {
                        Text(status)
                            .foregroundColor(statusColor)
                    }
                }
                .font(.custom("Ubuntu-Regular", size: 12))
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("₹ \(amount)")
                    .font(.custom("Ubuntu-Bold", size: 15))
                
                AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/6fdcd52cd12cbdb7b771adf61fd433b0240092b386e0c367d3b59cf249708f86?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 16, height: 16)
            }
        }
    }
}

struct AcceptPaymentButton: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                AsyncImage(url: URL(string: "https://cdn.builder.io/api/v1/image/assets/TEMP/a34281c149556074a136af0b6c2fe1fe6cb166cfb32c1c2ed05b167c307e038c?placeholderIfAbsent=true&apiKey=3e8497d6b2d94ab5bd8e89f5d9ba1c41&format=webp")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 20, height: 20)
                
                Text("Accept Payment")
                    .font(.custom("Ubuntu-Bold", size: 17))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color(hex: "1C3FCA"))
            .cornerRadius(24)
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}