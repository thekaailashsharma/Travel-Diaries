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
                            .foregroundColor(Color.customColor(.green).opacity(0.4))
                        
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
                    .tabItem {
                        Text(CompleteProfileValues.name.rawValue)
                            .font(.customFont(.poppins, size: 25))
                            .foregroundStyle(.white)
                    }
                    .tag(CompleteProfileValues.name)
                    
                    PhotoPicker(path: "\(loginViewModel.userName)/profilePhoto/\(loginViewModel.userName).jpeg"){
                        currentProfileScreen = .gender
                    }
                    .environmentObject(storageManager)
                    .tabItem {
                        Text(CompleteProfileValues.name.rawValue)
                            .font(.customFont(.poppins, size: 25))
                            .foregroundStyle(.white)
                    }
                    .tag(CompleteProfileValues.profilePictureUrl)
                    
                    
                    
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation(.bouncy(duration: 1)) {
                                switch currentProfileScreen {
                                case .name:
                                    currentProfileScreen = .profilePictureUrl
                                case .profilePictureUrl:
                                    currentProfileScreen = .gender
                                case .gender:
                                    currentProfileScreen = .travelPreferences
                                case .travelPreferences:
                                    currentProfileScreen = .travelPhotos
                                case .travelPhotos:
                                    currentProfileScreen = .travelPreferences
                                case .travelQuestions:
                                    currentProfileScreen = .name
                                }
                            }
                        }) {
                            Image(systemName: "arrowtriangle.right.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .padding()
                                .foregroundColor(Color.customColor(.green))
                                .clipShape(Circle())
                                .shadow(radius: 3)
                        }
                    }
                    .padding()
                }
                .padding()
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
