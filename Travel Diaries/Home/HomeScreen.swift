//
//  HomeScreen.swift
//  Travel Diaries
//
//  Created by Kailash on 09/05/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @AppStorage("sessionPhoneNumber") var sessionPhoneNumber: String = ""
    @AppStorage("sessionUserName") var sessionUserName: String = ""
    
    var body: some View {
        Text("Hello World \(sessionUserName) & \(sessionPhoneNumber)")
    }
}

#Preview {
    HomeScreen()
}
