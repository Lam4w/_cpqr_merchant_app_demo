//
//  CardView.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 11/09/2024.
//

import SwiftUI
import SwiftUIFontIcon

struct CardView: View {
    var body: some View {
        VStack {
            ScrollView{
                Group{
                    TabView{
                        ForEach(sampleCards,id: \.self){card in
                            CreditCardView(creditCard: card)
                                .padding(.bottom,50)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(height: 280)
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
                .padding(.horizontal,0)
                .padding(.vertical, 0)
                
                //                AddCreditCardView()
                //                    .padding(.bottom, 0)
                
                //                Rectangle()
                //                    .fill(.regularMaterial)
                //                    .frame(height: 8)
                //                    .padding(.bottom, 16)
                
                //                Group{
                //                    VStack(alignment: .leading,spacing: 8){
                //                        Text("Payment Methods")
                //                            .font(.headline)
                //                            .fontWeight(.bold)
                //                        ForEach(sampleCards,id:\.self){card in
                //
                //                            Button{
                //
                //                            }label: {
                //                                HStack(spacing: 8){
                //                                    Image(card.crediCardType.imageName)
                //                                        .resizable()
                //                                        .scaledToFit()
                //                                        .frame(width: 32,height: 32)
                //                                        .padding(6)
                //                                        .background(.ultraThinMaterial)
                //                                        .clipShape(.circle)
                //
                //                                    Text("\(card.crediCardType.imageName.capitalized) \(card.cardNumber)")
                //                                        .font(.subheadline)
                //                                        .fontWeight(.light)
                //
                //                                    Spacer()
                //                                    FontIcon.text(.awesome5Solid(code: .chevron_right),fontsize: 16,color:.gray)
                //                                }
                //
                //                            }
                ////                            .foregroundStyle(.primary)
                //                            .padding(.horizontal,6)
                //                            .padding(.vertical, 12)
                //                            .frame(maxWidth: .infinity,alignment: .leading)
                //                            Divider()
                //                        }
                //
                //                        Button{
                //
                //                        }label:{
                //                            Text("+ Add a New Way to Pay")
                ////                                .foregroundColor(.primary)
                //                                .font(.subheadline)
                //                                .fontWeight(.light)
                //                                .padding(6)
                //                                .cornerRadius(4)
                //                        }
                //                        .padding(.horizontal,8)
                //                        .background(.regularMaterial)
                //                        .clipShape(.capsule)
                //                    }
                //
                //
                //                    .padding(.horizontal,24)
                //
                //                }
                //                .padding(.bottom,16)
                //                Rectangle()
                //                    .fill(.regularMaterial)
                //                    .frame(height: 8)
                //                    .padding(.bottom,16)
            }
        }
    }
}

struct ActionCreditCardButtonView: View {
    let icon : FontAwesomeCode
    var body: some View {
        FontIcon.button(.awesome5Solid(code: icon), action: {},fontsize: 12)
            .padding(8)
            .background(.ultraThinMaterial)
            .clipShape(.circle)
    }
}

struct CreditCardView: View {
    
    let creditCard: CardModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: 16){
            HStack{
//                Image(creditCard.crediCardType.imageName)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 80,height: 80)
//                    .clipped()
                Spacer()
                VStack{
                    HStack{
                        ActionCreditCardButtonView(icon: .pencil_alt)
                        ActionCreditCardButtonView(icon: .trash)
                    }
                    Text(creditCard.bankName)
                        .font(.caption)
                        .fontWeight(.light)
//                        .foregroundStyle(.secondary)
                    
                }
                .frame(height: 80)
            }
            
            HStack{
//                Spacer()
                Text(creditCard.cardNumber)
                    .font(.title)
                    .fontWeight(.regular)
                Spacer()
            }
            HStack(spacing: 8){
                VStack(alignment: .leading){
                    Text("Place holder Name")
                        .font(.callout)
                        .fontWeight(.light)
//                        .foregroundStyle(.secondary)
                    
                    Text(creditCard.cardHolderName)
                        .font(.headline)
                        .fontWeight(.regular)
                }
                Spacer()
//                VStack(alignment: .leading){
//                    Text("Expire Date")
//                        .font(.callout)
//                        .fontWeight(.light)
////                        .foregroundStyle(.secondary)
//                    
//                    Text(creditCard.expirationDate)
//                        .font(.headline)
//                        .fontWeight(.regular)
//                }
                HStack {
                    Image(creditCard.crediCardType.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .clipped()
                }

            }
        }
        .foregroundColor(.white)
        .padding()
        .background(
            LinearGradient(gradient: creditCard.crediCardType.gradient, startPoint: .leading, endPoint: .trailing)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.gray.opacity(0.5),lineWidth: 1.5)
                )
        )
        .cornerRadius(16)
        .padding(.horizontal, 0)
        .padding(.top,8)
    }
}

struct AddCreditCardView: View {
    var body: some View {
        Button{
            
        }label: {
            Text("+ Add Card")
//                .foregroundColor(.primary)
                .font(.title3)
                .fontWeight(.light)
                .padding(12)
                .cornerRadius(4)
        }
        .frame(maxWidth: .infinity)
        .background(.regularMaterial)
        .clipShape(.capsule)
        .padding(.horizontal, 0)
    }
}

#Preview {
    CardView()
}
