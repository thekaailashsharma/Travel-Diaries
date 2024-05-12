//
//  SlackAnimation.swift
//  Digital Greeting Card
//
//  Created by Admin on 05/03/24.
//

import SwiftUI
import Foundation
import SwiftUI

func initNavigation(navBarAppearence: UINavigationBarAppearance, bgColor: UIColor, fgColor: UIColor) {
    navBarAppearence.configureWithOpaqueBackground()
    navBarAppearence.backgroundColor = UIColor.init(Color(uiColor: bgColor))
    
    navBarAppearence.titleTextAttributes = [
        .foregroundColor: UIColor.init(Color(uiColor: fgColor))
    ]
    navBarAppearence.largeTitleTextAttributes = [
        .foregroundColor : UIColor.init(Color(uiColor: fgColor))
    ]
    
    UINavigationBar.appearance().standardAppearance = navBarAppearence
    UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearence
}

struct PostsScreen: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    init() {
        initNavigation(navBarAppearence: UINavigationBarAppearance(), bgColor: .black, fgColor: .white)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                ForEach(loginViewModel.allPosts, id: \.id) { post in
                    NavigationLink {
                        DetailedPostsScreen(post: post)
                    } label: {
                        CardsView(post: post) {
                            
                        }
                    }

                    
                }
            }
            .navigationTitle("Posts")
        }
        
    }
    
    
}


struct CardsView: View {
    
    var post: PostsModel
    var onDelete: () -> Void
    
    @State private var offset = CGSize.zero
    @State private var color: Color = .black
    
    
    var body: some View {
        VStack {
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
            .frame(width: UIScreen.main.bounds.width - 50, height: 500)
            .padding(.top , 70)
            .glow()
            .padding()
            
            HStack() {
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.customColor(.gray))
                
                Image(systemName: "message.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.customColor(.gray))
                
                Image(systemName: "square.and.arrow.up.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.customColor(.gray))
                Spacer()
            }
            .padding(.vertical, 4)
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    AsyncImage(url: URL(string: post.user.profilePictureUrl ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .glow(color: .customColor(.green), radius: 1)
                        
                    } placeholder: {
                        ProgressView()
                            .foregroundStyle(Color.customColor(.green))
                    }
                    .padding(.all, 4)
                    
                    Text(post.title)
                        .font(.customFont(.poppins, size: 18))
                        .foregroundStyle(Color.customColor(.white))
                    
                    
                    HStack {
                        Spacer()
                        Text(post.location.address.truncate(length: 45))
                            .font(.customFont(.poppins, size: 10))
                            .foregroundStyle(Color.customColor(.white))
                    }
                        
                        
                    
                    
                }
                
                
                Text(post.description.truncate(length: 100))
                    .font(.customFont(.poppins, size: 10))
                    .foregroundStyle(Color.customColor(.white))
                    .padding([.top])
                
                HStack {
                    Spacer()
                    Text(post.timeStamp.formatted())
                        .font(.customFont(.poppins, size: 10))
                        .foregroundStyle(Color.customColor(.white))
                        .padding(.bottom)
                }
                
            }
            
        }
        .frame(width: UIScreen.main.bounds.width - 50)
        
        
        
        
        
        
    }
    
    
}

#Preview(body: {
    NavigationStack {
        PostsScreen()
            .environmentObject(LoginViewModel())
    }
})

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: offset * 0.5,y: offset * 1.5)
    }
}
