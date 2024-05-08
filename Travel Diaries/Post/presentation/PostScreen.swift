//
//  PostScreen.swift
//  Travel Diaries
//
//  Created by Kailash on 08/05/24.
//

import SwiftUI
import PhotosUI

struct PostScreen: View {
    
    var onClick: () -> Void
    
    @EnvironmentObject var postViewModel: PostViewModel
    @EnvironmentObject var photoPicker: PhotoPickerViewController
    @FocusState var isKeyBoardActive: Bool
    @FocusState var isKeyBoardActive2: Bool
    @State var isLocationSearchOpen: Bool = false
    @State var isHashtagsOpen: Bool = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack {
                        Text("Posting to")
                            .font(.customFont(.poppins, size: 14))
                            .foregroundStyle(Color.customColor(.gray))
                            .padding(.leading)
                        Spacer()
                        Button {
                            isHashtagsOpen.toggle()
                        } label: {
                            Text(postViewModel.selectedHashtag == "" ? "Add hashtag" : postViewModel.selectedHashtag.truncate(length: 25))
                                .font(.customFont(.poppins, size: 14))
                                .foregroundStyle(Color.customColor(.yellow))
                                .padding(.trailing)
                        }
                    }
                    .padding(.top)
                    .padding(.bottom)
                    
                    HStack {
                        Text("Location")
                            .font(.customFont(.poppins, size: 14))
                            .foregroundStyle(Color.customColor(.gray))
                            .padding(.leading)
                        Spacer()
                        Button {
                            isLocationSearchOpen.toggle()
                        } label: {
                            Text(postViewModel.selectedLocation == "" ? "Add location" : postViewModel.selectedLocation.truncate(length: 25))
                                .font(.customFont(.poppins, size: 14))
                                .foregroundStyle(Color.customColor(.yellow))
                                .padding(.trailing)
                        }
                    }
                    .padding(.bottom)
                    
                    HStack {
                        Text("Add an Image")
                            .font(.customFont(.poppins, size: 14))
                            .foregroundStyle(Color.customColor(.gray))
                            .padding(.leading)
                        Spacer()
                        Button {
                            isHashtagsOpen.toggle()
                        } label: {
                            PhotosPicker(selection: $photoPicker.imageSelection, matching: .images) {
                                Text("Click to Add")
                                    .font(.customFont(.poppins, size: 14))
                                    .foregroundStyle(Color.customColor(.yellow))
                                    .padding(.trailing)
                            }
                        }
                    }
                    .padding(.bottom, 15)
                    
                    if let image = photoPicker.selectedImage {
                        
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customColor(.white), lineWidth: 1.0)
                            )
                            .frame(width: 150, height: 150)
                            .shadow(radius: 5)
                            .padding(.all, 25)
                        
                            
                    }
                    
                    HStack {
                        TextField(text: $postViewModel.title, label: {
                            Text("Title your travel memory")
                                .foregroundStyle(Color.customColor(.yellow))
                                .font(.customFont(.poppins, size: 15))
                                .padding()
                        })
                        .submitLabel(.go)
                        .keyboardType(.webSearch)
                        .focused($isKeyBoardActive)
                        .onSubmit {
                            withAnimation {
                                isKeyBoardActive = false
                                isKeyBoardActive2 = true
                            }
                        }
                        .font(.customFont(.poppins, size: 18))
                        .keyboardType(.numberPad)
                        .foregroundStyle(Color.customColor(.yellow))
                        .padding()
                        .background(.black.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.customColor(.green).opacity(0.5))
                        }
                        .padding()
                    }
                    
                    ZStack(alignment: .topLeading) {
    //                    HStack {
                            TextEditor(text: $postViewModel.description)
                                .lineSpacing(15)
                                .submitLabel(.go)
                                .keyboardType(.webSearch)
                                .focused($isKeyBoardActive2)
                                .onSubmit {
                                    withAnimation {
                                        isKeyBoardActive = false
                                        isKeyBoardActive2 = false
                                    }
                                }
                                .font(.customFont(.poppins, size: 14))
                                .keyboardType(.numberPad)
                                .foregroundStyle(Color.customColor(.white))
                                .padding()
                                .background(.black.opacity(0.6))
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.customColor(.green).opacity(0.5))
                                }
                                .frame(height: 300)
                        
                        if postViewModel.description.isEmpty && isKeyBoardActive2 == false {
                            VStack(alignment: .leading) {
                                Text("Cmon now describe your travel journey. Do u have an happening incident to share 🤔")
                                    .font(.customFont(.poppins, size: 14))
                                    .foregroundStyle(Color.customColor(.yellow))
                                    .padding(.trailing)
                                    .lineSpacing(15)
                                
                            }
                            .padding()
                        }
                        
                        VStack(alignment: .trailing) {
                            Spacer()
                            HStack {
                                Spacer()
                                Text(" \(postViewModel.description.count) / 300")
                                    .font(.customFont(.poppins, size: 14))
                                    .foregroundStyle(Color.customColor(.yellow))
                                    .padding(.trailing)
                                    .lineSpacing(15)
                            }
                            
                        }
                        .padding()
                    }
                    .padding()
                }
                .navigationTitle("Post a diary")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            photoPicker.removeSelection()
                            postViewModel.searchText = ""
                            postViewModel.description = ""
                            postViewModel.selectedHashtag = ""
                            postViewModel.selectedLocation = ""
                        }, label: {
                            Text("Cancel")
                                .font(.customFont(.poppins, size: 20))
                                .foregroundStyle(Color.customColor(.pink))
                                .padding()
                            
                        })
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            onClick()
                        }, label: {
                            Text("Post")
                                .font(.customFont(.poppins, size: 20))
                                .foregroundStyle(Color.customColor(.green))
                                .padding()
                            
                        })
                    }
            }
            }
        }
        .sheet(isPresented: $isLocationSearchOpen, content: {
            LocationSearchView(isVisible: $isLocationSearchOpen)
                .environmentObject(postViewModel)
        })
        .sheet(isPresented: $isHashtagsOpen, content: {
           HashTagsCard(isVisible: $isHashtagsOpen)
                .environmentObject(postViewModel)
        })
        .fullScreenCover(isPresented: $photoPicker.notAccessGranted) {
            PermissionsCard()
                .environmentObject(photoPicker)
        }
        .ignoresSafeArea()
    }
}

struct HashTagsCard: View {
    @Binding var isVisible: Bool
    @EnvironmentObject var postViewModel: PostViewModel
    var body: some View {
        List {
            ForEach(travelPreferences, id: \.self) { preference in
                Button {
                    postViewModel.selectedHashtag = preference
                    isVisible = false
                } label: {
                    
                    Text(preference)
                        .font(.customFont(.poppins, size: 14))
                        .foregroundStyle(Color.customColor(.white).opacity(0.6))
                        .padding()
                }
            }
            .listRowSeparator(.automatic)
            .listRowBackground(Color.black)
        }
    }
}

//#Preview {
//    NavigationStack {
//        PostScreen()
//            .environmentObject(PostViewModel())
//    }
//}
