//
//  HomeScreen.swift
//  Travel Diaries
//
//  Created by Kailash on 09/05/24.
//

import SwiftUI

struct ProfileScreen: View {
    
    @AppStorage("sessionPhoneNumber") var sessionPhoneNumber: String = ""
    @AppStorage("sessionUserName") var sessionUserName: String = ""
    @EnvironmentObject var loginViewModel: LoginViewModel
    

    var body: some View {
        
        let _ = print("current user is \(String(describing: loginViewModel.currentUser))")
        
        ScrollView(showsIndicators: false) {
            if let currentUser = loginViewModel.currentUser {
                VStack {
                    ZStack {
                        AsyncImage(url: URL(string: currentUser.profilePictureUrl ?? "")) { image in
                            image
                                .resizable()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                               
                        } placeholder: {
                            ProgressView()
                                .foregroundStyle(Color.customColor(.green))
                        }
                        
                        VStack {
                            Spacer()
                            HStack {
                                AsyncImage(url: URL(string: currentUser.profilePictureUrl ?? "")) { image in
                                    image
                                        .resizable()
                                        .frame(width: 60, height: 50)
                                        .clipShape(Circle())
                                        .glow(color: .customColor(.green), radius: 1)
                                    
                                } placeholder: {
                                    ProgressView()
                                        .foregroundStyle(Color.customColor(.green))
                                }
                                
                                Spacer()
                            }
                            .padding()
                            
                            
                            HStack {
                                Text("@\(currentUser.userName)")
                                    .font(.customFont(.poppins, size: 14))
                                    .foregroundStyle(Color.customColor(.white))
                                    .padding(.bottom)
                                Spacer()
                                Text("\(currentUser.name)")
                                    .font(.customFont(.poppins, size: 14))
                                    .foregroundStyle(Color.customColor(.white))
                                    .padding(.bottom)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 100, height: 500)
                    .padding(.top , 70)
                    .glow()
                    .padding()
                    
                    HStack {
                        Spacer()
                        ProfileFollowersCard(title: "0", value: "Views", icon: "globe.asia.australia")
                        Spacer()
                        Spacer()
                        ProfileFollowersCard(title: "0", value: "Followers", icon: "person.3.fill")
                        Spacer()
                        Spacer()
                        ProfileFollowersCard(title: "0", value: "Diaries", icon: "book.pages.fill")
                        Spacer()
                    }
                    .padding()
                    
                   
                    

                }
            } else {
                ProgressView()
                    .foregroundStyle(Color.customColor(.green))
            }
        }
    }
}

struct ProfileFollowersCard: View {
    
    var title: String
    var value: String
    var icon: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon)
                    .resizable()
                    .frame(width: 25, height: 25)
                Text(title)
                    .font(.customFont(.poppins, size: 14))
                    .foregroundStyle(Color.customColor(.white))
                    
                
            }
            .padding()
            
            Text(value)
                .font(.customFont(.poppins, size: 14))
                .foregroundStyle(Color.customColor(.white))
                .padding()
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay{
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.customColor(.gray))
                .shadow(color: .customColor(.gray), radius: 5)
        }
       
    }
}

#Preview {
    ProfileScreen()
        .environmentObject(LoginViewModel())
}
