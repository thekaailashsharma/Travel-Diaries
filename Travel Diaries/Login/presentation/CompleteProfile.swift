//
//  CompleteProfile.swift
//  Travel Diaries
//
//  Created by Kailash on 01/05/24.
//

import SwiftUI
import PhotosUI

struct CompleteProfileView: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @EnvironmentObject var storageManager: StorageManager
    @State private var name: String = ""
    @State var isUsernameTaken: Bool = false
    @State private var currentProfileScreen: CompleteProfileValues = .name
    @State private var selection = 0
    
    @State var selectedImage: UIImage? = nil
    @State var date: Date? = nil
    @State var location: CLLocationCoordinate2D? = nil
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $currentProfileScreen) {
                    VStack {
                        
                        Image(systemName: "person.badge.shield.checkmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .foregroundColor(Color.customColor(.green).opacity(0.6))
                        
                        CustomTextField(textValue: $loginViewModel.userName, keyboardType: .default, label: "Enter Username") {
                            if loginViewModel.allUsersNames.contains(where: {$0.userName == name}) {
                                isUsernameTaken = true
                            } else {
                                isUsernameTaken = false
                                withAnimation(.bouncy(duration: 1)) {
                                    currentProfileScreen = .profilePictureUrl
                                }
                            }
                        }
                        
                        Text(isUsernameTaken ? "Username Not Available" : "Username Available")
                            .font(.customFont(.poppins, size: 15))
                            .foregroundStyle(isUsernameTaken ? .red : .green)
                        
                        
                    }
                    .tag(CompleteProfileValues.name)
                    
                    PhotoPicker(path: "\(loginViewModel.userName)/profilePhoto/\(loginViewModel.userName).jpeg"){
                        currentProfileScreen = .gender
                    }
                    .environmentObject(storageManager)
                    .tag(CompleteProfileValues.profilePictureUrl)
                    
                    GenderCard() {
                        withAnimation(.bouncy(duration: 1)) {
                            currentProfileScreen = .travelPreferences
                        }
                    }
                    .environmentObject(loginViewModel)
                    .tag(CompleteProfileValues.gender)
                    
                    TravelPreferncesCard() {
                        withAnimation(.bouncy(duration: 1)) {
                            currentProfileScreen = .travelPhotos
                        }
                    }
                    .environmentObject(loginViewModel)
                    .tag(CompleteProfileValues.travelPreferences)
                    
                    
                    
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
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


//#Preview {
//    CompleteProfile()
//}
