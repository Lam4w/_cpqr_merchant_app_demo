//
//  InputField.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

struct InputField: View {
    @State var title: String = ""
    @State var placeHolder: String = ""
    @Binding var txt: String
    
    var body: some View {
        VStack{
            Text(title)
                .foregroundColor(.black)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, alignment:  .leading)
            
            TextField(placeHolder, text: $txt)
                .keyboardType(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
                .disableAutocorrection(true)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                .frame(height: 40)
                .font(.title3)
            
            Divider()
        }
    }
}

//#Preview {
//    InputField()
//}
