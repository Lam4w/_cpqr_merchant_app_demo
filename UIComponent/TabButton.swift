//
//  T.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI
import SwiftUIFontIcon

struct TabButton: View {
    @State var title: String = "Title"
    @State var icon : IonIconsCode = .md_home
    var isSelect: Bool = false
    var selected: (()->())
    
    var body: some View {
        Button {
            selected()
        } label: {
            VStack (spacing: 2){
                FontIcon.text(.ionicon(code: icon),fontsize: 35)
                    .padding(0)
                
                Text(title)
                    .font(.system(size: 12))
                
                if (isSelect) {
                    VStack {
                        
                    }
                    .padding(3)
                    .background(Color.accent)
                    .foregroundColor(.accent)
                    .clipShape(.circle)
                }
            }
        }
        .foregroundColor(isSelect ? .accent : .foreground )
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton {
            print("Test")
        }
    }
}
