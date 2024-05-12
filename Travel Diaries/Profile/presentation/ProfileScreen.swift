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
    
    @State var currentProfileState: ProfileTravelOptions = .about

    var body: some View {
        
        let _ = print("current user is \(String(describing: loginViewModel.currentUser))")
        NavigationStack {
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
                            ProfileFollowersCard(title: "0", value: "Followers", icon: "person.3.fill")
                            Spacer()
                            ProfileFollowersCard(title: "0", value: "Diaries", icon: "book.pages.fill")
                            Spacer()
                        }
                        .padding()
                        
                        HStack {
                            ForEach(ProfileTravelOptions.allCases, id: \.self) { value in
                                Button {
                                    withAnimation(.bouncy) {
                                        currentProfileState = value
                                    }
                                } label: {
                                    Text(value.rawValue)
                                        .font(.customFont(.poppins, size: 14))
                                        .foregroundStyle(Color.customColor(value == currentProfileState ? .green : .white))
                                        .padding()
                                }
                            }
                           
                        }
                        .padding()
                        
                        switch currentProfileState {
                        case .about:
                            VStack {
                                HStack {
                                    ProfilePreferencesCard(travelPreferences: currentUser.travelPreferences)
                                }
                                .padding()
                                
                                HStack {
                                    ProfileTravelQuestionsView(questions: currentUser.travelQuestions)
                                }
                                .padding()
                                .padding(.bottom, 30)
                                
                            }
                            
                            .transition(.slide.combined(with: .blurReplace))
                            .animation(.easeInOut, value: loginViewModel.currentProfileState)
                        case .posts:
                            if loginViewModel.userPosts.count == 0 {
                                VStack {
                                    ContentUnavailableView("No Posts Yet", systemImage: "person.2.crop.square.stack.fill")
                                        .foregroundStyle(.white)
                                        .background(Color.black)
                                }
                                .frame(height: 400)
                                .padding(.bottom, 50)
                                
                            } else {
                                UserPosts(posts: loginViewModel.userPosts)
                                    .padding()
                            }
                        case .comments:
                            EmptyView()
                        }
                        
                        Text("We create memories")
                            .font(.customFont(.poppins, size: 16))
                            .foregroundStyle(Color.customColor(.white))
                            .padding()
                            .padding(.bottom, 250)
                        
                        
                        
                    }
                } else {
                    ProgressView()
                        .foregroundStyle(Color.customColor(.green))
                }
            }
            .onAppear {
                loginViewModel.getAllPosts()
            }
            .navigationTitle("Profile")
        }
    }
}

enum ProfileTravelOptions : String, CaseIterable {
    case about = "About Me"
    case posts = "Posts"
    case comments = "Comments"
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

struct ProfilePreferencesCard : View {
    var travelPreferences: [String]
    var body: some View {
        VStack {
            Text("Loves ❤️")
                .font(.customFont(.poppins, size: 20))
                .foregroundStyle(Color.customColor(.pink))
                .padding(.bottom, 10)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 25) {
                    ForEach(travelPreferences, id: \.self) { preference in
                        Text(preference)
                            .font(.customFont(.poppins, size: 8))
                            .foregroundStyle(.white)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customColor(.white))
                            }
                        
                    }
                }
            }
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.customColor(.green).opacity(0.6))
                .glow()
        }
        .frame(width: UIScreen.main.bounds.width - 50)
        .padding()
        
          
    }
}

struct ProfileTravelQuestionsView: View {
    
    var questions: [MyTravelQuestions]
    
    var body: some View {
        VStack() {
                        
                        Text("Who Am I ?")
                            .font(.customFont(.poppins, size: 20))
                            .foregroundStyle(Color.customColor(.pink))
                            .padding(.bottom, 10)
            VStack {
                ForEach(questions, id: \.self) { questions in
                    VStack() {
                        Text(questions.question)
                            .font(.customFont(.poppins, size: 20))
                            .foregroundStyle(Color.customColor(.green))
                            .padding(.bottom)
                        
                        Text(questions.answer)
                            .font(.customFont(.poppins, size: 16))
                            .foregroundStyle(Color.customColor(.white))
                            .padding(.bottom)
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 50)
                    
                }
//                .listRowSeparator(.automatic)
//                .listRowBackground(Color.black)
            }
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.customColor(.green).opacity(0.6))
                .glow()
        }
//        .frame(width: UIScreen.main.bounds.width - 50)
        .padding()
        
    }
}

struct UserPosts: View {
    
    let posts: [PostsModel]
    
    var body: some View {
        //        List {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)], spacing: 0) {
                ForEach(posts, id: \.id) { post in
                    NavigationLink {
                        DetailedPostsScreen(post: post)
                    } label: {
                        ZStack {
                            AsyncImage(url: URL(string: post.imageUrl ?? "")) { image in
                                image
                                    .resizable()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                            } placeholder: {
                                ProgressView()
                                    .foregroundStyle(Color.customColor(.green))
                            }
                            
                        }
                        .frame(width: 100, height: 100)
                        .border(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .overlay {
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.customColor(.white).opacity(0.6))
                        }
                    }

                   
                }
            }
        }
    }
//    }
}

#Preview {
    ProfileScreen()
        .environmentObject(LoginViewModel())
}
