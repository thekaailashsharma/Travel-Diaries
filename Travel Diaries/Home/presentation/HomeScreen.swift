//
//  HomeScreen.swift
//  Travel Diaries
//
//  Created by Kailash on 11/05/24.
//

import SwiftUI
import TabBarModule

struct HomeScreen: View {
    
    @EnvironmentObject var postViewModel: PostViewModel
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject var photoPickerViewController = PhotoPickerViewController()
    
    @State var tabSelection: Int = 0
    @State var isPost: Bool = false
    
    var body: some View {
        
        TabBar(selection: $tabSelection, visibility: .constant(.automatic)) {
            PostsScreen()
                .tabItem(0) {
                    Image(systemName: tabSelection == 0 ? "house.fill" : "house")
                        .font(.title3)
                    Text("Home")
                        .font(.system(.footnote, design: .rounded).weight(tabSelection == 0 ? .bold : .medium))
                        .foregroundStyle(Color.customColor(tabSelection == 0 ? .green : .gray))
                }
                .tag(2)
            
            CreatePostScreen(onClick: {
                
            })
            .environmentObject(postViewModel)
            .environmentObject(loginViewModel)
            .environmentObject(photoPickerViewController)
            .tabItem(1) {
                Image(systemName: tabSelection == 1 ? "plus.app.fill" : "plus")
                    .font(.title3)
                Text("Create")
                    .font(.system(.footnote, design: .rounded).weight(tabSelection == 1 ? .bold : .medium))
                    .foregroundStyle(Color.customColor(tabSelection == 1 ? .green : .gray))
            }
            .tag(2)
            
            ProfileScreen()
                .tabItem(2) {
                    Image(systemName: tabSelection == 2 ? "person.fill" : "person")
                        .font(.title3)
                    Text("Profile")
                        .font(.system(.footnote, design: .rounded).weight(tabSelection == 2 ? .bold : .medium))
                        .foregroundStyle(Color.customColor(tabSelection == 2 ? .green : .gray))
                }
                .tag(2)
            
            
        }
        .tabBarPadding(.vertical, 8)
        .tabBarPadding(.horizontal, 16)
        .tabBarShape(Capsule(style: .continuous))
        .tabBarFill(.linearGradient(
            colors: [.black, .black.opacity(0.4)],
            startPoint: .top, endPoint: .bottom))
        .tabBarShadow(radius: 1, y: 2)
        .tabBarTransition(.slide.combined(with: .opacity))
        .tabBarAnimation { isTabBarVisible in
            isTabBarVisible ? .easeInOut : .linear
        }
        //            VStack {
        //                Spacer()
        //                HStack {
        //                    Spacer()
        //                    NavigationLink {
        //                        PostsScreen()
        //                    } label: {
        //                        TabButton(image: "house.fill", title: "Home") {
        //                            tabSelection = 1
        //                        }
        //                    }
        //
        //                    Spacer()
        //                    NavigationLink {
        //                        CreatePostScreen(onClick: {
        //
        //                        })
        //                        .environmentObject(postViewModel)
        //                        .environmentObject(loginViewModel)
        //                        .environmentObject(photoPickerViewController)
        //                    } label: {
        //                        TabButton(image: "plus.app.fill", title: "Create") {
        //                            tabSelection = 1
        //                        }
        //                    }
        //
        //                    Spacer()
        //                    NavigationLink {
        //                        ProfileScreen()
        //                    } label: {
        //                        TabButton(image: "person.fill", title: "Profile") {
        //                            tabSelection = 1
        //                        }
        //                    }
        //
        //                    Spacer()
        //
        //
        //                }
        //            }
        //        TabView(selection: $tabSelection) {
        //
        //            PostsScreen()
        //                .tabItem {
        //                    Text("Posts")
        //                        .font(.customFont(.poppins, size: 13))
        //                        .foregroundStyle(Color.customColor(tabSelection == 0 ? .green : .gray))
        //                }
        //                .tag(0)
        //
        //            CreatePostScreen(onClick: {
        //
        //            })
        //            .environmentObject(postViewModel)
        //            .environmentObject(loginViewModel)
        //            .environmentObject(photoPickerViewController)
        //            .tabItem {
        //                Text("Create")
        //                    .font(.customFont(.poppins, size: 13))
        //                    .foregroundStyle(Color.customColor(tabSelection == 1 ? .green : .gray))
        //            }
        //            .tag(2)
        //
        //            ProfileScreen()
        //                .tabItem {
        //                    Text("Profile")
        //                        .font(.customFont(.poppins, size: 13))
        //                        .foregroundStyle(Color.customColor(tabSelection == 2 ? .green : .gray))
        //                }
        //                .tag(2)
        //        }
        .onAppear {
            loginViewModel.getAllPosts()
            loginViewModel.getAllUsers()
            loginViewModel.getAllUserNames()
        }
    }
}

struct TabButton: View {
    
    var image: String
    var title: String
    var onClick: () -> Void
    
    
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: image)
                    .resizable()
                    .frame(width: 25, height: 25)
                
                Text(title)
                    .font(.customFont(.poppins, size: 14))
            }
        }
        
    }
}
//}
//}

#Preview {
    HomeScreen()
}
