//
//  PostScreen.swift
//  Travel Diaries
//
//  Created by Kailash on 08/05/24.
//

import SwiftUI

struct PostScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .navigationTitle("Post a diary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        
                    }, label: {
                        Text("Cancel")
                            .font(.customFont(.poppins, size: 20))
                            .foregroundStyle(.white)
                            .padding()
                            .frame(width: 300)
                            .background(Color.customColor(.pink).opacity(0.5))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white.opacity(0.5))
                            }
                        
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        
                    }, label: {
                        Text("Post")
                            .font(.customFont(.poppins, size: 20))
                            .foregroundStyle(.white)
                            .padding()
                            .frame(width: 300)
                            .background(Color.customColor(.blue))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.white.opacity(0.5))
                            }
                        
                    })
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        PostScreen()
    }
}
