//
//  TravelPreferncesCard.swift
//  Travel Diaries
//
//  Created by Kailash on 07/05/24.
//

import SwiftUI

struct TravelPreferncesCard: View {
    
    var onClick: () -> Void
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Select upto \(loginViewModel.preferencesList.count) / 8 preferences")
                        .font(.customFont(.poppins, size: 20))
                        .foregroundStyle(Color.customColor(.green))
                        .padding()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    Spacer()
                }
                .padding(.leading, 15)
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 25) {
                        ForEach(travelPreferences, id: \.self) { preference in
                            Button {
                                toggleTravelPreference(preference, in: &loginViewModel.preferencesList)
                            } label: {
                                Text(preference)
                                    .font(.customFont(.poppins, size: 10))
                                    .foregroundStyle(.white)
                                    .padding()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.customColor(containsValue(preference: preference) ? .green : .gray))
                                    }
                            }
                        }
                    }
                }
                .padding()
                .frame(maxHeight: UIScreen.main.bounds.height - 300, alignment: .top)
            }
           
            
            VStack {
                Spacer()
                
                Button {
                    onClick()
                } label: {
                    Text("So much. Next pls 😮‍💨")
                        .font(.customFont(.poppins, size: 20))
                        .foregroundStyle(Color.customColor(.white))
                        .padding()
                        .frame(width: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customColor(.green))
                        }
                }
                .padding(.bottom, 10)
            }
        }
    }
    
    func containsValue(preference: String) -> Bool {
        return loginViewModel.preferencesList.contains(preference)
    }
    
    func toggleTravelPreference(_ preference: String, in preferencesList: inout [String]) {
        if let index = preferencesList.firstIndex(of: preference) {
            // Preference found, remove it
            preferencesList.remove(at: index)
        } else {
            if preferencesList.count < 8 {
                preferencesList.append(preference)
            }
        }
    }
}

#Preview {
    TravelPreferncesCard(onClick: {
        
    })
    .environmentObject(LoginViewModel())
}

