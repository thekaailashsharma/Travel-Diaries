//
//  DetailedPostsScreen.swift
//  Travel Diaries
//
//  Created by Kailash on 12/05/24.
//

import SwiftUI
import MapKit

struct DetailedPostsScreen: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    var post: PostsModel
    @State var textValue: String = ""
    @State var comments: [Comment] = []
    
    
    @FocusState var isKeyBoardActive
    
    var body: some View {
            ScrollView {
                VStack {
                    HStack {
                        Map() {
                            Annotation(post.location.address, coordinate: CLLocationCoordinate2D(latitude: post.location.coordinate?.latitude ?? 0.0, longitude: post.location.coordinate?.longitude ?? 0.0)) {
                                AsyncImage(url: URL(string: post.user.profilePictureUrl ?? "")) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(Circle())
                                    
                                } placeholder: {
                                    ProgressView()
                                        .foregroundStyle(Color.customColor(.green))
                                }
                                .frame(width: 30, height: 30)
                            }

                        }
                        .frame(height: 300)
                        .padding(.bottom, 40)
                        
                    }
                    
                    
                    
                    ZStack {
                        AsyncImage(url: URL(string: post.imageUrl ?? "")) { image in
                            image
                                .resizable()
                               
                                .clipShape(RoundedRectangle(cornerRadius: 10))
//                                .frame(width: UIScreen.main.bounds.width, height: 250)
                            
                        } placeholder: {
                            ProgressView()
                                .foregroundStyle(Color.customColor(.green))
                        }
                        
                    }
                    .frame(width: UIScreen.main.bounds.width - 100, height: 450)
                   

                    
                    if post.comments.count != 0 {
                        VStack {
                            ForEach(comments, id: \.id) { comment in
                                VStack {
                                    Button {
                                        
                                    } label: {
                                        VStack(alignment: .leading) {
                                            HStack(alignment: .center) {
                                                AsyncImage(url: URL(string: comment.user.profilePictureUrl ?? "")) { image in
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
                                                
                                                Text(comment.user.name)
                                                    .font(.customFont(.poppins, size: 18))
                                                    .foregroundStyle(Color.customColor(.white))
                                            }
                                            
                                            
                                            Text(comment.content)
                                                .font(.customFont(.poppins, size: 10))
                                                .foregroundStyle(Color.customColor(.white))
                                                .padding([.top])
                                            
                                            HStack {
                                                Spacer()
                                                Text(comment.timestamp.formatted())
                                                    .font(.customFont(.poppins, size: 10))
                                                    .foregroundStyle(Color.customColor(.white))
                                                    .padding(.bottom)
                                            }
                                            
                                        }
                                    }
                                    
                                    if comment.replies.count > 0 {
                                        Spacer()
                                        
                                        VStack(alignment: .leading) {
                                            HStack(alignment: .center) {
                                                AsyncImage(url: URL(string: comment.user.profilePictureUrl ?? "")) { image in
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
                                                
                                                Text(comment.user.name)
                                                    .font(.customFont(.poppins, size: 18))
                                                    .foregroundStyle(Color.customColor(.white))
                                            }
                                            
                                            
                                            Text(comment.content)
                                                .font(.customFont(.poppins, size: 10))
                                                .foregroundStyle(Color.customColor(.white))
                                                .padding([.top])
                                            
                                            HStack {
                                                Spacer()
                                                Text(comment.timestamp.formatted())
                                                    .font(.customFont(.poppins, size: 10))
                                                    .foregroundStyle(Color.customColor(.white))
                                                    .padding(.bottom)
                                            }
                                            
                                        }
                                    }
                                }
                                
                                
                            }
                        }
                        .padding(.bottom, 80)
                        
                    }
                    else {
                        
                        ContentUnavailableView("No Comments Yet", systemImage: "person.2.crop.square.stack.fill")
                            .foregroundStyle(.white)
                            .background(Color.black)
                            .padding(.bottom, 100)
                        
                    }
                    
                }
            }
            .onAppear(perform: {
                comments = post.comments
                initNavigation(navBarAppearence: UINavigationBarAppearance(), bgColor: .black, fgColor: .white)
            })
             .background(Color.black)
             .overlay {
                 VStack {
                     Spacer()
                     HStack {
                         AsyncImage(url: URL(string: post.user.profilePictureUrl ?? "")) { image in
                             image
                                 .resizable()
                                 .scaledToFill()
                                 .clipShape(Circle())
                             
                         } placeholder: {
                             ProgressView()
                                 .foregroundStyle(Color.customColor(.green))
                         }
                         .frame(width: 30, height: 30)
                         .padding(.horizontal, 4)
                         
                         HStack {
                             TextField(text: $textValue, label: {
                                 Text("Add a comment")
                                     .font(.customFont(.poppins, size: 15))
                                     .padding()
                             })
                             .submitLabel(.go)
                             .keyboardType(.default)
                             .focused($isKeyBoardActive)
                             .onSubmit {
                                 isKeyBoardActive = false
                                
                             }
                             .font(.customFont(.poppins, size: 18))
                             .keyboardType(.numberPad)
                             .foregroundStyle(.white)
                             .padding()
                             .background(.black.opacity(0.6))
                             .clipShape(RoundedRectangle(cornerRadius: 20))
                             .overlay {
                                 RoundedRectangle(cornerRadius: 20)
                                     .stroke(.white.opacity(0.5))
                             }
                         }
                         .padding(.horizontal, 4)
                         
                         Button {
                             Task {
                                 var commentsList = post.comments
                                 commentsList.append(Comment(id: UUID().uuidString, user: post.user, timestamp: Date(), content: textValue, replies: []))
                                 try? await loginViewModel.updatePost(
                                    post: PostsModel(user: post.user, timeStamp: post.timeStamp, title: post.title, description: post.description, location: post.location, likes: post.likes, comments: commentsList, imageUrl: post.imageUrl, impressions: post.impressions)
                                    
                                 )
                                 comments = commentsList
                                 isKeyBoardActive = false
                                 textValue = ""
                             }
                         } label: {
                             Image(systemName: "paperplane.fill")
                                 .resizable()
                                 .frame(width: 30, height: 30)
                         }
                         .padding(.horizontal, 4)
                     }
                     .clipShape(RoundedRectangle(cornerRadius: 25))
                     .padding(.bottom)
                 }
                 .padding()
                 .padding(.bottom, 80)
                 
             }
             
            
           
            
        }
}
