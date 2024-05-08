//
//  AddPosts.swift
//  Travel Diaries
//
//  Created by Kailash on 09/05/24.
//

import SwiftUI

struct AddPosts: View {
    var body: some View {
        VStack {
            HStack {
                Text("")
                    .font(.customFont(.poppins, size: 20))
                    .foregroundStyle(Color.customColor(.green))
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
            }
            .padding(.leading, 15)
        }
    }
}

#Preview {
    AddPosts()
}
