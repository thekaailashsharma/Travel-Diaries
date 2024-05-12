//
//  LocationSearchView.swift
//  Travel Diaries
//
//  Created by Kailash on 09/05/24.
//

import SwiftUI
import SwiftData

struct LocationSearchView: View {
    
    @Binding var isVisible: Bool
    @EnvironmentObject var postViewModel: PostViewModel
    @FocusState var isKeyBoardActive: Bool
    
    @Query private var searchItems: [LocationSearchHistory]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
        VStack {
            HStack {
                TextField(text: $postViewModel.searchText, label: {
                    Text("Search Locations")
                        .font(.customFont(.poppins, size: 15))
                        .padding()
                })
                .submitLabel(.go)
                .keyboardType(.webSearch)
                .focused($isKeyBoardActive)
                .onSubmit {
                    search(location: postViewModel.searchText)
                    withAnimation {
                        isKeyBoardActive = false
                    }
                }
                .font(.customFont(.poppins, size: 18))
                .keyboardType(.numberPad)
                .foregroundStyle(.white)
                .padding()
                .background(.black.opacity(0.6))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.customColor(.green).opacity(0.5))
                }
                .padding()
                
            }
            .padding([.top], 15)
            ProgressView()
                .foregroundStyle(Color.customColor(.gray))
                .opacity(postViewModel.isSearching ? 1 : 0)
            
            List {
                switch postViewModel.searchResponse {
                case .success(let locationResponse):
                    if locationResponse.items?.count != 0 {
                        ForEach(locationResponse.items ?? [], id: \.self) { location in
                            Button {
                                Task {
                                    if let address = location.address?.label {
                                        saveLocation(item: LocationSearchHistory(
                                            date: Date(),
                                            latitude: location.position?.lat ?? 0.0,
                                            longitude: location.position?.lng ?? 0.0,
                                            address: address)
                                        )
                                        postViewModel.selectedLocation = address
                                        postViewModel.location = Location(address: address, coordinate: Coordinate(latitude: location.position?.lat ?? 0.0, longitude: location.position?.lng ?? 0.0))
                                        isVisible = false
                                    }
                                }
                            } label: {
                                Text(location.address?.label ?? "")
                                    .font(.customFont(.poppins, size: 15))
                                    .foregroundStyle(Color.customColor(.green).opacity(0.5))
                                    .padding()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .listRowSeparator(.automatic)
                        .listRowBackground(Color.black)
                    } else {
                        VStack {
                            Spacer()
                            ContentUnavailableView.search
                            Spacer()
                        }
                        .frame(maxHeight: .infinity)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.black)
                    }
                case .error(let _):
                    VStack {
                        Spacer()
                        ContentUnavailableView(
                            "Something Went Wrong",
                            systemImage: "face.smiling"
                        )
                        Spacer()
                    }
                    .frame(maxHeight: .infinity)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.black)
                case .none:
                    if searchItems.count != 0 {
                        ForEach(searchItems, id: \.id) { searchHistory in
                            Button {
                                search(location: searchHistory.address)
                            } label: {
                                Text(searchHistory.address)
                                    .font(.customFont(.poppins, size: 15))
                                    .foregroundStyle(Color.customColor(.green).opacity(0.5))
                                    .padding()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .listRowSeparator(.automatic)
                        .listRowBackground(Color.black)
                    } else {
                        VStack {
                            Spacer()
                            ContentUnavailableView(
                                "Start Typing",
                                systemImage: "rectangle.and.hand.point.up.left.filled"
                            )
                            Spacer()
                        }
                        .frame(maxHeight: .infinity)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.black)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            
        }
    }
    
    func search(location: String) {
        postViewModel.fetchLocation(for: location)
    }
    
    func saveLocation(item: LocationSearchHistory) {
        if !searchItems.contains(where: {$0.address == item.address}) {
            modelContext.insert(item)
        }
        
    }
    
}
    

//#Preview {
//    LocationSearchView()
//        .environmentObject(PostViewModel())
//}
