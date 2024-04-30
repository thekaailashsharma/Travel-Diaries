//
//  CompleteProfile.swift
//  Travel Diaries
//
//  Created by Kailash on 01/05/24.
//

import SwiftUI

struct CompleteProfile: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @State var name: String = ""
    @State var currentProfileScreen: CompleteProfileValues = .name
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    switch currentProfileScreen {
                    case .name:
                        CustomTextField(textValue: $name, keyboardType: .default, label: "Ok") {
                            
                        }
                    case .profilePictureUrl:
                        CustomTextField(textValue: $name, keyboardType: .default, label: "Ok") {
                            
                        }
                    case .gender:
                        CustomTextField(textValue: $name, keyboardType: .default, label: "Ok") {
                            
                        }
                    case .travelPreferences:
                        CustomTextField(textValue: $name, keyboardType: .default, label: "Ok") {
                            
                        }
                    case .travelPhotos:
                        CustomTextField(textValue: $name, keyboardType: .default, label: "Ok") {
                            
                        }
                    case .travelQuestions:
                        CustomTextField(textValue: $name, keyboardType: .default, label: "Ok") {
                            
                        }
                    }
                    Spacer()
                    
                }
                
                
            }
            .navigationTitle(currentProfileScreen.rawValue)
        }
    }
}

enum CompleteProfileValues: String {
    case name = "Name"
    case profilePictureUrl = "Profile Picture"
    case gender = "Gender"
    case travelPreferences = "Travel Preferences"
    case travelPhotos = "Add some Photos"
    case travelQuestions = "More About You"
}


#Preview {
    CompleteProfile()
}
