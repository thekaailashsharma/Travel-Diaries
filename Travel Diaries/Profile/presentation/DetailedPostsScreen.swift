//
//  DetailedPostsScreen.swift
//  Travel Diaries
//
//  Created by Kailash on 12/05/24.
//

import SwiftUI

struct DetailedPostsScreen: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    @Binding var post: PostsModel
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    AsyncImage(url: URL(string: post.imageUrl ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    } placeholder: {
                        ProgressView()
                            .foregroundStyle(Color.customColor(.green))
                    }
                    
                }
                .frame(width: UIScreen.main.bounds.width - 100, height: 250)
                .border(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.customColor(.white).opacity(0.6))
                }
                
                if post.comments.count != 0 {
                    ForEach(post.comments, id: \.id) { comment in
                        Button {
                            
                        } label: {
                            VStack {
                                
                            }
                        }

                    }
                }
            }
        }
    }
}
