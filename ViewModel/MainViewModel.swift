//
//  MainViewModel.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

class MainViewModel: ObservableObject {
    static var share: MainViewModel = MainViewModel()
    
    @Published var title: String = ""
    @Published var txtId: String = ""
    @Published var txtPassword: String = ""
    @Published var isUserLogin: Bool = false
    
    //todo: api handling
    func logIn() {
        self.setData()
    }
    
    func setData() {
        self.isUserLogin = true
        print(self.isUserLogin)
    }
}
