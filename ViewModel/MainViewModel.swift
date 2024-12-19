//
//  MainViewModel.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    
    @Published var title: String = ""
    @Published var txtId: String = ""
    @Published var txtPassword: String = ""
    @Published var isUserLogin: Bool = false
    @Published var isMerchant: Bool = false
    
    //todo: api handling
    func logIn() {
        self.setData()
    }
    
    func setData() {
        print("id field: \(txtId)")
        if self.txtId == "merchant" || self.txtId == "2" {
            self.isMerchant = true
        }
        self.isUserLogin = true
    }
}
